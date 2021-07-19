import 'dart:convert';

import 'package:agenda_puntos/src/model/punto.dart';
import 'package:agenda_puntos/src/model/punto_db.dart';
import 'package:agenda_puntos/src/provider/db_provider.dart';
import 'package:flutter/cupertino.dart';

class PuntoProviderDb extends ChangeNotifier {
  Punto _punto;
  List<PuntoDb> puntosDb=[];


  Future<PuntoDb> nuevoPuntoDb(Punto punto) async {
    final id = await DBProvider.db.nuevoPuntoRaw(punto);
    final puntoDb = new PuntoDb(id:id,punto:punto.toJson().toString());
    this.puntosDb.add(puntoDb);
    notifyListeners();
    return puntoDb;
  }
  cargarPuntos() async {
    final puntos = await DBProvider.db.getTodosLosPuntos();
    this.puntosDb = [...puntos];
    notifyListeners();
  }
  cargarPuntoPorPunto( Punto punto ) async {
    final puntos = await DBProvider.db.getPuntoPorPunto(punto);
    this.puntosDb = [...puntos];
    notifyListeners();
  }
  borrarTodos() async {
    await DBProvider.db.deleteAllPuntos();
    this.puntosDb = [];
    notifyListeners();
  }

  borrarPuntoPorId( int id ) async {
    await DBProvider.db.deletePunto(id);
  }
  Punto get punto {
    return _punto;
  }

  set punto(Punto punto) {
    this._punto = punto;
    notifyListeners();
  }
}
