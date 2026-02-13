import { DriverCarInfo } from './driver_car_info.entity';
import { Repository } from 'typeorm';
import { CreateDriverCarInfoDto } from './dto/create_driver_car_info.dto';
export declare class DriverCarInfoService {
    private driverCarInfoRepository;
    constructor(driverCarInfoRepository: Repository<DriverCarInfo>);
    create(driverCarInfo: CreateDriverCarInfoDto): Promise<DriverCarInfo>;
    findByIdDriver(id_driver: number): Promise<DriverCarInfo>;
}
