import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/ProfileInfoContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoState.dart';
// Importaciones para la navegación al Home (Mapa)
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    // Envolvemos el Scaffold con WillPopScope para manejar el botón físico de atrás
    return WillPopScope(
      onWillPop: () async {
        // Enviamos el evento para cambiar la página del menú al Mapa (Índice 0)
        context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 0));
        // Retornamos false para evitar que la aplicación se cierre o haga pop de la ruta
        return false;
      },
      child: Scaffold(
        body: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
          builder: (context, state) {
            return ProfileInfoContent(state.user);
          },
        ),
      ),
    );
  }
}
