import { User } from '../users/user.entity';
import { Repository } from 'typeorm';
import { RegisterAuthDto } from './dto/register-auth.dto';
import { LoginAuthDto } from './dto/login-auth.dto';
import { JwtService } from '@nestjs/jwt';
import { Rol } from '../roles/rol.entity';
export declare class AuthService {
    private usersRepository;
    private rolesRepository;
    private jwtService;
    constructor(usersRepository: Repository<User>, rolesRepository: Repository<Rol>, jwtService: JwtService);
    register(user: RegisterAuthDto): Promise<{
        user: User;
        token: string;
    }>;
    login(loginData: LoginAuthDto): Promise<{
        user: User;
        token: string;
    }>;
}
