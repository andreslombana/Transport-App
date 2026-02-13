import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { DriverTripOffersService } from './driver_trip_offers.service';
import { CreateDriverTripOffersDto } from './dto/create_driver_trip_offers.dto';
import { SocketGateway } from 'src/socket/socket.gateway'; // <--- 1. Importar Gateway

@Controller('driver-trip-offers')
export class DriverTripOffersController {

    constructor(
        private driverTripOffersService: DriverTripOffersService,
        private socketGateway: SocketGateway // <--- 2. Inyectar Gateway
    ) {}

    @Get('findByClientRequest/:id_client_request')
    findByClientRequest(@Param('id_client_request') id_client_request: number) {
        return this.driverTripOffersService.findByClientRequest(id_client_request);
    }

    @Post()
    async create(@Body() driverTripOffer: CreateDriverTripOffersDto) {
        // 1. Guardamos la oferta (Prioridad #1)
        const data = await this.driverTripOffersService.create(driverTripOffer);
        
        // 2. Intentamos notificar al cliente (Prioridad #2)
        try {
            const eventName = `created_driver_offer/${driverTripOffer.id_client_request}`;
            this.socketGateway.server.emit(eventName, data);
            console.log(`⚡ SOCKET ENVIADO EXITOSAMENTE A: ${eventName}`);
        } catch (error) {
            // Si el socket falla, NO detenemos el proceso. Solo imprimimos el error.
            // Esto evita el mensaje de "No se pudo enviar la oferta" en Flutter.
            console.log('⚠️ ERROR EN SOCKET (Pero la oferta se guardó):', error);
        }
        
        // 3. Retornamos éxito al conductor
        return data;
    }
}