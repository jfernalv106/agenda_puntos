
import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/provider_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputNombre extends StatelessWidget {
  final InputPuntoProvider bloc;
  InputNombre({@required this.bloc});
  @override
  Widget build(BuildContext context) {
  //  final bloc = ProviderInput.of(context);
    return StreamBuilder(
      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Nombre',
                helperText: 'Ingrese Nombre',
                errorText: snapshot.error),
            onChanged: bloc.changeNombre,
          ),
        );
      },
    );
  }
}
