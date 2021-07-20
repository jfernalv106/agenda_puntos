import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:flutter/material.dart';

class ProviderInput extends InheritedWidget {
  static ProviderInput _instancia;
  final bloc = InputPuntoProvider();

  factory ProviderInput({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderInput._internal(key: key, child: child);
    }

    return _instancia;
  }
  ProviderInput._internal({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ProviderInput of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderInput>();
  }
}
