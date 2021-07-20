import 'package:agenda_puntos/src/block/ubicacion/ubicacion_bloc.dart';
import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:agenda_puntos/src/widget/input_punto/btn_foto.dart';
import 'package:agenda_puntos/src/widget/input_punto/btn_guardar.dart';
import 'package:agenda_puntos/src/widget/input_punto/inpunt_pagado.dart';
import 'package:agenda_puntos/src/widget/input_punto/inpunt_ubicacion.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_cantidades.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_nombre.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_observaciones.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_tipo.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_valor_metro.dart';
import 'package:agenda_puntos/src/widget/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NvoPuntoPage extends StatefulWidget {
  @override
  _NvoPuntoPageState createState() => _NvoPuntoPageState();
}

class _NvoPuntoPageState extends State<NvoPuntoPage> {
  @override
  void initState() {
    context.read<UbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    context.read<UbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screamsize = MediaQuery.of(context).size;
    final miUbicacionBloc = context.read<UbicacionBloc>();

    cargaCordenadas(miUbicacionBloc);
    //

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Punto'),
        backgroundColor: Color.fromRGBO(17, 66, 0, 0.788235294117647),
        actions: <Widget>[
          BtnFoto(),
        ],
      ),
      drawer: MenuLateral(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InputNombre(),
                InputUbicacion(),
                InpuntObservaciones(),
                InputValorPagado(),
                Row(
                  children: <Widget>[
                    InputTipo(),
                    Container(
                      width: _screamsize.width * 0.4,
                      child: InputValorMetro(),
                    ),
                  ],
                ),
                InputCantidades(),
                BtnGuardar(),
              ],
            )),
      ),
    ));
  }

  cargaCordenadas(UbicacionBloc miUbicacionBloc) async {
    final bloc = Get.put(InputController());
    await bloc.changeLatitud(miUbicacionBloc.state.ubicacion.latitude);
    await bloc.changeLongitud(miUbicacionBloc.state.ubicacion.longitude);
  }
}
