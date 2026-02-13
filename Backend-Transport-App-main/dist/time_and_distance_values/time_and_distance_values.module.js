"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TimeAndDistanceValuesModule = void 0;
const common_1 = require("@nestjs/common");
const time_and_distance_values_service_1 = require("./time_and_distance_values.service");
const typeorm_1 = require("@nestjs/typeorm");
const time_and_distance_values_entity_1 = require("./time_and_distance_values.entity");
let TimeAndDistanceValuesModule = class TimeAndDistanceValuesModule {
};
TimeAndDistanceValuesModule = __decorate([
    (0, common_1.Module)({
        imports: [typeorm_1.TypeOrmModule.forFeature([time_and_distance_values_entity_1.TimeAndDistanceValues])],
        providers: [time_and_distance_values_service_1.TimeAndDistanceValuesService],
        exports: [time_and_distance_values_service_1.TimeAndDistanceValuesService]
    })
], TimeAndDistanceValuesModule);
exports.TimeAndDistanceValuesModule = TimeAndDistanceValuesModule;
//# sourceMappingURL=time_and_distance_values.module.js.map