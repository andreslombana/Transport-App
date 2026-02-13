import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DriversPosition } from './drivers_position.entity';
import { Repository } from 'typeorm';
import { CreateDriverPositionDto } from './dto/create_driver_position.dto';

@Injectable()
export class DriversPositionService {

    constructor(
        @InjectRepository(DriversPosition) private driversPositionRepository: Repository<DriversPosition>
    ) {}

    async create(driverPosition: CreateDriverPositionDto) {
        try {
            // SOLUCIÓN: Usamos una sola consulta atómica (UPSERT).
            // Si el ID ya existe, actualiza la posición. Si no existe, lo crea.
            // Esto evita el error de "Duplicate entry" por condiciones de carrera.
            const query = `
                INSERT INTO drivers_position(id_driver, position)
                VALUES(
                    ${driverPosition.id_driver},
                    ST_GeomFromText('POINT(${driverPosition.lng} ${driverPosition.lat})', 4326)
                )
                ON DUPLICATE KEY UPDATE
                    position = ST_GeomFromText('POINT(${driverPosition.lng} ${driverPosition.lat})', 4326)
            `;

            await this.driversPositionRepository.query(query);            
            return true;    

        } catch (error) {
            console.log('Error creando/actualizando la posicion del conductor', error);
            return false;    
        }
    }

    async getDriverPosition(id_driver: number) {
        const driverPosition = await this.driversPositionRepository.query(`
            SELECT
                *
            FROM
                drivers_position
            WHERE
                id_driver = ${id_driver}
        `);

        if (!driverPosition || driverPosition.length === 0) {
            return null;
        }

        return {
            'id_driver': driverPosition[0].id_driver,
            'lat': driverPosition[0].position.y,
            'lng': driverPosition[0].position.x,
        };
    }

    async getNearbyDrivers(client_lat: number, client_lng: number) {
        const driversPosition = await this.driversPositionRepository.query(`
            SELECT
                id_driver,
                position,
                ST_Distance_Sphere(position, ST_GeomFromText('POINT(${client_lng} ${client_lat})', 4326)) AS distance
            FROM
                drivers_position
            HAVING distance <= 5000
        `);
        return driversPosition;
    }

    delete(id_driver: number) {
        return this.driversPositionRepository.delete(id_driver);
    }

}