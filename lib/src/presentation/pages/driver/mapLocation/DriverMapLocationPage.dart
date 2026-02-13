import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationState.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DriverMapLocationPage extends StatefulWidget {
  const DriverMapLocationPage({super.key});

  @override
  State<DriverMapLocationPage> createState() => _DriverMapLocationPageState();
}

class _DriverMapLocationPageState extends State<DriverMapLocationPage> {
  
  GoogleMapController? _googleMapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      // 1. Inicializamos datos del conductor
      context.read<DriverMapLocationBloc>().add(DriverMapLocationInitEvent());
      
      // 2. CORRECCIÓN IMPORTANTE:
      // Conectamos el socket apenas entramos a la pantalla
      context.read<BlocSocketIO>().add(ConnectSocketIO());

      // 3. Damos un respiro de 2 segundos para que conecte y LUEGO buscamos posición/escuchamos
      Future.delayed(const Duration(seconds: 2), () {
          // Esto activará el 'socket.on' dentro del Bloc
          context.read<DriverMapLocationBloc>().add(FindPosition());
      });
    });
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocListener<DriverMapLocationBloc, DriverMapLocationState>(
        listener: (context, state) {
          // --- LOG PARA DEPURAR ---
          if (state.idClientRequest != null) {
             print('VISTA: Recibido ID solicitud: ${state.idClientRequest}');
             showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              builder: (context) {
                return Container(
                  height: 250,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¡NUEVA SOLICITUD!', 
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)
                      ),
                      SizedBox(height: 10),
                      Text('ID Solicitud: ${state.idClientRequest}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () {
                               Navigator.pop(context);
                               // Lógica rechazar
                            }, 
                            child: Text('Rechazar', style: TextStyle(color: Colors.white))
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: () {
                               Navigator.pop(context);
                               // Lógica aceptar
                            }, 
                            child: Text('Aceptar', style: TextStyle(color: Colors.white))
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            );
          }
        },
        child: BlocBuilder<DriverMapLocationBloc, DriverMapLocationState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: state.cameraPosition,
                  markers: Set<Marker>.of(state.markers.values),
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController = controller;
                    controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
                    
                    if (!state.controller!.isCompleted) {
                      state.controller?.complete(controller);
                    }
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 30),
                  child: ToggleSwitch(
                    minWidth: 130.0,
                    minHeight: 50,
                    cornerRadius: 20.0,
                    activeBgColors: [[Colors.yellow], [Colors.red]],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey[400],
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: 0, // Inicia en Conectado visualmente
                    totalSwitches: 2,
                    labels: ['Conectado', 'Desconectado'],
                    onToggle: (index) {
                      if (index == 0) { // CONECTADO
                        context.read<BlocSocketIO>().add(ConnectSocketIO());
                        // Esperamos a que conecte antes de escuchar
                        Future.delayed(const Duration(seconds: 1), () {
                           context.read<DriverMapLocationBloc>().add(FindPosition());
                        });
                      }
                      else if (index == 1) { // DESCONECTADO
                        context.read<BlocSocketIO>().add(DisconnectSocketIO());
                        context.read<DriverMapLocationBloc>().add(StopLocation());
                      }
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}