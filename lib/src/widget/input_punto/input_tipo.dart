import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/provider_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputTipo extends StatefulWidget {
  final InputPuntoProvider bloc;
  InputTipo({@required this.bloc});
  @override
  _InputTipoState createState() => _InputTipoState(bloc: this.bloc);
}

class _InputTipoState extends State<InputTipo> {
  final InputPuntoProvider bloc;
  _InputTipoState({@required this.bloc});
  Widget build(BuildContext context) {

      return Container(
        padding: EdgeInsets.only(left: 20.0),
        child: _dropDownSelect(),
      );

  }

  List<DropdownMenuItem<String>> getListaDrop(List<String> list) {
    final _screamsize = MediaQuery.of(context).size;
    List<DropdownMenuItem<String>> lista = new List<DropdownMenuItem<String>>();
    list.forEach((act) {
      lista.add(DropdownMenuItem(
        child: Container(width:_screamsize.width*0.4,child: Text(act)) ,
        value: act,
      ));
    });
    return lista;
  }

  Widget _dropDownSelect() {
    List<String> list = ['Eucaliptus', 'Pino','Pino Grueso'];
   // final bloc = ProviderInput.of(context);
    return StreamBuilder(
        stream: bloc.tipoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot)
    {
      return Row(
        children: <Widget>[
          Container(
              child: DropdownButton(
                  value: bloc.tipo,
                  items: getListaDrop(list),
                  onChanged:  bloc.changeTipo ))
        ],
      );
    });
  }
}
