import 'package:agenda_puntos/src/controler/validador.dart';
import 'package:agenda_puntos/src/model/punto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputController extends GetxController with Validador {
  final punto = new Punto().obs;
  final fotoss = new List<String>().obs;
  final cantidadess = new List<double>().obs;
  final nombreController = ''.obs;
  final ubicacionController = ''.obs;
  final tipoController = 'Pino'.obs;
  final cantidadController = 0.toDouble().obs;
  final valorController = ''.obs;
  final abonoController = '0'.obs;
  final observacionesController = ''.obs;
  final cantidadesController = List<double>().obs;
  final fotosController = List<String>().obs;
  final latitudController = (1 / 1).obs;
  final longitudController = (1 / 1).obs;
  final loginFormKey = GlobalKey<FormState>();

  Stream<String> get nombreStream =>
      nombreController.stream.transform(validarTexto);
  Stream<String> get ubicacionStream =>
      ubicacionController.stream.transform(validarTexto);
  Stream<String> get tipoStream =>
      tipoController.stream.transform(validarTexto);
  Stream<double> get cantidadStream =>
      cantidadController.stream.transform(validarCantidad);
  Stream<String> get valorStream =>
      valorController.stream.transform(validarValor);
  Stream<String> get abonoStream => abonoController.stream;
  Stream<String> get observacionesStream => observacionesController.stream;
  Stream<List<double>> get cantidadesStream => cantidadesController.stream;
  Stream<List<String>> get fotosStream => fotosController.stream;
  Stream<double> get latitudStream => latitudController.stream;
  Stream<double> get longitusStream => longitudController.stream;

  bool habilitaForm() {
    if (nombreController.value != '' &&
        ubicacionController.value != '' &&
        valorController.value != '' &&
        !cantidadesController.value.isEmpty &&
        !fotosController.value.isEmpty &&
        latitudController.value != (1 / 1) &&
        longitudController.value != (1 / 1)) {
      return true;
    } else {
      return false;
    }
  }

  // Insertar valores al Stream
  changeNombre(String valor) => nombreController(valor);
  changeUbicacion(String valor) => ubicacionController(valor);
  changeTipo(String valor) => tipoController(valor);
  changeCantidad(double valor) => cantidadController(valor);
  changeValor(String valor) => valorController(valor);
  changeAbono(String valor) => abonoController(valor);
  changeObservaciones(String valor) => observacionesController(valor);
  changeCantidades(List<double> valor) => cantidadesController.addAll(valor);
  addCantidades(double valor) => cantidadesController.add(valor);
  changeFotos(List<String> valor) => fotosController.addAll(valor);
  addFotos(String valor) => fotosController.add(valor);
  changeLatitud(double valor) => latitudController(valor);
  changeLongitud(double valor) => longitudController(valor);

  String get nombre => nombreController.value;
  String get ubicacion => ubicacionController.value;
  String get tipo => tipoController.value;
  double get cantidad => cantidadController.value;
  String get valor => valorController.value;
  String get abono => abonoController.value;
  String get observaciones => observacionesController.value;
  List<double> get cantidades => cantidadesController.value;
  List<String> get fotos => fotosController.value;
  double get latitud => latitudController.value;
  double get longitud => longitudController.value;

  @override
  void onInit() {
    // Simulating obtaining the user name from some local storage

    punto.value = new Punto();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String validator(String value) {
    if (value.isEmpty) {
      return 'Ingrese texto';
    }
    return null;
  }

  void login() {
    if (loginFormKey.currentState.validate()) {}
  }

  // Api Simulation
  Future<bool> checkUser(String user, String password) {
    if (user == 'foo@foo.com' && password == '123') {
      return Future.value(true);
    }
    return Future.value(false);
  }

  void changePuntoCantidad(double cantidad) {
    this.punto.update((val) {
      val?.cantidad.add(cantidad);
    });
  }

  void removePuntoCantidad(double cantidad) {
    this.punto.update((val) {
      val?.cantidad.remove(cantidad);
    });
  }

  void changePuntoFotos(String foto) {
    this.punto.update((val) {
      val?.fotos?.add(foto);
    });
  }

  void removePuntoFotos(String foto) {
    this.punto.update((val) {
      val?.fotos.remove(foto);
    });
  }

  void changePuntoTipo(String tipo) {
    this.punto.update((val) {
      val?.tipo = tipo;
    });
  }

  void changePuntoPersona(String persona) {
    this.punto.update((val) {
      val?.persona = persona;
    });
  }

  void changePuntoLugar(String lugar) {
    this.punto.update((val) {
      val?.lugar = lugar;
    });
  }

  void changePuntoValorMetro(String valorMetro) {
    this.punto.update((val) {
      val?.valorMetro = num.tryParse(valorMetro);
    });
  }

  void changePuntoLatitud(double latitud) {
    this.punto.update((val) {
      val?.latitud = latitud;
    });
  }

  void changePuntoLongitud(double longitud) {
    this.punto.update((val) {
      val?.longitud = longitud;
    });
  }

  void changePuntoPagado(int pagado) {
    this.punto.update((val) {
      val?.pagado = pagado;
    });
  }

  void changePuntoObservaciones(String observaciones) {
    this.punto.update((val) {
      val?.observaciones = observaciones;
    });
  }

  void limpia() {
    punto.value = new Punto();
    fotoss.clear();
    cantidadess.clear();
    nombreController('');
    ubicacionController('');
    tipoController('Pino');
    cantidadController(1 / 1);
    valorController('');
    abonoController('0');
    observacionesController('');
    cantidadesController.clear();
    fotosController.clear();
    latitudController(1 / 1);
    longitudController(1 / 1);
  }
}
