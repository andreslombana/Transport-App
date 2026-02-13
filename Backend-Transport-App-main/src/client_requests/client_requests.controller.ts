// 1. AGREGAMOS 'Delete' AQUI EN LOS IMPORTS
import { Body, Controller, Get, Param, Post, Put, Delete } from '@nestjs/common';
import { ClientRequestsService } from './client_requests.service';
import { CreateClientRequestDto } from './dto/create_client_request.dto';
import { UpdateDriverAssignedClientRequestDto } from './dto/update_driver_assigned_client_request.dto';
import { UpdateStatusClientRequestDto } from './dto/update_status_client_request.dto';
import { UpdateDriverRatingDto } from './dto/update_driver_rating.dto';
import { UpdateClientRatingDto } from './dto/update_client_rating.dto';
import { SocketGateway } from 'src/socket/socket.gateway'; 

@Controller('client-requests')
export class ClientRequestsController {

    constructor(
        private clientRequestsService: ClientRequestsService,
        private socketGateway: SocketGateway 
    ) {}

    @Get(':origin_lat/:origin_lng/:destination_lat/:destination_lng')
    getTimeAndDistanceClientRequest(
        @Param('origin_lat') origin_lat: number, 
        @Param('origin_lng') origin_lng: number, 
        @Param('destination_lat') destination_lat: number, 
        @Param('destination_lng') destination_lng: number, 
    ) {
        return this.clientRequestsService.getTimeAndDistanceClientRequest(
            origin_lat,
            origin_lng,
            destination_lat,
            destination_lng
        )
    }

    @Get(':driver_lat/:driver_lng')
    getNearbyTripRequest(
        @Param('driver_lat') driver_lat: number, 
        @Param('driver_lng') driver_lng: number, 
    ) {
        return this.clientRequestsService.getNearbyTripRequest(
            driver_lat,
            driver_lng,
        );
    }

    @Get(':id_client_request')
    getByClientRequest(
        @Param('id_client_request') id_client_request: number, 
    ) {
        return this.clientRequestsService.getByClientRequest(id_client_request);
    }

    @Get('driver/assigned/:id_driver')
    getByDriverAssigned(
        @Param('id_driver') id_driver: number, 
    ) {
        return this.clientRequestsService.getByDriverAssigned(id_driver);
    }

    @Get('client/assigned/:id_client')
    getByClientAssigned(
        @Param('id_client') id_client: number, 
    ) {
        return this.clientRequestsService.getByClientAssigned(id_client);
    }

    @Post()
    async create(@Body() clientRequest: CreateClientRequestDto) {
        const data = await this.clientRequestsService.create(clientRequest);
        // Emitimos la notificación al conductor
        this.socketGateway.server.emit('created_request_client', {
            id_client_request: (data as any).id, 
            data: data 
        });
        return data;
    }

    @Put()
    updateDriverAssigned(@Body() driverAssigned: UpdateDriverAssignedClientRequestDto) {
        return this.clientRequestsService.updateDriverAssigned(driverAssigned);
    }

    @Put('update_status')
    updateStatus(@Body() updateStatusDto: UpdateStatusClientRequestDto) {
        return this.clientRequestsService.updateStatus(updateStatusDto);
    }

    @Put('update_driver_rating')
    updateDriverRating(@Body() driverRating: UpdateDriverRatingDto) {
        return this.clientRequestsService.updateDriverRating(driverRating);
    }

    @Put('update_client_rating')
    updateClientRating(@Body() clientRating: UpdateClientRatingDto) {
        return this.clientRequestsService.updateClientRating(clientRating);
    }

    // 2. EL MÉTODO DELETE QUE CAUSABA EL ERROR
    @Delete(':id')
    delete(@Param('id') id: number) {
        return this.clientRequestsService.delete(id);
    }
}
