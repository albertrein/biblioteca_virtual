import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:biblioteca_virtual/Models/biblioteca.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

//Manipula o sqlite
class DatabaseHelper {
 // static DatabaseHelper _databaseHelper; //SINGLETON//PADRAO DE PROJETO
 // static Database _database; // singleton database
  String bibliotecaTable = 'livro_table';
  String colId = 'id';
  String colTitulo = 'titulo';
  String colAutor = 'autor';
  String colEditora = 'editora';
  String colLido = 'lido';

  DatabaseHelper(); //Construtor nomeado.
  DatabaseHelper._createInstancia(); //Construtor nomeado.

/*Código do flutter */
  DatabaseHelper.ensureInitialized();

  static final Future<Database> database = getDatabasesPath().then((String path) {
    return openDatabase(
      join(path, 'biblioteca_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'Create table livro_table(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT,'
          'autor TEXT, editora Text, lido INTEGER)'
        );
      },
      version: 1,
    );
  });

  Future<int> insereLivro(BibliotecaVirtual biblioteca) async {
    final db = await database;
    return await db.insert(
      bibliotecaTable,
      biblioteca.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future <List<BibliotecaVirtual>> listaDeTodosOsLivros() async {
    final db = await database;

    var maps = await db.query('livro_table');

    int count = maps.length;
      List<BibliotecaVirtual> livros = [];
      for(int i=0;i<count; i++){
        livros.add(BibliotecaVirtual.fromMapObject(maps[i]));
      }
      return livros;
    
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    //return maps.isNotEmpty ? BibliotecaVirtual.fromMap(maps.first) : Null ;
    /*List<BibliotecaVirtual> list = maps.isNotEmpty ? maps.map((c) => BibliotecaVirtual.fromMap(c)).toList() : [];
    return maps.toList();*/
  }

  Future<int> excluiLivro(int id) async{
    final db = await database;

    int result = await db.rawDelete('DELETE FROM $bibliotecaTable  WHERE $colId=$id');
    return result;
}

}