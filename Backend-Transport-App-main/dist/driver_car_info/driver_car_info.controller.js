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
exports.DriverCarInfoController = void 0;
const common_1 = require("@nestjs/common");
const create_driver_car_info_dto_1 = require("./dto/create_driver_car_info.dto");
const driver_car_info_service_1 = require("./driver_car_info.service");
let DriverCarInfoController = class DriverCarInfoController {
    constructor(driverCarInfoService) {
        this.driverCarInfoService = driverCarInfoService;
    }
    findByIdDriver(id_driver) {
        return this.driverCarInfoService.findByIdDriver(id_driver);
    }
    create(driverCarInfo) {
        return this.driverCarInfoService.create(driverCarInfo);
    }
};
__decorate([
    (0, common_1.Get)(':id_driver'),
    __param(0, (0, common_1.Param)('id_driver')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], DriverCarInfoController.prototype, "findByIdDriver", null);
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_driver_car_info_dto_1.CreateDriverCarInfoDto]),
    __metadata("design:returntype", void 0)
], DriverCarInfoController.prototype, "create", null);
DriverCarInfoController = __decorate([
    (0, common_1.Controller)('driver-car-info'),
    __metadata("design:paramtypes", [driver_car_info_service_1.DriverCarInfoService])
], DriverCarInfoController);
exports.DriverCarInfoController = DriverCarInfoController;
//# sourceMappingURL=driver_car_info.controller.js.map