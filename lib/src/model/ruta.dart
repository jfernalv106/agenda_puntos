class Ruta {
  Ruta({
    this.id,
    this.latitud,
    this.longitud,
  });

  String id;
  double latitud;
  double longitud;

  factory Ruta.fromJson(Map<String, dynamic> json) => Ruta(
    id: json["_id"],
    latitud: json["latitud"].toDouble(),
    longitud: json["longitud"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "latitud": latitud,
    "longitud": longitud,
  };
}