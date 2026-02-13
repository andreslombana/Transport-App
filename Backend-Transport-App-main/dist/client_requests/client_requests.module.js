"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ClientRequestsModule = void 0;
const common_1 = require("@nestjs/common");
const client_requests_service_1 = require("./client_requests.service");
const client_requests_controller_1 = require("./client_requests.controller");
const time_and_distance_values_module_1 = require("../time_and_distance_values/time_and_distance_values.module");
const typeorm_1 = require("@nestjs/typeorm");
const user_entity_1 = require("../users/user.entity");
const client_requests_entity_1 = require("./client_requests.entity");
const firebase_module_1 = require("../firebase/firebase.module");
const socket_module_1 = require("../socket/socket.module");
let ClientRequestsModule = class ClientRequestsModule {
};
ClientRequestsModule = __decorate([
    (0, common_1.Module)({
        providers: [client_requests_service_1.ClientRequestsService],
        controllers: [client_requests_controller_1.ClientRequestsController],
        imports: [
            time_and_distance_values_module_1.TimeAndDistanceValuesModule,
            typeorm_1.TypeOrmModule.forFeature([client_requests_entity_1.ClientRequests, user_entity_1.User]),
            firebase_module_1.FirebaseModule,
            socket_module_1.SocketModule
        ]
    })
], ClientRequestsModule);
exports.ClientRequestsModule = ClientRequestsModule;
//# sourceMappingURL=client_requests.module.js.map