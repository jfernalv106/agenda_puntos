import 'package:agenda_puntos/src/model/punto.dart';
import 'package:agenda_puntos/src/widget/card_fotos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agenda_puntos/src/util/util.dart' as Util;

class CardPuntos extends StatelessWidget {
  final List<Punto> puntos;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.7);

  CardPuntos({@required this.puntos});

  final _textStyle = TextStyle(fontSize: 13.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final _screamsize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        //siguientePagina();
      }
    });
    return Container(
      width: _screamsize.width,
      height: _screamsize.height * 0.99,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color.fromRGBO(189, 189, 189, 0.8549019607843137),
          Color.fromRGBO(99, 99, 99, 0.8),
        ]),
      ),
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: puntos.length,
        itemBuilder: (context, index) {
          return _tarjeta(context, puntos[index]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Punto punto) {
    final tarjeta = Container(
        margin: EdgeInsets.only(right: 5, top: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Color.fromRGBO(7, 7, 7, 0.8549019607843137),
            Color.fromRGBO(80, 80, 80, 0.8),
          ]),
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CardFotos(punto: punto),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                      title: Text(
                        punto.persona,
                        style: TextStyle(fontSize: 19.0, color: Colors.white),
                      ),
                      subtitle: Text('Estado: ${punto.estado}',
                          style: TextStyle(color: Colors.white))),
                  Text('Ubicacion: ${punto.lugar}', style: _textStyle),
                  Row(
                    children: <Widget>[
                      Text('Tipo: ${punto.tipo}', style: _textStyle),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Cantidad: ${punto.getTotalMetros()}',
                        style: _textStyle,
                      )
                    ],
                  ),
                  Text(
                      'pagado por metro: \$${Util.numberFormat(punto.valorMetro.toDouble())}',
                      style: _textStyle),
                  Row(
                    children: <Widget>[
                      Text('Fecha: ${Util.formateaFecha(punto.fecha)}',
                          style: _textStyle),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Hora: ${Util.extraeHora(punto.fecha)}',
                          style: _textStyle),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                          'valor total: \$${Util.numberFormat(punto.getTotalValor().toDouble())}',
                          style: _textStyle),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                          'Abono: \$${Util.numberFormat(punto.pagado.toDouble() ?? 0.0)}',
                          style: _textStyle),
                    ],
                  ),
                  Text('Observaciones: ${punto.observaciones ?? ''}',
                      style: _textStyle),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                IconButton(
                    icon: Icon(
                      Icons.map_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'mapa_punto',
                          arguments: punto);
                    }),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ));
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: punto);
      },
    );
  }
}
