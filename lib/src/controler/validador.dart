import 'dart:async';

class Validador {
  final validarTexto = StreamTransformer<String, String>.fromHandlers(
      handleData: (nombre, sink) {
    if (nombre.length >= 2) {
      sink.add(nombre);
    } else {
      sink.addError('Ingrese un texto valido');
    }
  });
  final validarValor =
      StreamTransformer<String, String>.fromHandlers(handleData: (valor, sink) {
    final n = num.tryParse(valor);
    if (n >= 10000) {
      sink.add(valor);
    } else {
      sink.addError('Ingrese un monto valido');
    }
  });
  final validarCantidad = StreamTransformer<double, double>.fromHandlers(
      handleData: (cantidad, sink) {
    if (cantidad > 0.toDouble()) {
      sink.add(cantidad);
    } else {
      sink.addError('Ingrese una cantidad superior a 0');
    }
  });
}
