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
Object.defineProperty(exports, "__esModule", { value: true });
exports.DriverTripOffers = void 0;
const client_requests_entity_1 = require("../client_requests/client_requests.entity");
const user_entity_1 = require("../users/user.entity");
const typeorm_1 = require("typeorm");
let DriverTripOffers = class DriverTripOffers {
};
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], DriverTripOffers.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], DriverTripOffers.prototype, "id_driver", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], DriverTripOffers.prototype, "id_client_request", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 10, scale: 2 }),
    __metadata("design:type", Number)
], DriverTripOffers.prototype, "fare_offered", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 10, scale: 2 }),
    __metadata("design:type", Number)
], DriverTripOffers.prototype, "time", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 10, scale: 2 }),
    __metadata("design:type", Number)
], DriverTripOffers.prototype, "distance", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' }),
    __metadata("design:type", Date)
], DriverTripOffers.prototype, "created_at", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' }),
    __metadata("design:type", Date)
], DriverTripOffers.prototype, "updated_at", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User, (user) => user.id),
    (0, typeorm_1.JoinColumn)({ name: 'id_driver' }),
    __metadata("design:type", user_entity_1.User)
], DriverTripOffers.prototype, "driver", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => client_requests_entity_1.ClientRequests, (clientRequests) => clientRequests.id, {
        onDelete: 'CASCADE',
        onUpdate: 'CASCADE'
    }),
    (0, typeorm_1.JoinColumn)({ name: 'id_client_request' }),
    __metadata("design:type", client_requests_entity_1.ClientRequests)
], DriverTripOffers.prototype, "clientRequests", void 0);
DriverTripOffers = __decorate([
    (0, typeorm_1.Entity)({ name: 'driver_trip_offers' })
], DriverTripOffers);
exports.DriverTripOffers = DriverTripOffers;
//# sourceMappingURL=driver_trip_offers.entity.js.map