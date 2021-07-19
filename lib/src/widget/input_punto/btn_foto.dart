import 'dart:io';
import 'package:agenda_puntos/src/provider/nuevo_punto/input_provider.dart';
import 'package:agenda_puntos/src/provider/nuevo_punto/provider_input.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agenda_puntos/src/util/util.dart' as Util;
import 'package:provider/provider.dart';

class BtnFoto extends StatefulWidget {
  final InputPuntoProvider bloc;
  BtnFoto({@required this.bloc});
  @override
  _BtnFotoState createState() => _BtnFotoState(bloc: this.bloc);
}

class _BtnFotoState extends State<BtnFoto> {
  final InputPuntoProvider bloc;
  _BtnFotoState({@required this.bloc});
  File foto;

  @override
  Widget build(BuildContext context) {
   // final bloc = ProviderInput.of(context);

    return IconButton(
      icon: Icon(Icons.camera_alt),
      onPressed:() {_tomarFoto(bloc);},
    );
  }

  _tomarFoto(InputPuntoProvider bloc) async {

    _procesarImagen(ImageSource.camera, bloc);
  }

  _procesarImagen(ImageSource origen, InputPuntoProvider bloc) async {
    PickedFile selectedFile = await ImagePicker().getImage(source: origen);
    this.foto = File(selectedFile.path);
    List<String> fotos = new List();
    if (bloc.fotos == null) {
      bloc.changeFotos(fotos);
    } else {
      fotos.addAll(bloc.fotos);
    }

    setState(() {
    if (foto != null) {
      //fotos.add(Util.resizeMyImageFile64(foto, 600));
      fotos.add(foto.path);
      GallerySaver.saveImage(foto.path);

      bloc.changeFotos(fotos);
    }
    print(bloc.fotos);

    });
  }
}
