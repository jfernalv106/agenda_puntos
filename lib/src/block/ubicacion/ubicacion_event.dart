part of 'ubicacion_bloc.dart';

@immutable
abstract class UbicacionEvent {}
class OnUbicacionCambio extends UbicacionEvent {

final LatLng ubicacion;
OnUbicacionCambio(this.ubicacion);

}
