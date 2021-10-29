import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:biblioteca_virtual/Models/biblioteca.dart';

//Manipula o sqlite
class DatabaseHelper {
  static DatabaseHelper _databaseHelper; //SINGLETON//PADRAO DE PROJETO
  static Database _database; // singleton database
  String bibliotecaTable = 'biblioteca_table';
  String colId = 'id';
  String colTitulo = 'titulo';
  String colAutor = 'autor';
  String colEditora = 'editora';
  String colLido = 'lido';

  DatabaseHelper._createInstancia(); //Construtor nomeado.

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstancia();
    }
    return _databaseHelper;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'Create table $bibliotecaTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitulo TEXT, '
            '$colAutor TEXT, $colEditora Text, $colLido INTEGER)');
  }

  Future<Database> initializeDatabase() async{
    Directory diretorio = await getApplicationDocumentsDirectory();
    String path=diretorio.path+ "biblioteca.db";
    var todoDatabase= await openDatabase(path, version: 1,onCreate:_createDb );
    return todoDatabase;
  }

  Future<Database> get database async{
    if(_database == null){
      database = await initializeDatabase();
    }
    return _database;
  }

  Future<int> insertLivro(BibliotecaVirtual bibliotecaVirtual) async{
    Database db = await this.database;
    var result=db.insert(bibliotecaTable, bibliotecaVirtual.toMap());
    return result;
  }

}