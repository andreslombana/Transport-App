import { Point } from "geojson";
import { DriverTripOffers } from "src/driver_trip_offers/driver_trip_offers.entity";
import { User } from "src/users/user.entity";
export declare enum Status {
    CREATED = "CREATED",
    ACCEPTED = "ACCEPTED",
    ON_THE_WAY = "ON_THE_WAY",
    ARRIVED = "ARRIVED",
    TRAVELLING = "TRAVELLING",
    FINISHED = "FINISHED",
    CANCELLED = "CANCELLED"
}
export declare class ClientRequests {
    id: number;
    id_client: number;
    fare_offered: number;
    pickup_description: string;
    destination_description: string;
    id_driver_assigned: number;
    fare_assigned: number;
    client_rating: number;
    driver_rating: number;
    pickup_position: Point;
    destination_position: Point;
    status: Status;
    created_at: Date;
    updated_at: Date;
    user: User;
    driverAssigned: User;
    driverTripOffers: DriverTripOffers;
}
