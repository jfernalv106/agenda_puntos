import 'dart:async';
import 'dart:convert';

import 'package:agenda_puntos/src/model/punto.dart';
import 'package:agenda_puntos/src/model/respuesta.dart';
import 'package:agenda_puntos/src/util/constantes.dart' as cons;
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class PuntoProvider {
  List<Punto> _puntos = new List();
  final _puntosStream = StreamController<List<Punto>>.broadcast();

  Function(List<Punto>) get puntosSink => _puntosStream.sink.add;

  Stream<List<Punto>> get puntosStream => _puntosStream.stream;

  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  Options _cacheOptions = buildCacheOptions(Duration(days: 3),
      maxStale: Duration(days: 7), forceRefresh: true);

  void disposeStream() {
    _puntosStream?.close();
  }

  Future<List<Punto>> getPuntos() async {
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    final resp =
        await _dio.get(cons.url + '/api/puntos', options: _cacheOptions);

    Map<String, dynamic> decodedResp = json.decode(resp.toString());
    if (decodedResp.containsKey('puntos')) {
      final pto = decodedResp['puntos'];
      final total = decodedResp['total'];

      final ord = (decodedResp['puntos'] as List)
          .map((x) => Punto.fromJson(x))
          .toList();
      this._puntos.addAll(ord);
      puntosSink(this._puntos);
    }
    return this._puntos;
  }

  Future<Respuesta> entregaPunto(Punto punto) async {
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager.interceptor);
    final resp = await _dio.post(cons.url + '/api/puntos',
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
        ),
        data: punto.toJson());
    print(resp.data);
    return Respuesta.fromJson(resp.data);
  }
}
