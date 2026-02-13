import { Module } from '@nestjs/common';
import { ClientRequestsService } from './client_requests.service';
import { ClientRequestsController } from './client_requests.controller';
import { TimeAndDistanceValuesModule } from 'src/time_and_distance_values/time_and_distance_values.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from 'src/users/user.entity';
import { ClientRequests } from './client_requests.entity';
import { FirebaseModule } from 'src/firebase/firebase.module';
// 1. Importar el Módulo de Sockets
import { SocketModule } from 'src/socket/socket.module';

@Module({
  providers: [ClientRequestsService],
  controllers: [ClientRequestsController],
  imports: [
    TimeAndDistanceValuesModule, 
    TypeOrmModule.forFeature([ClientRequests, User]), 
    FirebaseModule,
    SocketModule // <--- 2. ¡IMPORTANTE! Agregarlo aquí para que la inyección funcione
  ]
})
export class ClientRequestsModule {}
