"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DriverCarInfoModule = void 0;
const common_1 = require("@nestjs/common");
const driver_car_info_service_1 = require("./driver_car_info.service");
const driver_car_info_controller_1 = require("./driver_car_info.controller");
const typeorm_1 = require("@nestjs/typeorm");
const driver_car_info_entity_1 = require("./driver_car_info.entity");
const user_entity_1 = require("../users/user.entity");
let DriverCarInfoModule = class DriverCarInfoModule {
};
DriverCarInfoModule = __decorate([
    (0, common_1.Module)({
        imports: [typeorm_1.TypeOrmModule.forFeature([driver_car_info_entity_1.DriverCarInfo, user_entity_1.User])],
        providers: [driver_car_info_service_1.DriverCarInfoService],
        controllers: [driver_car_info_controller_1.DriverCarInfoController]
    })
], DriverCarInfoModule);
exports.DriverCarInfoModule = DriverCarInfoModule;
//# sourceMappingURL=driver_car_info.module.js.map