import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/provider_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InputValorMetro extends StatelessWidget {
  final InputPuntoProvider bloc;
  InputValorMetro({@required this.bloc});

  @override
  Widget build(BuildContext context) {
   // final bloc = ProviderInput.of(context);
    return StreamBuilder(
      stream: bloc.tipoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],

            decoration: InputDecoration(
                labelText: 'Valor',
                hintText: 'Valor',
                helperText: 'Ingrese valor metro',
                errorText: snapshot.error),
            onChanged: bloc.changeValor,
          ),
        );
      },
    );
  }
}
