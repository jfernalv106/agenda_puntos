import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/provider_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputUbicacion extends StatelessWidget {
  final InputPuntoProvider bloc;
  InputUbicacion({@required this.bloc});
  @override
  Widget build(BuildContext context) {
    //final bloc = ProviderInput.of(context);
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
