import 'dart:convert';

List<PuntoDb> puntoDbFromJson(String str) => List<PuntoDb>.from(json.decode(str).map((x) => PuntoDb.fromJson(x)));

String puntoDbToJson(List<PuntoDb> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PuntoDb {
  PuntoDb({
    this.id,
    this.punto,
  });

  int id;
  String punto;

  factory PuntoDb.fromJson(Map<String, dynamic> json) => PuntoDb(
    id: json["id"],
    punto: json["punto"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "punto": punto,
  };
}