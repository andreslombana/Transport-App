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
exports.User = void 0;
const typeorm_1 = require("typeorm");
const bcrypt_1 = require("bcrypt");
const rol_entity_1 = require("../roles/rol.entity");
const drivers_position_entity_1 = require("../drivers_position/drivers_position.entity");
const client_requests_entity_1 = require("../client_requests/client_requests.entity");
const driver_trip_offers_entity_1 = require("../driver_trip_offers/driver_trip_offers.entity");
const driver_car_info_entity_1 = require("../driver_car_info/driver_car_info.entity");
let User = class User {
    async hashPassword() {
        this.password = await (0, bcrypt_1.hash)(this.password, Number(process.env.HASH_SALT));
    }
};
__decorate([
    (0, typeorm_1.PrimaryGeneratedColumn)(),
    __metadata("design:type", Number)
], User.prototype, "id", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], User.prototype, "name", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], User.prototype, "lastname", void 0);
__decorate([
    (0, typeorm_1.Column)({ unique: true }),
    __metadata("design:type", String)
], User.prototype, "email", void 0);
__decorate([
    (0, typeorm_1.Column)({ unique: true }),
    __metadata("design:type", String)
], User.prototype, "phone", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], User.prototype, "image", void 0);
__decorate([
    (0, typeorm_1.Column)(),
    __metadata("design:type", String)
], User.prototype, "password", void 0);
__decorate([
    (0, typeorm_1.Column)({ nullable: true }),
    __metadata("design:type", String)
], User.prototype, "notification_token", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' }),
    __metadata("design:type", Date)
], User.prototype, "created_at", void 0);
__decorate([
    (0, typeorm_1.Column)({ type: 'datetime', default: () => 'CURRENT_TIMESTAMP' }),
    __metadata("design:type", Date)
], User.prototype, "updated_at", void 0);
__decorate([
    (0, typeorm_1.JoinTable)({
        name: 'user_has_roles',
        joinColumn: {
            name: 'id_user'
        },
        inverseJoinColumn: {
            name: 'id_rol'
        }
    }),
    (0, typeorm_1.ManyToMany)(() => rol_entity_1.Rol, (rol) => rol.users),
    __metadata("design:type", Array)
], User.prototype, "roles", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => drivers_position_entity_1.DriversPosition, driversPosition => driversPosition.id_driver),
    __metadata("design:type", drivers_position_entity_1.DriversPosition)
], User.prototype, "driversPosition", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => client_requests_entity_1.ClientRequests, clientRequests => clientRequests.id_client),
    __metadata("design:type", client_requests_entity_1.ClientRequests)
], User.prototype, "clientRequests", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => client_requests_entity_1.ClientRequests, clientRequests => clientRequests.id_driver_assigned),
    __metadata("design:type", client_requests_entity_1.ClientRequests)
], User.prototype, "clientRequestsDriverAssigned", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => driver_trip_offers_entity_1.DriverTripOffers, driverTripOffers => driverTripOffers.id_driver),
    __metadata("design:type", driver_trip_offers_entity_1.DriverTripOffers)
], User.prototype, "driverTripOffers", void 0);
__decorate([
    (0, typeorm_1.OneToMany)(() => driver_car_info_entity_1.DriverCarInfo, driverCarInfo => driverCarInfo.id_driver),
    __metadata("design:type", driver_car_info_entity_1.DriverCarInfo)
], User.prototype, "driverCarInfo", void 0);
__decorate([
    (0, typeorm_1.BeforeInsert)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], User.prototype, "hashPassword", null);
User = __decorate([
    (0, typeorm_1.Entity)({ name: 'users' })
], User);
exports.User = User;
//# sourceMappingURL=user.entity.js.map