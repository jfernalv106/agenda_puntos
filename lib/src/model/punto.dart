import 'dart:convert';

import 'package:agenda_puntos/src/model/ruta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Punto> puntoFromJson(String str) =>
    List<Punto>.from(json.decode(str).map((x) => Punto.fromJson(x)));

String puntoToJson(List<Punto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Punto {
  Punto({
    this.cantidad,
    this.fecha,
    this.fotos,
    this.estado,
    this.id,
    this.tipo,
    this.persona,
    this.lugar,
    this.valorMetro,
    this.latitud,
    this.longitud,
    this.ruta,
    this.v,
    this.pagado,
    this.observaciones,
  });

  List<double> cantidad;
  String fecha;
  List<String> fotos;
  String estado;
  String id;
  String tipo;
  String persona;
  String lugar;
  int valorMetro;
  double latitud;
  double longitud;
  List<Ruta> ruta;
  int v;
  int pagado;
  String observaciones;

  factory Punto.fromJson(Map<String, dynamic> json) => Punto(
        cantidad: List<double>.from(json["cantidad"].map((x) => x / 1)),
        fecha: json["fecha"],
        fotos: List<String>.from(json["fotos"].map((x) => x)),
        estado: json["estado"],
        id: json["_id"],
        tipo: json["tipo"],
        persona: json["persona"],
        lugar: json["lugar"],
        valorMetro: json["valor_metro"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        ruta: List<Ruta>.from(json["ruta"].map((x) => Ruta.fromJson(x))),
        v: json["__v"],
        pagado: json["pagado"] == null ? null : json["pagado"],
        observaciones:
            json["observaciones"] == null ? null : json["observaciones"],
      );

  Map<String, dynamic> toJson() => {
        "cantidad": List<dynamic>.from(cantidad.map((x) => x)),
        // "fecha": fecha== null ? null : fecha,
        "fotos": List<dynamic>.from(fotos.map((x) => x)),
        "estado": estado == null ? 'creada' : estado,
        // "_id": id== null ? null : id,
        "tipo": tipo,
        "persona": persona,
        "lugar": lugar,
        "valor_metro": valorMetro,
        "latitud": latitud,
        "longitud": longitud,
        "ruta":
            ruta == null ? [] : List<dynamic>.from(ruta.map((x) => x.toJson())),

        "pagado": pagado == null ? 0 : pagado,
        "observaciones":
            observaciones == null ? 'Sin Observaciones' : observaciones,
      };

  double getTotalMetros() {
    double r = 0.0;
    for (double c in cantidad) {
      r += c;
    }
    return r;
  }

  int getTotalValor() {
    return ((valorMetro ?? 0.0) * getTotalMetros()).toInt();
  }

  LatLng getLatLng() {
    return LatLng(latitud, longitud);
  }

  List<LatLng> getRutas() {
    List<LatLng> aux = new List();
    for (Ruta r in ruta) {
      aux.add(LatLng(r.latitud, r.longitud));
    }
    return aux;
  }
}
