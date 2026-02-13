import { CreateDriverCarInfoDto } from './dto/create_driver_car_info.dto';
import { DriverCarInfoService } from './driver_car_info.service';
export declare class DriverCarInfoController {
    private driverCarInfoService;
    constructor(driverCarInfoService: DriverCarInfoService);
    findByIdDriver(id_driver: number): Promise<import("./driver_car_info.entity").DriverCarInfo>;
    create(driverCarInfo: CreateDriverCarInfoDto): Promise<import("./driver_car_info.entity").DriverCarInfo>;
}
