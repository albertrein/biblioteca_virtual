import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:biblioteca_virtual/Models/biblioteca.dart';
import 'package:biblioteca_virtual/Utils/biblioteca_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Virtual',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Biblioteca Virtual'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DatabaseHelper helper = DatabaseHelper();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Biblioteca virtual',
            ),
            IconButton(onPressed: _todosOsLivros, icon: const Icon(Icons.edit))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insereLivro,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _insereLivro() async{
    
    var biblioteca = BibliotecaVirtual("Livro teste #1", "Sigmun Bauman", "Colapside", 0);
    int response = await helper.insereLivro(biblioteca);

    print(response);
  }

  void _todosOsLivros() async{
    print(await helper.listaDeTodosOsLivros());
  }
}
