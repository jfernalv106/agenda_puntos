import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Get.find<InputController>();
    return StreamBuilder(
      stream: bloc.ubicacionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: 'Ubicacion',
                hintText: 'Ubicacion',
                helperText: 'Ingrese Ubicación',
                errorText: snapshot.error),
            onChanged: bloc.changeUbicacion,
          ),
        );
      },
    );
  }
}
