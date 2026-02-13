import { DriversPosition } from './drivers_position.entity';
import { Repository } from 'typeorm';
import { CreateDriverPositionDto } from './dto/create_driver_position.dto';
export declare class DriversPositionService {
    private driversPositionRepository;
    constructor(driversPositionRepository: Repository<DriversPosition>);
    create(driverPosition: CreateDriverPositionDto): Promise<boolean>;
    getDriverPosition(id_driver: number): Promise<{
        id_driver: any;
        lat: any;
        lng: any;
    }>;
    getNearbyDrivers(client_lat: number, client_lng: number): Promise<any>;
    delete(id_driver: number): Promise<import("typeorm").DeleteResult>;
}
