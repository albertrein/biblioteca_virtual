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

  final Future<Database> database = getDatabasesPath().then((String path) {
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
  // Get a reference to the database.
  final db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  return await db.insert(
    bibliotecaTable,
    biblioteca.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Map>> listaDeTodosOsLivros() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('livro_table');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return maps;
}
/**fim do código do flutter */

/*
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
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<int> insertLivro(BibliotecaVirtual bibliotecaVirtual) async{
    Database db = await this.database;
    var result=db.insert(bibliotecaTable, bibliotecaVirtual.toMap());
    return result;
  }
*/

}