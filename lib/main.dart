import 'package:agenda_puntos/src/block/mapa/mapa_bloc.dart';
import 'package:agenda_puntos/src/block/ubicacion/ubicacion_bloc.dart';
import 'package:agenda_puntos/src/pages/mapa_punto.dart';
import 'package:agenda_puntos/src/pages/nuevo_punto_page.dart';
import 'package:agenda_puntos/src/pages/puntos_pages.dart';
import 'package:agenda_puntos/src/preferencias/preferencias.dart';
import 'package:agenda_puntos/src/preferencias/punto_provider_db.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:agenda_puntos/src/provider/punto_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UbicacionBloc()),
          BlocProvider(create: (_) => MapaBloc()),
        ],
        child: MultiProvider(
            providers: [
              //ChangeNotifierProvider(create: (BuildContext context) => new InputPuntoProvider()),
              ChangeNotifierProvider(create: (_) => new PuntoProviderDb()),

            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Gestion Puntos',
              initialRoute: 'puntos',
              routes: {
                'puntos': (BuildContext context) => PuntosPage(),
                'mapa_punto': (BuildContext context) => MapaPunto(),
                'nuevo_punto': (BuildContext context) => NvoPuntoPage()
              },
              theme: ThemeData(
                primaryColor: Colors.blueAccent,
              ),
            )));
  }
}


