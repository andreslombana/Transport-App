import { Module } from '@nestjs/common';
import { DriverTripOffersService } from './driver_trip_offers.service';
import { DriverTripOffersController } from './driver_trip_offers.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DriverTripOffers } from './driver_trip_offers.entity';
import { User } from 'src/users/user.entity';
import { ClientRequests } from 'src/client_requests/client_requests.entity';
import { DriverCarInfo } from 'src/driver_car_info/driver_car_info.entity';
import { SocketModule } from 'src/socket/socket.module';

@Module({
  imports: [ TypeOrmModule.forFeature([DriverTripOffers, User, ClientRequests, DriverCarInfo]),
  SocketModule
],
  providers: [DriverTripOffersService],
  controllers: [DriverTripOffersController]
})
export class DriverTripOffersModule {}
