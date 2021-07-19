part of 'ubicacion_bloc.dart';

@immutable
class UbicacionState {
  final bool siguiendo;
  final bool existeUbicacion;
  final LatLng ubicacion;

  UbicacionState({
    this.siguiendo = true,
    this.existeUbicacion = false,
    this.ubicacion
  });

  UbicacionState copyWith({
    bool siguiendo,
    bool existeUbicacion,
    LatLng ubicacion,
  }) => new UbicacionState(
    siguiendo       : siguiendo ?? this.siguiendo,
    existeUbicacion : existeUbicacion ?? this.existeUbicacion,
    ubicacion       : ubicacion ?? this.ubicacion,
  );


}


