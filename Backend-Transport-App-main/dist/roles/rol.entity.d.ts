import { User } from "src/users/user.entity";
export declare class Rol {
    id: string;
    name: string;
    image: string;
    route: string;
    created_at: Date;
    updated_at: Date;
    users: User[];
}
