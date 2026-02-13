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
exports.ClientRequests = exports.Status = void 0;
const driver_trip_offers_entity_1 = require("../driver_trip_offers/driver_trip_offers.entity");
const user_entity_1 = require("../users/user.entity");
const typeorm_1 = require("typeorm");
var Status;
(function (Status) {
    Status["CREATED"] = "CREATED";
    Status["ACCEPTED"] = "ACCEPTED";
    Status["ON_THE_WAY"] = "ON_THE_WAY";
    Status["ARRIVED"] = "ARRIVED";
    Status["TRAVELLING"] = "TRAVELLING";
    Status["FINISHED"] = "FINISHED";
    Status["CANCELLED"] = "CANCELLED";
})(Status = exports.Status || (exports.Status = {}));
let ClientRequests = class ClientRequests {
};
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], ClientRequests.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", Number)
], ClientRequests.prototype, "id_client", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { precision: 10, scale: 2 }),
    __metadata("design:type", Number)
], ClientRequests.prototype, "fare_offered", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], ClientRequests.prototype, "pickup_description", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], ClientRequests.prototype, "destination_description", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", Number)
], ClientRequests.prototype, "id_driver_assigned", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", Number)
], ClientRequests.prototype, "fare_assigned", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { nullable: true, precision: 5, scale: 2 }),
    __metadata("design:type", Number)
], ClientRequests.prototype, "client_rating", void 0);
__decorate([
    (0, typeorm_1.Column)('decimal', { nullable: true, precision: 5, scale: 2 }),
    __metadata("design:type", Number)
], ClientRequests.prototype, "driver_rating", void 0);
__decorate([
    (0, typeorm_1.Index)({ spatial: true }),
    (0, typeorm_1.Column)({
        type: 'point',
        spatialFeatureType: 'Point',
        srid: 4326,
        nullable: false
    }),
    __metadata("design:type", Object)
], ClientRequests.prototype, "pickup_position", void 0);
__decorate([
    (0, typeorm_1.Index)({ spatial: true }),
    (0, typeorm_1.Column)({
        type: 'point',
        spatialFeatureType: 'Point',
        srid: 4326,
        nullable: false
    }),
    __metadata("design:type", Object)
], ClientRequests.prototype, "destination_position", void 0);
__decorate([
    (0, typeorm_1.Column)({
        type: 'enum',
        enum: Status,
        default: Status.CREATED
    }),
    __metadata("design:type", String)
], ClientRequests.prototype, "status", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' }),
    __metadata("design:type", Date)
], ClientRequests.prototype, "created_at", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' }),
    __metadata("design:type", Date)
], ClientRequests.prototype, "updated_at", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User, (user) => user.id),
    (0, typeorm_1.JoinColumn)({ name: 'id_client' }),
    __metadata("design:type", user_entity_1.User)
], ClientRequests.prototype, "user", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User, (user) => user.id),
    (0, typeorm_1.JoinColumn)({ name: 'id_driver_assigned' }),
    __metadata("design:type", user_entity_1.User)
], ClientRequests.prototype, "driverAssigned", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => driver_trip_offers_entity_1.DriverTripOffers, driverTripOffers => driverTripOffers.id_client_request, {
        cascade: true
    }),
    __metadata("design:type", driver_trip_offers_entity_1.DriverTripOffers)
], ClientRequests.prototype, "driverTripOffers", void 0);
ClientRequests = __decorate([
    (0, typeorm_1.Entity)({ name: 'client_requests' })
], ClientRequests);
exports.ClientRequests = ClientRequests;
//# sourceMappingURL=client_requests.entity.js.map