import { CreateDriverPositionDto } from './dto/create_driver_position.dto';
import { DriversPositionService } from './drivers_position.service';
export declare class DriversPositionController {
    private driversPositionService;
    constructor(driversPositionService: DriversPositionService);
    create(driversPosition: CreateDriverPositionDto): Promise<boolean>;
    getDriverPosition(id_driver: number): Promise<{
        id_driver: any;
        lat: any;
        lng: any;
    }>;
    getNearbyDrivers(client_lat: number, client_lng: number): Promise<any>;
    delete(id_driver: number): Promise<import("typeorm").DeleteResult>;
}
