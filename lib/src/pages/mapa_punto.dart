import 'package:agenda_puntos/src/block/mapa/mapa_bloc.dart';
import 'package:agenda_puntos/src/block/ubicacion/ubicacion_bloc.dart';
import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:agenda_puntos/src/model/punto.dart';
import 'package:agenda_puntos/src/widget/widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPunto extends StatefulWidget {
  @override
  _MapaPuntoState createState() => _MapaPuntoState();
}

class _MapaPuntoState extends State<MapaPunto> {
  @override
  void initState() {
    context.read<UbicacionBloc>().iniciarSeguimiento();
    //context.read<MapaBloc>().
    super.initState();
  }

  @override
  void dispose() {
    context.read<UbicacionBloc>().cancelarSeguimiento();
    context.read<MapaBloc>().cierraMapa();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Get.find<InputController>();
    final Punto _punto = bloc.punto;
    return Scaffold(
      body: BlocBuilder<UbicacionBloc, UbicacionState>(
          builder: (_, state) => crearMapa(state, _punto)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnPuntoAlmacenado(punto: _punto),
        ],
      ),
    );
  }

  Widget crearMapa(UbicacionState state, Punto punto) {
    Set<Marker> markers = new Set<Marker>();
    Set<Polyline> ruta = new Set<Polyline>();
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    markers.add(new Marker(
        markerId: MarkerId('geo-location'),
        position: punto.getLatLng(),
        infoWindow: InfoWindow(
          title: '20 metros euca',
        )));

    if (!punto.getRutas().isEmpty) {
      ruta.add(Polyline(
        polylineId: PolylineId(punto.getRutas()[0].toString()),
        visible: true,
        points: punto.getRutas(),
        color: Colors.blue,
      ));
    }

    if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));

    final cameraPosition =
        new CameraPosition(target: state.ubicacion, zoom: 15);
    final mapa = GoogleMap(
      initialCameraPosition: cameraPosition,
      markers: markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc.initMapa,
      mapType: MapType.hybrid,
    );

    return mapa;
  }
}
