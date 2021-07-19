import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as ImgLib;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formateaFecha(String fecha) {
  final fc=DateTime.parse(fecha);
  return DateFormat('dd/MM/yyyy').format(fc);
}

String extraeHora(String fecha) {
  final fc=DateTime.parse(fecha);
  return DateFormat('HH:mm').format(fc);

}
String numberFormat(double x) {
  List<String> parts = x.toString().split('.');
  RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

  parts[0] = parts[0].replaceAll(re, '.');
  /**
  if (parts.length == 1) {
    parts.add('00');
  } else {
    parts[1] = parts[1].padRight(2, '0').substring(0, 2);
  }
      **/
  return parts[0].replaceAll(re, '.');
}
Image base64ToImagen(String base64) {
  final decodedBytes = base64Decode(base64);
  return new Image.memory(decodedBytes);
}

String resizeMyImageString64(String base64,int alto) {
  var image =  ImgLib.decodeImage(base64Decode(base64));
  var thumbnail = ImgLib.copyResize(image, height: alto);
  return base64Encode(ImgLib.encodeJpg(thumbnail));
}
String resizeMyImageFile64(File f,int alto) {
  var image =  ImgLib.decodeImage(f.readAsBytesSync());
  var thumbnail = ImgLib.copyResize(image, height: alto);
  // writeAsBytes(encodePng(thumbnail))
  String b64=base64Encode(ImgLib.encodeJpg(thumbnail));
  return b64;
}

