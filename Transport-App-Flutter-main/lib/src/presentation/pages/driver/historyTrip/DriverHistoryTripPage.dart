import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/DriverHistoryTripItem.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/bloc/DriverHistoryTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/bloc/DriverHistoryTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/bloc/DriverHistoryTripState.dart';
// Importaciones para la navegación al Home
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';

class DriverHistoryTripPage extends StatefulWidget {
  const DriverHistoryTripPage({super.key});

  @override
  State<DriverHistoryTripPage> createState() => _DriverHistoryTripPageState();
}

class _DriverHistoryTripPageState extends State<DriverHistoryTripPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverHistoryTripBloc>().add(GetHistoryTrip());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Envolvemos con WillPopScope para controlar el botón físico de atrás
    return WillPopScope(
      onWillPop: () async {
        // Regresar al Mapa (Index 0) en el menú
        context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 0));
        return false;
      },
      child: Scaffold(
        // Usamos Scaffold para asegurar el fondo correcto
        body: BlocBuilder<DriverHistoryTripBloc, DriverHistoryTripState>(
          builder: (context, state) {
            final response = state.response;
            
            if (response is Loading) {
              return Center(child: CircularProgressIndicator());
            }
            else if (response is Success) {
              List<ClientRequestResponse> data = response.data as List<ClientRequestResponse>;
              
              // Validación: Si la lista está vacía, mostramos mensaje
              if (data.isEmpty) {
                return Center(
                  child: Text(
                    'No tienes historial de viajes.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600]
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return DriverHistoryTripItem(data[index]);
                }
              );
            }
            // Estado por defecto
            return Container();
          },
        ),
      ),
    );
  }
}