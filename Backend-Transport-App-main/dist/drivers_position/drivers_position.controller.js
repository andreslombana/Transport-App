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
exports.DriversPositionController = void 0;
const common_1 = require("@nestjs/common");
const create_driver_position_dto_1 = require("./dto/create_driver_position.dto");
const drivers_position_service_1 = require("./drivers_position.service");
let DriversPositionController = class DriversPositionController {
    constructor(driversPositionService) {
        this.driversPositionService = driversPositionService;
    }
    create(driversPosition) {
        return this.driversPositionService.create(driversPosition);
    }
    getDriverPosition(id_driver) {
        return this.driversPositionService.getDriverPosition(id_driver);
    }
    getNearbyDrivers(client_lat, client_lng) {
        return this.driversPositionService.getNearbyDrivers(client_lat, client_lng);
    }
    delete(id_driver) {
        return this.driversPositionService.delete(id_driver);
    }
};
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_driver_position_dto_1.CreateDriverPositionDto]),
    __metadata("design:returntype", void 0)
], DriversPositionController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(':id_driver'),
    __param(0, (0, common_1.Param)('id_driver')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], DriversPositionController.prototype, "getDriverPosition", null);
__decorate([
    (0, common_1.Get)(':client_lat/:client_lng'),
    __param(0, (0, common_1.Param)('client_lat')),
    __param(1, (0, common_1.Param)('client_lng')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number]),
    __metadata("design:returntype", void 0)
], DriversPositionController.prototype, "getNearbyDrivers", null);
__decorate([
    (0, common_1.Delete)(':id_driver'),
    __param(0, (0, common_1.Param)('id_driver', common_1.ParseIntPipe)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], DriversPositionController.prototype, "delete", null);
DriversPositionController = __decorate([
    (0, common_1.Controller)('drivers-position'),
    __metadata("design:paramtypes", [drivers_position_service_1.DriversPositionService])
], DriversPositionController);
exports.DriversPositionController = DriversPositionController;
//# sourceMappingURL=drivers_position.controller.js.map