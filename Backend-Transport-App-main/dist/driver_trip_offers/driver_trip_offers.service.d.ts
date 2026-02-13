import { DriverTripOffers } from './driver_trip_offers.entity';
import { Repository } from 'typeorm';
import { CreateDriverTripOffersDto } from './dto/create_driver_trip_offers.dto';
export declare class DriverTripOffersService {
    private driverTripOffersRepository;
    constructor(driverTripOffersRepository: Repository<DriverTripOffers>);
    create(driverTripOffer: CreateDriverTripOffersDto): Promise<DriverTripOffers>;
    findByClientRequest(id_client_request: number): Promise<any>;
}
