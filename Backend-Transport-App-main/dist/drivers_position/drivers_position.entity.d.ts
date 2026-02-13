import { Point } from "geojson";
import { User } from "src/users/user.entity";
export declare class DriversPosition {
    id_driver: number;
    position: Point;
    user: User;
}
