"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const app_controller_1 = require("./app.controller");
const app_service_1 = require("./app.service");
const users_module_1 = require("./users/users.module");
const auth_module_1 = require("./auth/auth.module");
const roles_module_1 = require("./roles/roles.module");
const socket_module_1 = require("./socket/socket.module");
const drivers_position_module_1 = require("./drivers_position/drivers_position.module");
const client_requests_module_1 = require("./client_requests/client_requests.module");
const time_and_distance_values_module_1 = require("./time_and_distance_values/time_and_distance_values.module");
const driver_trip_offers_module_1 = require("./driver_trip_offers/driver_trip_offers.module");
const driver_car_info_module_1 = require("./driver_car_info/driver_car_info.module");
const config_1 = require("@nestjs/config");
const firebase_module_1 = require("./firebase/firebase.module");
let AppModule = class AppModule {
};
AppModule = __decorate([
    (0, common_1.Module)({
        imports: [
            typeorm_1.TypeOrmModule.forRoot({
                type: 'mysql',
                host: 'localhost',
                port: 3306,
                username: 'root',
                password: '',
                database: 'indriverclone_db',
                entities: [__dirname + '/**/*.entity{.ts,.js}'],
                synchronize: true,
            }),
            config_1.ConfigModule.forRoot({ cache: true }),
            users_module_1.UsersModule,
            auth_module_1.AuthModule,
            roles_module_1.RolesModule,
            socket_module_1.SocketModule,
            drivers_position_module_1.DriversPositionModule,
            client_requests_module_1.ClientRequestsModule,
            time_and_distance_values_module_1.TimeAndDistanceValuesModule,
            driver_trip_offers_module_1.DriverTripOffersModule,
            driver_car_info_module_1.DriverCarInfoModule,
            firebase_module_1.FirebaseModule,
        ],
        controllers: [app_controller_1.AppController],
        providers: [app_service_1.AppService],
    })
], AppModule);
exports.AppModule = AppModule;
//# sourceMappingURL=app.module.js.map