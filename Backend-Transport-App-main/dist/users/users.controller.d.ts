/// <reference types="multer" />
import { CreateUserDto } from './dto/create-user.dto';
import { UsersService } from './users.service';
import { UpdateUserDto } from './dto/update-user.dto';
export declare class UsersController {
    private usersService;
    constructor(usersService: UsersService);
    findAll(): Promise<import("./user.entity").User[]>;
    create(user: CreateUserDto): Promise<import("./user.entity").User>;
    update(id: number, user: UpdateUserDto): Promise<import("./user.entity").User & UpdateUserDto>;
    updateNotificationToken(id: number, user: UpdateUserDto): Promise<import("./user.entity").User & UpdateUserDto>;
    updateWithImage(file: Express.Multer.File, id: number, user: UpdateUserDto): Promise<import("./user.entity").User & UpdateUserDto>;
}
