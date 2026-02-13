import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/ClientDriverOffersItem.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersState.dart';
import 'package:lottie/lottie.dart';

class ClientDriverOffersPage extends StatefulWidget {
  const ClientDriverOffersPage({super.key});

  @override
  State<ClientDriverOffersPage> createState() => _ClientDriverOffersPageState();
}

class _ClientDriverOffersPageState extends State<ClientDriverOffersPage> {

  int? idClientRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 1. LIMPIEZA AL ENTRAR
      context.read<ClientDriverOffersBloc>().add(ClearDriverOffers());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Captura del argumento (ID del viaje)
    if (idClientRequest == null) {
       idClientRequest = ModalRoute.of(context)?.settings.arguments as int?;
       if (idClientRequest != null) {
         // Iniciar escucha solo si tenemos ID
         context.read<ClientDriverOffersBloc>().add(ListenNewDriverOfferSocketIO(idClientRequest: idClientRequest!));
       }
    }

    // 2. WILLPOPSCOPE PARA CANCELAR
    return WillPopScope(
      onWillPop: () async {
        return await _showCancelDialog();
      },
      child: Scaffold(
        // Agregué una AppBar simple para poder cancelar si no tienes gestos
        appBar: AppBar(
          title: Text('Esperando ofertas', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
               _showCancelDialog().then((shouldPop) {
                  if (shouldPop) Navigator.pop(context);
               });
            },
          ),
        ),
        body: BlocListener<ClientDriverOffersBloc, ClientDriverOffersState>(
          listener: (context, state) {
            final response = state.responseDriverOffers;
            final responseAssignDriver = state.responseAssignDriver;
            
            if (response is ErrorData) {
              Fluttertoast.showToast(
                msg: response.message ?? 'Error desconocido',
                toastLength: Toast.LENGTH_LONG,
              );
            }
            if (responseAssignDriver is Success) {
              Navigator.pushNamed(context, 'client/map/trip', arguments: idClientRequest);
            }
          },
          child: BlocBuilder<ClientDriverOffersBloc, ClientDriverOffersState>(
            builder: (context, state) {
              final response = state.responseDriverOffers;

              // ESTADO: CARGANDO O VACÍO (Limpieza efectiva)
              if (response == null || response is Loading) {
                return _buildWaitingAnimation();
              } 
              
              // ESTADO: ÉXITO
              else if (response is Success) {
                List<DriverTripRequest> driverTripRequest = response.data as List<DriverTripRequest>;
                
                if (driverTripRequest.isEmpty) {
                   return _buildWaitingAnimation();
                }

                return ListView.builder(
                  itemCount: driverTripRequest.length,
                  itemBuilder: (context, index) {
                    return ClientDriverOffersItem(driverTripRequest[index]);
                  },
                );
              }
              
              // ESTADO: DEFAULT
              return _buildWaitingAnimation();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWaitingAnimation() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Esperando conductores...',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          Lottie.asset(
            'assets/lottie/waiting_car.json',
            width: 400,
            height: 230,
          )
        ],
      ),
    );
  }

  Future<bool> _showCancelDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancelar Solicitud'),
        content: Text('¿Desea cancelar la solicitud de viaje?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (idClientRequest != null) {
                 context.read<ClientDriverOffersBloc>().add(CancelRequest(idClientRequest: idClientRequest!));
              }
              Navigator.of(context).pop(true);
            },
            child: Text('Sí, Cancelar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ?? false;
  }
}
