import 'dart:io';

import 'package:agenda_puntos/src/controler/input_punto_controller.dart';
import 'package:agenda_puntos/src/util/util.dart' as Util;
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BtnFoto extends StatefulWidget {
  @override
  _BtnFotoState createState() => _BtnFotoState();
}

class _BtnFotoState extends State<BtnFoto> {
  File foto;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.camera_alt),
      onPressed: () {
        _tomarFoto();
      },
    );
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    final bloc = Get.find<InputController>();
    PickedFile selectedFile = await ImagePicker().getImage(source: origen);
    this.foto = File(selectedFile.path);

    setState(() {
      if (foto != null) {
        //fotos.add(Util.resizeMyImageFile64(foto, 600));

        GallerySaver.saveImage(foto.path);

        //bloc.addFotos(Util.resizeMyImageFile64(foto, 600));
        bloc.addFotos(foto.path);
      }
    });
  }
}
