"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DriversPositionService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const drivers_position_entity_1 = require("./drivers_position.entity");
const typeorm_2 = require("typeorm");
let DriversPositionService = class DriversPositionService {
    constructor(driversPositionRepository) {
        this.driversPositionRepository = driversPositionRepository;
    }
    async create(driverPosition) {
        try {
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
        }
        catch (error) {
            console.log('Error creando/actualizando la posicion del conductor', error);
            return false;
        }
    }
    async getDriverPosition(id_driver) {
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
    async getNearbyDrivers(client_lat, client_lng) {
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
    delete(id_driver) {
        return this.driversPositionRepository.delete(id_driver);
    }
};
DriversPositionService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(drivers_position_entity_1.DriversPosition)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], DriversPositionService);
exports.DriversPositionService = DriversPositionService;
//# sourceMappingURL=drivers_position.service.js.map