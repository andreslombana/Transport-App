import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultTextField.dart';

class ClientMapBookingInfoContent extends StatefulWidget {

  final ClientMapBookingInfoState state;
  final TimeAndDistanceValues timeAndDistanceValues;

  const ClientMapBookingInfoContent(this.state, this.timeAndDistanceValues, {super.key});

  @override
  State<ClientMapBookingInfoContent> createState() => _ClientMapBookingInfoContentState();
}

class _ClientMapBookingInfoContentState extends State<ClientMapBookingInfoContent> {

  @override
  void initState() {
    super.initState();
    // --- MEJORA: Forzar cierre del teclado al iniciar ---
    // Esto asegura que si vienes de escribir la dirección, el teclado se cierre
    // y no cubra la información del viaje.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // --- MEJORA UX: Tocar afuera cierra el teclado ---
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          _googleMaps(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: _cardBookingInfo(context)
          ),
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: DefaultIconBack()
          )
        ],
      ),
    );
  }

  Widget _cardBookingInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.53, 
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 186, 186, 186),
          ]
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Recoger en',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              subtitle: Text(
                widget.state.pickUpDescription,
                style: TextStyle(
                  fontSize: 13
                ),
              ),
              leading: Icon(Icons.location_on),
            ),
            ListTile(
              title: Text(
                'Dejar en',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              subtitle: Text(
                widget.state.destinationDescription,
                style: TextStyle(
                  fontSize: 13
                ),
              ),
              leading: Icon(Icons.my_location),
            ),
            ListTile(
              title: Text(
                'Tiempo y distancia aproximados',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              subtitle: Text(
                '${widget.timeAndDistanceValues.distance.text} y ${widget.timeAndDistanceValues.duration.text}',
                style: TextStyle(
                  fontSize: 13
                ),
              ),
              leading: Icon(Icons.timer),
            ),
            ListTile(
              title: Text(
                'Precios recomendados',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              subtitle: Text(
                '\$${widget.timeAndDistanceValues.recommendedValue}',
                style: TextStyle(
                  fontSize: 13
                ),
              ),
              leading: Icon(Icons.money),
            ),
            DefaultTextField(
              margin: EdgeInsets.only(left: 15, right: 15),
              text: 'OFRECE TU TARIFA', 
              icon: Icons.attach_money, 
              keyboardType: TextInputType.phone,
              onChanged: (text) {
                context.read<ClientMapBookingInfoBloc>().add(FareOfferedChanged(fareOffered: BlocFormItem(value: text)));
              },
              validator: (value) {
                return widget.state.fareOffered.error;
              },
            ),
            _actionProfile(
              'BUSCAR CONDUCTOR',
              Icons.search,
              () {
                context.read<ClientMapBookingInfoBloc>().add(CreateClientRequest());
              }
            ),
            SizedBox(height: 20),
          ],
        ),
      )
    );
  }

  Widget _actionProfile(String option, IconData icon, Function() function) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 0, top: 15),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            option,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 19, 58, 213),
                  Color.fromARGB(255, 65, 173, 255),
                ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleMaps(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.53,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: widget.state.cameraPosition,
        markers: Set<Marker>.of(widget.state.markers.values),
        polylines: Set<Polyline>.of(widget.state.polylines.values),
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
          if (!widget.state.controller!.isCompleted) {
            widget.state.controller?.complete(controller); 
          }
        },
      ),
    );
  }
}