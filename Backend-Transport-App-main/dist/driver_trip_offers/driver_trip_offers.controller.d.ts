import { DriverTripOffersService } from './driver_trip_offers.service';
import { CreateDriverTripOffersDto } from './dto/create_driver_trip_offers.dto';
import { SocketGateway } from 'src/socket/socket.gateway';
export declare class DriverTripOffersController {
    private driverTripOffersService;
    private socketGateway;
    constructor(driverTripOffersService: DriverTripOffersService, socketGateway: SocketGateway);
    findByClientRequest(id_client_request: number): Promise<any>;
    create(driverTripOffer: CreateDriverTripOffersDto): Promise<import("./driver_trip_offers.entity").DriverTripOffers>;
}
