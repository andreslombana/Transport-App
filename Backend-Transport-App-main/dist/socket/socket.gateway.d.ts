import { OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
export declare class SocketGateway implements OnGatewayConnection, OnGatewayDisconnect {
    server: Server;
    handleDisconnect(client: Socket): void;
    handleConnection(client: Socket, ...args: any[]): void;
    handleMessage(data: any): void;
    handleChangeDriverPosition(client: Socket, data: any): void;
    handleNewClientRequest(client: Socket, data: any): void;
    handleNewDriverOffer(client: Socket, data: any): void;
    handleNewDriverAssigned(client: Socket, data: any): void;
    handleTripChangeDriverPosition(client: Socket, data: any): void;
    handleUpdateStatusTrip(client: Socket, data: any): void;
}
