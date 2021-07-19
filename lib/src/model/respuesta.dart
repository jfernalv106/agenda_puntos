import 'dart:convert';

import 'package:agenda_puntos/src/model/error.dart';

Respuesta respuestaFromJson(String str) => Respuesta.fromJson(json.decode(str));

String respuestaToJson(Respuesta data) => json.encode(data.toJson());

class Respuesta {
  Respuesta({
    this.errors,
  });

  List<MensajeError> errors;

  factory Respuesta.fromJson(Map<String, dynamic> json) => Respuesta(
    errors: List<MensajeError>.from(json["errors"].map((x) => MensajeError.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
  };
}