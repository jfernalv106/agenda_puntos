import 'package:agenda_puntos/src/block/ubicacion/ubicacion_bloc.dart';
import 'package:agenda_puntos/src/model/punto.dart';
import 'package:agenda_puntos/src/model/punto_db.dart';
import 'package:agenda_puntos/src/preferencias/punto_provider_db.dart';


import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/provider_input.dart';
import 'package:agenda_puntos/src/provider/punto_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class BtnGuardar extends StatefulWidget {
  final InputPuntoProvider bloc;
  BtnGuardar({@required this.bloc});
  @override
  _BtnGuardarState createState() => _BtnGuardarState(bloc: this.bloc);
}

class _BtnGuardarState extends State<BtnGuardar> {
  final InputPuntoProvider bloc;
  _BtnGuardarState({@required this.bloc});
  final puntoProvider = new PuntoProvider();
  final puntoProviderDB = new PuntoProviderDb();


  @override
  Widget build(BuildContext context) {
    //final bloc = ProviderInput.of(context);
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Guardar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _guarda(bloc, context) : null);
      },
    );
  }

  _guarda(InputPuntoProvider bloc, BuildContext context) {

    final abono = num.tryParse(bloc.abono??'0');
    final valor = num.tryParse(bloc.valor);
    List<int> cantidad=new List();
    for(double c in bloc.cantidades){
      cantidad.add(c.toInt());
    }
    List<String> fotos=new List();
    /**
    fotos.add('http://lorempixel.com/400/200/city/6');
    fotos.add('http://lorempixel.com/400/200/city/5');
    fotos.add('http://lorempixel.com/400/200/city/4');
    fotos.add('http://lorempixel.com/400/200/city/3');
**/
    Punto punto = new Punto(
      cantidad: cantidad,
      fotos: bloc.fotos,
      tipo: bloc.tipo,
      persona: bloc.nombre,
      lugar: bloc.ubicacion,
      valorMetro: valor,
      pagado: abono,
      observaciones: bloc.observaciones??'Sin observaciones',
      latitud: bloc.latitud,
      longitud: bloc.longitud
      );
    print(punto.toJson().toString());
  // puntoProviderDB.nuevoPuntoDb(punto);
    puntoProvider.entregaPunto(punto);
    //bloc.cantidades.clear();
bloc.dispose();

    Navigator.pushNamed(context, 'puntos');
  }

}
