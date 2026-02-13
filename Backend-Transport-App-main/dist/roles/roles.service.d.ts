import { Rol } from './rol.entity';
import { Repository } from 'typeorm';
import { CreateRolDto } from './dto/create-rol.dto';
export declare class RolesService {
    private rolesRepository;
    constructor(rolesRepository: Repository<Rol>);
    create(rol: CreateRolDto): Promise<Rol>;
}
