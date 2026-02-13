import { ClientRequests } from "src/client_requests/client_requests.entity";
import { User } from "src/users/user.entity";
export declare class DriverTripOffers {
    id: number;
    id_driver: number;
    id_client_request: number;
    fare_offered: number;
    time: number;
    distance: number;
    created_at: Date;
    updated_at: Date;
    driver: User;
    clientRequests: ClientRequests;
}
