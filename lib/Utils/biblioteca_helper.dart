import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:biblioteca_virtual/Models/biblioteca.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class DatabaseHelper {
 // static DatabaseHelper _databaseHelper; //SINGLETON//PADRAO DE PROJETO
 // static Database _database; // singleton database
  String bibliotecaTable = 'livro_table';
  String colId = 'id';
  String colTitulo = 'titulo';
  String colAutor = 'autor';
  String colEditora = 'editora';
  String colLido = 'lido';

  DatabaseHelper();
  DatabaseHelper._createInstancia();

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

  Future<int> alteraLivro(BibliotecaVirtual biblioteca) async {
    final db = await database;
    return await db.update(
      bibliotecaTable,
      biblioteca.toMap(),
      where: '$colId =?',
      whereArgs: [biblioteca.id]
    );
  }

  Future <List<BibliotecaVirtual>> listaDeTodosOsLivros() async {
    final db = await database;

    var maps = await db.query(bibliotecaTable);
    int count = maps.length;
    List<BibliotecaVirtual> livros = [];
    for(int i=0;i<count; i++){
      livros.add(BibliotecaVirtual.fromMapObject(maps[i]));
    }
    return livros;
  }

  Future <List<BibliotecaVirtual>> getListaLivrosOrdenadosPorTitulo() async {
    return await _livrosOrdenadosPor(colTitulo);
  }

  Future <List<BibliotecaVirtual>> getListaLivrosOrdenadosPorAutor() async {
    return await _livrosOrdenadosPor(colAutor);
  }

  Future <List<BibliotecaVirtual>> getListaLivrosOrdenadosPorEditora() async {
    return await _livrosOrdenadosPor(colEditora);
  }

  Future <List<BibliotecaVirtual>> getListaLivrosOrdenadosPorLido() async {
    return await _livrosOrdenadosPor(colLido);
  }

  Future <List<BibliotecaVirtual>> _livrosOrdenadosPor(String colunaOrdenamento) async {
    final db = await database;

    var maps = await db.rawQuery("SELECT * FROM $bibliotecaTable ORDER BY $colunaOrdenamento");
    int count = maps.length;
    List<BibliotecaVirtual> livros = [];
    for(int i=0;i<count; i++){
      livros.add(BibliotecaVirtual.fromMapObject(maps[i]));
    }
    return livros;
  }

  Future<int> excluiLivro(int id) async{
    final db = await database;

    int result = await db.rawDelete('DELETE FROM $bibliotecaTable  WHERE $colId=$id');
    return result;
  }

}