import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultTextField.dart';

class DriverClientRequestsItem extends StatelessWidget {
  final DriverClientRequestsState state;
  final ClientRequestResponse? clientRequest;

  DriverClientRequestsItem(this.state, this.clientRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FareOfferedDialog(context);
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              trailing: _imageUser(),
              title: Text(
                'Tarifa ofrecida: \$${clientRequest?.fareOffered ?? 0}',
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${clientRequest?.client.name ?? ''} ${clientRequest?.client.lastname ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[900],
                ),
              ),
            ),
            ListTile(
              title: const Text('Datos del viaje'),
              subtitle: Column(
                children: [
                  _textPickup(),
                  _textDestination(),
                ],
              ),
            ),
            ListTile(
              title: const Text('Tiempo y Distancia'),
              subtitle: Column(
                children: [
                  _textMinutes(),
                  _textDistance(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ... Widgets de texto e imagen (igual que antes) ...
  Widget _textMinutes() {
    return Row(
      children: [
        const SizedBox(width: 140, child: Text('Tiempo de llegada: ', style: TextStyle(fontWeight: FontWeight.bold))),
        Flexible(child: Text(clientRequest?.googleDistanceMatrix?.duration.text ?? '')),
      ],
    );
  }

  Widget _textDistance() {
    return Row(
      children: [
        const SizedBox(width: 140, child: Text('Recorrido: ', style: TextStyle(fontWeight: FontWeight.bold))),
        Flexible(child: Text(clientRequest?.googleDistanceMatrix?.distance.text ?? '')),
      ],
    );
  }

  Widget _textPickup() {
    return Row(
      children: [
        const SizedBox(width: 90, child: Text('Recoger en: ', style: TextStyle(fontWeight: FontWeight.bold))),
        Flexible(child: Text(clientRequest?.pickupDescription ?? '')),
      ],
    );
  }

  Widget _textDestination() {
    return Row(
      children: [
        const SizedBox(width: 90, child: Text('Llevar a: ', style: TextStyle(fontWeight: FontWeight.bold))),
        Flexible(child: Text(clientRequest?.destinationDescription ?? '')),
      ],
    );
  }

  Widget _imageUser() {
    final imageUrl = clientRequest?.client.image;
    return SizedBox(
      width: 60,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: imageUrl != null && imageUrl.isNotEmpty
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/img/user_image.png',
                  image: imageUrl,
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/img/user_image.png', fit: BoxFit.cover),
        ),
      ),
    );
  }

  // --- CORRECCIÓN: USAR TEXT EDITING CONTROLLER ---
  FareOfferedDialog(BuildContext context) {
    // Controlador local para el texto. Esto asegura que el valor siempre sea el que escribes.
    TextEditingController fareController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Ingresa tu tarifa',
          style: TextStyle(fontSize: 17),
        ),
        contentPadding: const EdgeInsets.only(bottom: 15),
        // Usamos un TextField normal o adaptamos el DefaultTextField para usar controller
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: fareController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.attach_money),
              labelText: 'Valor',
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Leemos DIRECTAMENTE del controlador. Infalible.
              final fare = fareController.text;

              if (clientRequest != null &&
                  state.idDriver != null &&
                  fare.isNotEmpty) {
                
                Navigator.pop(context); // Cerrar diálogo
                
                // Enviar al Bloc
                context.read<DriverClientRequestsBloc>().add(
                      CreateDriverTripRequest(
                        driverTripRequest: DriverTripRequest(
                          idDriver: state.idDriver!,
                          idClientRequest: clientRequest?.id ?? 0,
                          fareOffered: double.tryParse(fare) ?? 0,
                          time: (clientRequest?.googleDistanceMatrix?.duration.value.toDouble() ?? 0.0) / 60,
                          distance: (clientRequest?.googleDistanceMatrix?.distance.value.toDouble() ?? 0.0) / 1000,
                        ),
                      ),
                    );
              } else {
                Fluttertoast.showToast(msg: 'Debes ingresar una tarifa válida');
              }
            },
            child: const Text('Enviar tarifa', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}