import { RolesService } from './roles.service';
import { CreateRolDto } from './dto/create-rol.dto';
export declare class RolesController {
    private rolesService;
    constructor(rolesService: RolesService);
    create(rol: CreateRolDto): Promise<import("./rol.entity").Rol>;
}
