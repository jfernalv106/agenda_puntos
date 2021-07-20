import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:agenda_puntos/src/model/punto.dart';
import 'package:agenda_puntos/src/preferencias/punto_provider_db.dart';
import 'package:agenda_puntos/src/provider/punto_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BtnGuardar extends StatefulWidget {
  @override
  _BtnGuardarState createState() => _BtnGuardarState();
}

class _BtnGuardarState extends State<BtnGuardar> {
  final puntoProvider = new PuntoProvider();
  final puntoProviderDB = new PuntoProviderDb();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Guardar'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: () => _guarda(context));
  }

  _guarda(BuildContext context) {
    final bloc = Get.find<InputController>();
    if (bloc.habilitaForm()) {
      final bloc = Get.find<InputController>();
      final abono = num.tryParse(bloc.abono ?? '0');
      final valor = num.tryParse(bloc.valor);
      List<double> cantidad = new List();
      for (double c in bloc.cantidades) {
        cantidad.add(c);
      }
      List<String> fotos = new List();
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
          observaciones: (bloc.observaciones != ''
              ? bloc.observaciones
              : 'Sin observaciones'),
          latitud: bloc.latitud,
          longitud: bloc.longitud);
      print(punto.toJson().toString());
      // puntoProviderDB.nuevoPuntoDb(punto);
      puntoProvider.entregaPunto(punto);
      //bloc.cantidades.clear();
      bloc.limpia();
      Navigator.pushNamed(context, 'puntos');
    } else {
      print('debe ingresar datos mandatorios');
    }
  }
}
