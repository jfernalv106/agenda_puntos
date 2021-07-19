part of 'widget.dart';

class BtnPuntoAlmacenado extends StatelessWidget {
  final Punto punto;

  BtnPuntoAlmacenado({this.punto});

  @override
  Widget build(BuildContext context) {
    final mapaBloc = context.read<MapaBloc>();
    final miUbicacionBloc = context.read<UbicacionBloc>();

    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 25,
                  child: IconButton(
                    icon: Icon(Icons.map_outlined, color: Colors.black87),
                    onPressed: () {
                      mapaBloc.moverCamara(punto.getLatLng());
                    },
                  ),
                )),
            Container(
                margin: EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 25,
                  child: IconButton(
                    icon:
                        Icon(Icons.center_focus_strong, color: Colors.black87),
                    onPressed: () {
                      final destino = miUbicacionBloc.state.ubicacion;
                      mapaBloc.moverCamara(destino);
                    },
                  ),
                )),
          ],
        ));
  }
}
