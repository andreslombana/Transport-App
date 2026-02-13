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
exports.ClientRequestsController = void 0;
const common_1 = require("@nestjs/common");
const client_requests_service_1 = require("./client_requests.service");
const create_client_request_dto_1 = require("./dto/create_client_request.dto");
const update_driver_assigned_client_request_dto_1 = require("./dto/update_driver_assigned_client_request.dto");
const update_status_client_request_dto_1 = require("./dto/update_status_client_request.dto");
const update_driver_rating_dto_1 = require("./dto/update_driver_rating.dto");
const update_client_rating_dto_1 = require("./dto/update_client_rating.dto");
const socket_gateway_1 = require("../socket/socket.gateway");
let ClientRequestsController = class ClientRequestsController {
    constructor(clientRequestsService, socketGateway) {
        this.clientRequestsService = clientRequestsService;
        this.socketGateway = socketGateway;
    }
    getTimeAndDistanceClientRequest(origin_lat, origin_lng, destination_lat, destination_lng) {
        return this.clientRequestsService.getTimeAndDistanceClientRequest(origin_lat, origin_lng, destination_lat, destination_lng);
    }
    getNearbyTripRequest(driver_lat, driver_lng) {
        return this.clientRequestsService.getNearbyTripRequest(driver_lat, driver_lng);
    }
    getByClientRequest(id_client_request) {
        return this.clientRequestsService.getByClientRequest(id_client_request);
    }
    getByDriverAssigned(id_driver) {
        return this.clientRequestsService.getByDriverAssigned(id_driver);
    }
    getByClientAssigned(id_client) {
        return this.clientRequestsService.getByClientAssigned(id_client);
    }
    async create(clientRequest) {
        const data = await this.clientRequestsService.create(clientRequest);
        this.socketGateway.server.emit('created_request_client', {
            id_client_request: data.id,
            data: data
        });
        return data;
    }
    updateDriverAssigned(driverAssigned) {
        return this.clientRequestsService.updateDriverAssigned(driverAssigned);
    }
    updateStatus(updateStatusDto) {
        return this.clientRequestsService.updateStatus(updateStatusDto);
    }
    updateDriverRating(driverRating) {
        return this.clientRequestsService.updateDriverRating(driverRating);
    }
    updateClientRating(clientRating) {
        return this.clientRequestsService.updateClientRating(clientRating);
    }
    delete(id) {
        return this.clientRequestsService.delete(id);
    }
};
__decorate([
    (0, common_1.Get)(':origin_lat/:origin_lng/:destination_lat/:destination_lng'),
    __param(0, (0, common_1.Param)('origin_lat')),
    __param(1, (0, common_1.Param)('origin_lng')),
    __param(2, (0, common_1.Param)('destination_lat')),
    __param(3, (0, common_1.Param)('destination_lng')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number, Number, Number]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "getTimeAndDistanceClientRequest", null);
__decorate([
    (0, common_1.Get)(':driver_lat/:driver_lng'),
    __param(0, (0, common_1.Param)('driver_lat')),
    __param(1, (0, common_1.Param)('driver_lng')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number, Number]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "getNearbyTripRequest", null);
__decorate([
    (0, common_1.Get)(':id_client_request'),
    __param(0, (0, common_1.Param)('id_client_request')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "getByClientRequest", null);
__decorate([
    (0, common_1.Get)('driver/assigned/:id_driver'),
    __param(0, (0, common_1.Param)('id_driver')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "getByDriverAssigned", null);
__decorate([
    (0, common_1.Get)('client/assigned/:id_client'),
    __param(0, (0, common_1.Param)('id_client')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "getByClientAssigned", null);
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_client_request_dto_1.CreateClientRequestDto]),
    __metadata("design:returntype", Promise)
], ClientRequestsController.prototype, "create", null);
__decorate([
    (0, common_1.Put)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [update_driver_assigned_client_request_dto_1.UpdateDriverAssignedClientRequestDto]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "updateDriverAssigned", null);
__decorate([
    (0, common_1.Put)('update_status'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [update_status_client_request_dto_1.UpdateStatusClientRequestDto]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "updateStatus", null);
__decorate([
    (0, common_1.Put)('update_driver_rating'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [update_driver_rating_dto_1.UpdateDriverRatingDto]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "updateDriverRating", null);
__decorate([
    (0, common_1.Put)('update_client_rating'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [update_client_rating_dto_1.UpdateClientRatingDto]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "updateClientRating", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Number]),
    __metadata("design:returntype", void 0)
], ClientRequestsController.prototype, "delete", null);
ClientRequestsController = __decorate([
    (0, common_1.Controller)('client-requests'),
    __metadata("design:paramtypes", [client_requests_service_1.ClientRequestsService,
        socket_gateway_1.SocketGateway])
], ClientRequestsController);
exports.ClientRequestsController = ClientRequestsController;
//# sourceMappingURL=client_requests.controller.js.map