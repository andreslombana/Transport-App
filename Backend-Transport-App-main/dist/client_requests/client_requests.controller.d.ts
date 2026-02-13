import { ClientRequestsService } from './client_requests.service';
import { CreateClientRequestDto } from './dto/create_client_request.dto';
import { UpdateDriverAssignedClientRequestDto } from './dto/update_driver_assigned_client_request.dto';
import { UpdateStatusClientRequestDto } from './dto/update_status_client_request.dto';
import { UpdateDriverRatingDto } from './dto/update_driver_rating.dto';
import { UpdateClientRatingDto } from './dto/update_client_rating.dto';
import { SocketGateway } from 'src/socket/socket.gateway';
export declare class ClientRequestsController {
    private clientRequestsService;
    private socketGateway;
    constructor(clientRequestsService: ClientRequestsService, socketGateway: SocketGateway);
    getTimeAndDistanceClientRequest(origin_lat: number, origin_lng: number, destination_lat: number, destination_lng: number): Promise<{
        recommended_value: number;
        destination_addresses: string;
        origin_addresses: string;
        distance: {
            text: string;
            value: number;
        };
        duration: {
            text: string;
            value: number;
        };
    }>;
    getNearbyTripRequest(driver_lat: number, driver_lng: number): Promise<any>;
    getByClientRequest(id_client_request: number): Promise<any>;
    getByDriverAssigned(id_driver: number): Promise<any>;
    getByClientAssigned(id_client: number): Promise<any>;
    create(clientRequest: CreateClientRequestDto): Promise<number>;
    updateDriverAssigned(driverAssigned: UpdateDriverAssignedClientRequestDto): Promise<boolean>;
    updateStatus(updateStatusDto: UpdateStatusClientRequestDto): Promise<boolean>;
    updateDriverRating(driverRating: UpdateDriverRatingDto): Promise<boolean>;
    updateClientRating(clientRating: UpdateClientRatingDto): Promise<boolean>;
    delete(id: number): Promise<boolean>;
}
