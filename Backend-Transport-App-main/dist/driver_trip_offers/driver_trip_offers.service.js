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
exports.DriverTripOffersService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const driver_trip_offers_entity_1 = require("./driver_trip_offers.entity");
const typeorm_2 = require("typeorm");
let DriverTripOffersService = class DriverTripOffersService {
    constructor(driverTripOffersRepository) {
        this.driverTripOffersRepository = driverTripOffersRepository;
    }
    create(driverTripOffer) {
        const newData = this.driverTripOffersRepository.create(driverTripOffer);
        return this.driverTripOffersRepository.save(newData);
    }
    async findByClientRequest(id_client_request) {
        const data = await this.driverTripOffersRepository.query(`
        SELECT
            DTO.id,
            DTO.id_client_request,
            DTO.id_driver,
            DTO.fare_offered,
            DTO.time,
            DTO.distance,
            DTO.updated_at,
            DTO.created_at,
            JSON_OBJECT(
                "name", U.name,
                "lastname", U.lastname,
                "image", U.image,
                "phone", U.phone
            ) AS driver,
            JSON_OBJECT(
                "brand", DCI.brand,
                "plate", DCI.plate,
                "color", DCI.color
            ) AS car
        FROM
            driver_trip_offers AS DTO
        INNER JOIN
            users AS U
        ON
            U.id = DTO.id_driver
        LEFT JOIN 
            driver_car_info AS DCI
        ON
            DCI.id_driver = DTO.id_driver
        WHERE
            id_client_request = ${id_client_request}

        `);
        return data;
    }
};
DriverTripOffersService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(driver_trip_offers_entity_1.DriverTripOffers)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], DriverTripOffersService);
exports.DriverTripOffersService = DriverTripOffersService;
//# sourceMappingURL=driver_trip_offers.service.js.map