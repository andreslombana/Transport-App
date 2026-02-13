import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/DriverClientRequestsItem.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsState.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';

class DriverClientRequestsPage extends StatefulWidget {
  const DriverClientRequestsPage({super.key});

  @override
  State<DriverClientRequestsPage> createState() => _DriverClientRequestsPageState();
}

class _DriverClientRequestsPageState extends State<DriverClientRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DriverClientRequestsBloc>().add(InitDriverClientRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 0));
        return false;
      },
      child: Scaffold(
        body: BlocListener<DriverClientRequestsBloc, DriverClientRequestsState>(
          listener: (context, state) {
            final responseCreateTripRequest =
                state.responseCreateDriverTripRequest;

            if (responseCreateTripRequest is Success) {
              Fluttertoast.showToast(
                msg: 'La oferta se ha enviado correctamente',
                toastLength: Toast.LENGTH_LONG,
              );
            } else if (responseCreateTripRequest is ErrorData) {
              Fluttertoast.showToast(
                msg: responseCreateTripRequest?.message ?? 'Error desconocido',
                toastLength: Toast.LENGTH_LONG,
              );
            }
          },
          child: BlocBuilder<DriverClientRequestsBloc,
              DriverClientRequestsState>(
            builder: (context, state) {
              final response = state.response;

              if (response is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (response is Success) {
                final List<ClientRequestResponse> clientRequests =
                    response?.data ?? [];

                if (clientRequests.isEmpty) {
                  return const Center(
                      child: Text(
                          'No hay solicitudes de viaje cerca de tu ubicación.'));
                }

                return ListView.builder(
                  itemCount: clientRequests.length,
                  itemBuilder: (context, index) {
                    return DriverClientRequestsItem(
                      state,
                      clientRequests[index],
                    );
                  },
                );
              }

              return const Center(child: Text('Buscando solicitudes...'));
            },
          ),
        ),
      ),
    );
  }
}

