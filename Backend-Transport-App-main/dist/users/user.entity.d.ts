import { Rol } from 'src/roles/rol.entity';
import { DriversPosition } from 'src/drivers_position/drivers_position.entity';
import { ClientRequests } from 'src/client_requests/client_requests.entity';
import { DriverTripOffers } from 'src/driver_trip_offers/driver_trip_offers.entity';
import { DriverCarInfo } from 'src/driver_car_info/driver_car_info.entity';
export declare class User {
    id: number;
    name: string;
    lastname: string;
    email: string;
    phone: string;
    image: string;
    password: string;
    notification_token: string;
    created_at: Date;
    updated_at: Date;
    roles: Rol[];
    driversPosition: DriversPosition;
    clientRequests: ClientRequests;
    clientRequestsDriverAssigned: ClientRequests;
    driverTripOffers: DriverTripOffers;
    driverCarInfo: DriverCarInfo;
    hashPassword(): Promise<void>;
}
