import 'dart:async';

import 'package:agenda_puntos/src/controler/validador.dart';
import 'package:rxdart/rxdart.dart';

class InputPuntoProvider   with Validador {

  final _nombreController = BehaviorSubject<String>();
  final _ubicacionController = BehaviorSubject<String>();
  final _tipoController = BehaviorSubject<String>();
  final _cantidadController = BehaviorSubject<double>();
  final _valorController = BehaviorSubject<String>();
  final _abonoController = BehaviorSubject<String>();
  final _observacionesController = BehaviorSubject<String>();
  final _cantidadesController = BehaviorSubject<List<double>>();
  final _fotosController = BehaviorSubject<List<String>>();
  final _latitudController = BehaviorSubject<double>();
  final _longitudController = BehaviorSubject<double>();

  // Recuperar los datos del Stream
  Stream<String> get nombreStream => _nombreController.stream.transform(validarTexto);
  Stream<String> get ubicacionStream => _ubicacionController.stream.transform(validarTexto);
  Stream<String> get tipoStream =>_tipoController.stream.transform(validarTexto);
 
  Stream<String> get valorStream => _valorController.stream.transform(validarValor);
  Stream<String> get abonoStream => _abonoController.stream;
  Stream<String> get observacionesStream => _observacionesController.stream;
  Stream<List<double>> get cantidadesStream => _cantidadesController.stream;
  Stream<List<String>> get fotosStream => _fotosController.stream;
  Stream<double> get latitudStream => _latitudController.stream;
  Stream<double> get longitusStream => _longitudController.stream;

  Stream<bool> get formValidStream => Observable.combineLatest8(
      nombreStream,
      ubicacionStream,
      tipoStream,
      cantidadesStream,
      valorStream,
      fotosStream,
      latitudStream,
      longitusStream,
      (a, b, c, d, e, f, g, h) => true);

  // Insertar valores al Stream
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeUbicacion => _ubicacionController.sink.add;
  Function(String) get changeTipo => _tipoController.sink.add;
  Function(double) get changeCantidad => _cantidadController.sink.add;
  Function(String) get changeValor => _valorController.sink.add;
  Function(String) get changeAbono => _abonoController.sink.add;
  Function(String) get changeObservaciones => _observacionesController.sink.add;
  Function(List<double>) get changeCantidades => _cantidadesController.sink.add;
  Function(List<String>) get changeFotos => _fotosController.sink.add;
  Function(double) get changeLatitud => _latitudController.sink.add;
  Function(double) get changeLongitud => _longitudController.sink.add;



  String get nombre => _nombreController.value;
  String get ubicacion => _ubicacionController.value;
  String get tipo => _tipoController.value;
  double get cantidad => _cantidadController.value;
  String get valor => _valorController.value;
  String get abono => _abonoController.value;
  String get observaciones => _observacionesController.value;
  List<double> get cantidades => _cantidadesController.value;
  List<String> get fotos => _fotosController.value;
  double get latitud => _latitudController.value;
  double get longitud => _longitudController.value;

  disposeCantidad() {
    _cantidadController?.close();
  }

  dispose() {

    _nombreController?.close();
    _ubicacionController?.close();
    _tipoController?.close();
    _cantidadController?.close();
    _valorController?.close();
    _abonoController?.close();
    _observacionesController?.close();
    _cantidadesController?.close();
    _fotosController?.close();
    _latitudController?.close();
    _longitudController?.close();

  }

}
