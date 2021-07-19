import 'package:agenda_puntos/src/block/ubicacion/ubicacion_bloc.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/provider_input.dart';
import 'package:agenda_puntos/src/widget/input_punto/btn_foto.dart';
import 'package:agenda_puntos/src/widget/input_punto/btn_guardar.dart';
import 'package:agenda_puntos/src/widget/input_punto/inpunt_ubicacion.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_tipo.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_cantidades.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_nombre.dart';
import 'package:agenda_puntos/src/widget/input_punto/input_valor_metro.dart';
import 'package:agenda_puntos/src/widget/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    //final bloc = Provider.of<InputPuntoProvider>(context);

    final bloc = ProviderInput.of(context);
   cargaCordenadas(miUbicacionBloc,bloc);
    //

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Punto'),
        backgroundColor: Color.fromRGBO(17, 66, 0, 0.788235294117647),
        actions: <Widget>[
          BtnFoto(bloc: bloc),

        ],
      ),
      drawer: MenuLateral(),
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                InputNombre(bloc: bloc),
                InputUbicacion(bloc: bloc),
                Row(
                  children: <Widget>[
                    InputTipo(bloc: bloc),
                    Container(
                      width: _screamsize.width * 0.4,
                      child: InputValorMetro(bloc: bloc),
                    ),
                  ],
                ),
              InputCantidades(bloc: bloc),
                BtnGuardar(bloc: bloc),

              ],
            )),
      ),
    ));
  }
  cargaCordenadas(UbicacionBloc miUbicacionBloc,InputPuntoProvider bloc) async{
   await bloc.changeLatitud(miUbicacionBloc.state.ubicacion.latitude);
  await bloc.changeLongitud(miUbicacionBloc.state.ubicacion.longitude);
  }
}
