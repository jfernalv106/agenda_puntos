import 'dart:convert' as Convert;
import 'dart:io';

import 'package:agenda_puntos/src/model/punto.dart';
import 'package:agenda_puntos/src/model/punto_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if ( _database != null ) return _database;

    _database = await initDB();

    return _database;

  }
  Future<Database> initDB() async{

    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'Punto.db' );
    print( path );

    // Crear base de datos
    return await openDatabase(
        path,
        version: 1,
        onOpen: (db) { },
        onCreate: ( Database db, int version ) async {

          await db.execute('''
          CREATE TABLE punto(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            punto TEXT
          )
        ''');
        }
    );
  }
  Future<int> nuevoPuntoRaw( Punto punto ) async {

    final pto  = Convert.json.encode(punto);

    // Verificar la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO punto( punto )
        VALUES(  '$pto' )
    ''');

    return res;
  }
  Future<PuntoDb> getPuntoById( int id ) async {

    final db  = await database;
    final res = await db.query('punto', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
        ? PuntoDb.fromJson( res.first )
        : null;
  }

  Future<List<PuntoDb>> getTodosLosPuntos() async {

    final db  = await database;
    final res = await db.query('punto');

    return res.isNotEmpty
        ? res.map( (s) => Punto.fromJson(s) ).toList()
        : [];
  }

  Future<List<PuntoDb>> getPuntoPorPunto( Punto punto ) async {

    final db  = await database;
    final res = await db.rawQuery('''
      SELECT * FROM punto WHERE punto = '$punto'    
    ''');

    return res.isNotEmpty
        ? res.map( (s) => PuntoDb.fromJson(s) ).toList()
        : [];
  }


  Future<int> updatePunto( PuntoDb punto ) async {
    final db  = await database;
    final res = await db.update('punto', punto.toJson(), where: 'id = ?', whereArgs: [ punto.id ] );
    return res;
  }

  Future<int> deletePunto( int id ) async {
    final db  = await database;
    final res = await db.delete( 'punto', where: 'id = ?', whereArgs: [id] );
    return res;
  }

  Future<int> deleteAllPuntos() async {
    final db  = await database;
    final res = await db.rawDelete('''
      DELETE FROM punto    
    ''');
    return res;
  }
}