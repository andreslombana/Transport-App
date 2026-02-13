import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/user.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/DriverCarInfoContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoState.dart';

// ⚠️ NECESARIO para que WillPopScope se comunique con el menú principal
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';


class DriverCarInfoPage extends StatefulWidget {
  const DriverCarInfoPage({super.key});

  @override
  State<DriverCarInfoPage> createState() => _DriverCarInfoPageState();
}

class _DriverCarInfoPageState extends State<DriverCarInfoPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverCarInfoBloc>().add(DriverCarInfoInitEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    // El WillPopScope envuelve el BlocListener para capturar el botón de atrás
    return WillPopScope(
      onWillPop: () async {
        // En lugar de navegar, enviamos un evento al Bloc de Home
        // para cambiar el índice de la página de vuelta a 0 (Mapa de Localización).
        // Esto resuelve el ciclo infinito que experimentabas.
        context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 0));
        
        // Devolvemos false para que el WillPopScope no intente un pop de la ruta
        // y el control quede solo en la lógica del Bloc.
        return false; 
      },
      
      child: BlocListener<DriverCarInfoBloc, DriverCarInfoState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(
  msg: response.message ?? 'Error desconocido',
  toastLength: Toast.LENGTH_LONG,
);
          }
          else if (response is Success) {
            Fluttertoast.showToast(msg: 'Actualizacion exitosa', toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<DriverCarInfoBloc, DriverCarInfoState>(
          builder: (context, state) {
            final response = state.response;
            if (response is Loading) {
              return Stack(
                children: [
                  DriverCarInfoContent(state),
                  Center(child: CircularProgressIndicator())
                ],
              );
            }
            return DriverCarInfoContent(state);
          },
        ),
      ),
    );
  }
}