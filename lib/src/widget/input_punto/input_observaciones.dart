import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InpuntObservaciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Get.find<InputController>();
    return StreamBuilder(
      stream: bloc.observacionesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: 'observaciones',
                hintText: 'Observaciones',
                helperText: 'Ingrese Observación',
                errorText: snapshot.error),
            onChanged: bloc.changeObservaciones,
          ),
        );
      },
    );
  }
}
