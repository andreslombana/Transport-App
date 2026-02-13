import { AuthService } from './auth.service';
import { RegisterAuthDto } from './dto/register-auth.dto';
import { LoginAuthDto } from './dto/login-auth.dto';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    register(user: RegisterAuthDto): Promise<{
        user: import("../users/user.entity").User;
        token: string;
    }>;
    login(loginData: LoginAuthDto): Promise<{
        user: import("../users/user.entity").User;
        token: string;
    }>;
}
