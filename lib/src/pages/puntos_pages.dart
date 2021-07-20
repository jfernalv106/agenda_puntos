import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:agenda_puntos/src/provider/punto_provider.dart';
import 'package:agenda_puntos/src/widget/card_puntos.dart';
import 'package:agenda_puntos/src/widget/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PuntosPage extends StatelessWidget {
  final puntoProvider = new PuntoProvider();

  @override
  Widget build(BuildContext context) {
    Get.put(InputController());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Puntos'),
        backgroundColor: Color.fromRGBO(17, 66, 0, 0.788235294117647),
      ),
      drawer: MenuLateral(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: _swiperTarjeta(),
        ),
      ),
    ));
  }

  Widget _swiperTarjeta() {
    return FutureBuilder(
        future: puntoProvider.getPuntos(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return CardPuntos(puntos: snapshot.data);
            }
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
