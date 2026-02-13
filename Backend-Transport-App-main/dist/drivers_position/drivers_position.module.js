"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DriversPositionModule = void 0;
const common_1 = require("@nestjs/common");
const drivers_position_service_1 = require("./drivers_position.service");
const drivers_position_controller_1 = require("./drivers_position.controller");
const typeorm_1 = require("@nestjs/typeorm");
const drivers_position_entity_1 = require("./drivers_position.entity");
const user_entity_1 = require("../users/user.entity");
let DriversPositionModule = class DriversPositionModule {
};
DriversPositionModule = __decorate([
    (0, common_1.Module)({
        imports: [typeorm_1.TypeOrmModule.forFeature([drivers_position_entity_1.DriversPosition, user_entity_1.User])],
        providers: [drivers_position_service_1.DriversPositionService],
        controllers: [drivers_position_controller_1.DriversPositionController]
    })
], DriversPositionModule);
exports.DriversPositionModule = DriversPositionModule;
//# sourceMappingURL=drivers_position.module.js.map