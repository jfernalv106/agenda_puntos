import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputValorPagado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Get.find<InputController>();
    return StreamBuilder(
      stream: bloc.abonoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
                labelText: 'Pagado',
                hintText: 'Pagado',
                helperText: 'Ingrese Monto Pagado',
                errorText: snapshot.error),
            onChanged: bloc.changeAbono,
          ),
        );
      },
    );
  }
}
