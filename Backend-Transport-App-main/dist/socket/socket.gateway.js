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
exports.SocketGateway = void 0;
const websockets_1 = require("@nestjs/websockets");
const socket_io_1 = require("socket.io");
let SocketGateway = class SocketGateway {
    handleDisconnect(client) {
        console.log('Un usuario se ha desconectado de SOCKET.IO', client.id);
        this.server.emit('driver_disconnected', { id_socket: client.id });
    }
    handleConnection(client, ...args) {
        console.log('Un usuario se ha conectado a SOCKET.IO', client.id);
    }
    handleMessage(data) {
        console.log('Nuevo mensaje: ', data);
        this.server.emit('new_message', 'Bien gracias');
    }
    handleChangeDriverPosition(client, data) {
        console.log('EMITIO NUEVA POSICION: ', data);
        this.server.emit('new_driver_position', { id_socket: client.id, id: data.id, lat: data.lat, lng: data.lng });
    }
    handleNewClientRequest(client, data) {
        this.server.emit('created_client_request', { id_socket: client.id, id_client_request: data.id_client_request });
    }
    handleNewDriverOffer(client, data) {
        console.log('ID CLIENT REQUEST DRIVER OFFER:', data.id_client_request);
        this.server.emit(`created_driver_offer/${data.id_client_request}`, { id_socket: client.id });
    }
    handleNewDriverAssigned(client, data) {
        this.server.emit(`driver_assigned/${data.id_driver}`, {
            id_socket: client.id,
            id_client_request: data.id_client_request
        });
    }
    handleTripChangeDriverPosition(client, data) {
        this.server.emit(`trip_new_driver_position/${data.id_client}`, { id_socket: client.id, lat: data.lat, lng: data.lng });
    }
    handleUpdateStatusTrip(client, data) {
        this.server.emit(`new_status_trip/${data.id_client_request}`, { id_socket: client.id, status: data.status, id_client_request: data.id_client_request });
    }
};
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], SocketGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)('message'),
    __param(0, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], SocketGateway.prototype, "handleMessage", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('change_driver_position'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], SocketGateway.prototype, "handleChangeDriverPosition", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('new_client_request'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], SocketGateway.prototype, "handleNewClientRequest", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('new_driver_offer'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], SocketGateway.prototype, "handleNewDriverOffer", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('new_driver_assigned'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], SocketGateway.prototype, "handleNewDriverAssigned", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('trip_change_driver_position'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], SocketGateway.prototype, "handleTripChangeDriverPosition", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('update_status_trip'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", void 0)
], SocketGateway.prototype, "handleUpdateStatusTrip", null);
SocketGateway = __decorate([
    (0, websockets_1.WebSocketGateway)({
        cors: {
            origin: '*'
        },
        transports: ['websocket']
    })
], SocketGateway);
exports.SocketGateway = SocketGateway;
//# sourceMappingURL=socket.gateway.js.map