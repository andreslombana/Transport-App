"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DriverCarInfoService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const driver_car_info_entity_1 = require("./driver_car_info.entity");
const typeorm_2 = require("typeorm");
let DriverCarInfoService = class DriverCarInfoService {
    constructor(driverCarInfoRepository) {
        this.driverCarInfoRepository = driverCarInfoRepository;
    }
    async create(driverCarInfo) {
        const carInfoFound = await this.driverCarInfoRepository.findOneBy({ id_driver: driverCarInfo.id_driver });
        if (!carInfoFound) {
            const newCarInfo = this.driverCarInfoRepository.create(driverCarInfo);
            return this.driverCarInfoRepository.save(newCarInfo);
        }
        const updatedCarInfo = Object.assign(carInfoFound, driverCarInfo);
        return this.driverCarInfoRepository.save(updatedCarInfo);
    }
    findByIdDriver(id_driver) {
        return this.driverCarInfoRepository.findOneBy({ id_driver: id_driver });
    }
};
DriverCarInfoService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(driver_car_info_entity_1.DriverCarInfo)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], DriverCarInfoService);
exports.DriverCarInfoService = DriverCarInfoService;
//# sourceMappingURL=driver_car_info.service.js.map