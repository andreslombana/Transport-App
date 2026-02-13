/// <reference types="multer" />
import { User } from './user.entity';
import { Repository } from 'typeorm';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
export declare class UsersService {
    private usersRepository;
    constructor(usersRepository: Repository<User>);
    create(user: CreateUserDto): Promise<User>;
    findAll(): Promise<User[]>;
    update(id: number, user: UpdateUserDto): Promise<User & UpdateUserDto>;
    updateWithImage(file: Express.Multer.File, id: number, user: UpdateUserDto): Promise<User & UpdateUserDto>;
}
