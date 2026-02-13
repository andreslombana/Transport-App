"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DriverTripOffersModule = void 0;
const common_1 = require("@nestjs/common");
const driver_trip_offers_service_1 = require("./driver_trip_offers.service");
const driver_trip_offers_controller_1 = require("./driver_trip_offers.controller");
const typeorm_1 = require("@nestjs/typeorm");
const driver_trip_offers_entity_1 = require("./driver_trip_offers.entity");
const user_entity_1 = require("../users/user.entity");
const client_requests_entity_1 = require("../client_requests/client_requests.entity");
const driver_car_info_entity_1 = require("../driver_car_info/driver_car_info.entity");
const socket_module_1 = require("../socket/socket.module");
let DriverTripOffersModule = class DriverTripOffersModule {
};
DriverTripOffersModule = __decorate([
    (0, common_1.Module)({
        imports: [typeorm_1.TypeOrmModule.forFeature([driver_trip_offers_entity_1.DriverTripOffers, user_entity_1.User, client_requests_entity_1.ClientRequests, driver_car_info_entity_1.DriverCarInfo]),
            socket_module_1.SocketModule
        ],
        providers: [driver_trip_offers_service_1.DriverTripOffersService],
        controllers: [driver_trip_offers_controller_1.DriverTripOffersController]
    })
], DriverTripOffersModule);
exports.DriverTripOffersModule = DriverTripOffersModule;
//# sourceMappingURL=driver_trip_offers.module.js.map