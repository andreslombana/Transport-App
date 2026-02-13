import { Client } from '@googlemaps/google-maps-services-js';
import { Repository } from 'typeorm';
import { ClientRequests } from './client_requests.entity';
import { CreateClientRequestDto } from './dto/create_client_request.dto';
import { TimeAndDistanceValuesService } from '../time_and_distance_values/time_and_distance_values.service';
import { UpdateDriverAssignedClientRequestDto } from './dto/update_driver_assigned_client_request.dto';
import { UpdateStatusClientRequestDto } from './dto/update_status_client_request.dto';
import { UpdateDriverRatingDto } from './dto/update_driver_rating.dto';
import { UpdateClientRatingDto } from './dto/update_client_rating.dto';
import { FirebaseRepository } from '../firebase/firebase.repository';
import { SocketGateway } from '../socket/socket.gateway';
export declare class ClientRequestsService extends Client {
    private clientRequestsRepository;
    private timeAndDistanceValuesService;
    private firebaseRepository;
    private socketGateway;
    constructor(clientRequestsRepository: Repository<ClientRequests>, timeAndDistanceValuesService: TimeAndDistanceValuesService, firebaseRepository: FirebaseRepository, socketGateway: SocketGateway);
    create(clientRequest: CreateClientRequestDto): Promise<number>;
    getNearbyTripRequest(driver_lat: number, driver_lng: number): Promise<any>;
    updateDriverAssigned(driverAssigned: UpdateDriverAssignedClientRequestDto): Promise<boolean>;
    updateStatus(updateStatusDto: UpdateStatusClientRequestDto): Promise<boolean>;
    updateDriverRating(driverRating: UpdateDriverRatingDto): Promise<boolean>;
    updateClientRating(clientRating: UpdateClientRatingDto): Promise<boolean>;
    delete(id: number): Promise<boolean>;
    getByClientRequest(id_client_request: number): Promise<any>;
    getByDriverAssigned(id_driver: number): Promise<any>;
    getByClientAssigned(id_client: number): Promise<any>;
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
}
