import { Module } from '@nestjs/common';
import { SocketGateway } from './socket.gateway';

@Module({
  providers: [SocketGateway],
  exports: [SocketGateway] // <--- ¡ESTO ES VITAL! Permite que otros módulos usen el socket
})
export class SocketModule {}
