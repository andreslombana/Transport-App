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
exports.DriversPosition = void 0;
const user_entity_1 = require("../users/user.entity");
const typeorm_1 = require("typeorm");
let DriversPosition = class DriversPosition {
};
__decorate([
    (0, typeorm_1.PrimaryColumn)(),
    __metadata("design:type", Number)
], DriversPosition.prototype, "id_driver", void 0);
__decorate([
    (0, typeorm_1.Index)({ spatial: true }),
    (0, typeorm_1.Column)({
        type: 'point',
        spatialFeatureType: 'Point',
        srid: 4326,
        nullable: false
    }),
    __metadata("design:type", Object)
], DriversPosition.prototype, "position", void 0);
__decorate([
    (0, typeorm_1.ManyToOne)(() => user_entity_1.User, (user) => user.id),
    (0, typeorm_1.JoinColumn)({ name: 'id_driver' }),
    __metadata("design:type", user_entity_1.User)
], DriversPosition.prototype, "user", void 0);
DriversPosition = __decorate([
    (0, typeorm_1.Entity)({ name: 'drivers_position' })
], DriversPosition);
exports.DriversPosition = DriversPosition;
//# sourceMappingURL=drivers_position.entity.js.map