import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverCarInfo.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultIconBack.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultTextField.dart';

class DriverCarInfoContent extends StatelessWidget {

  DriverCarInfoState state;

  DriverCarInfoContent(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Column(
            children: [
              _headerProfile(context),
              Spacer(),
              //_actionProfile(context, 'ACTUALIZAR DATOS', Icons.check),
              SizedBox(height: 35,)
            ],
          ),
          _cardUserInfo(context),
           //DefaultIconBack(
            // margin: EdgeInsets.only(top: 20, left: 30),
           //)
        ],
      ),
    );
  }
 
  Widget _cardUserInfo(BuildContext context) {
  // Función auxiliar para construir la línea de información de solo lectura
  Widget _buildReadOnlyField(String label, String value, IconData icon) {
    return Container(
      // Usamos el margen que tenías en DefaultTextField para la separación
      margin: EdgeInsets.only(left: 30, right: 30, top: 15),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      // Mantenemos el color de fondo gris claro para simular el campo
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5.0), // O el radio que usara DefaultTextField
      ),
      child: Row(
        children: [
          // Icono a la izquierda
          Icon(
            icon,
            color: Colors.grey[700], // Color del icono
          ),
          SizedBox(width: 15),
          // Columna para la etiqueta y el valor (simula el hint y el texto)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Etiqueta (lo que antes era el 'text' del DefaultTextField)
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 3),
              // Valor real (lo que antes era el 'initialValue')
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600, // Un poco de énfasis en el valor
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Widget Principal ---
  return Container(
    margin: EdgeInsets.only(left: 35, right: 35, top: 100),
    width: MediaQuery.of(context).size.width,
    // **Aumenta este valor**
    height: MediaQuery.of(context).size.height * 0.50, // Por ejemplo, de 0.35 a 0.40 o 0.42
    child: Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 40),
          _buildReadOnlyField(
            'Marca del vehiculo',
            state.brand.value,
            Icons.directions_car,
          ),
          _buildReadOnlyField(
            'Placa del vehiculo',
            state.plate.value,
            Icons.directions_car_filled,
          ),
          _buildReadOnlyField(
            'Color',
            state.color.value,
            Icons.color_lens,
          ),
        ],
      ),
    ),
  );
}

  Widget _actionProfile(BuildContext context, String option, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (state.formKey!.currentState != null) {
          if (state.formKey!.currentState!.validate()) {
            context.read<DriverCarInfoBloc>().add(FormSubmit());
          }
        }
        else {
          context.read<DriverCarInfoBloc>().add(FormSubmit());
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: ListTile(
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

  Widget _headerProfile(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(1, 1, 1, 1),
                Color.fromARGB(1, 1, 1, 1),
          ]
        ),
      ),
      child: Text(
        'DATOS DEL VEHICULO',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 19,
          fontFamily: 'MazzardH',
        ),
      ),
    );
  }
}