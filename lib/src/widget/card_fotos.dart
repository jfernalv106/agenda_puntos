import 'package:agenda_puntos/src/model/punto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardFotos extends StatelessWidget {
  final Punto punto;

  CardFotos({@required this.punto});

  @override
  Widget build(BuildContext context) {
    final _screamSize = MediaQuery
        .of(context)
        .size;
    final _screamsize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(top: 15.0),
        width: _screamSize.width,
        height: _screamSize.height * 0.3,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
                 final tarjeta=ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: FadeInImage(
                      image: NetworkImage(punto.fotos[index]),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      fit: BoxFit.cover,
                    ));
            return GestureDetector(
              child: tarjeta,
              onTap: () {
                Navigator.pushNamed(context, 'detalle', arguments: punto);
              },
            );
          },
          layout: SwiperLayout.STACK,
          itemCount: this.punto.fotos.length,
          itemWidth: _screamsize.width * 0.85,
          itemHeight: _screamsize.height * 0.9,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ),

    );
  }
}
