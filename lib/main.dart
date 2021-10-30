import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:biblioteca_virtual/Models/biblioteca.dart';
import 'package:biblioteca_virtual/Utils/biblioteca_helper.dart';
import 'package:biblioteca_virtual/Views/livro_handler.dart';

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
  DatabaseHelper helper = DatabaseHelper();
  List<BibliotecaVirtual> listaLivros = [];

  void _todosOsLivros() async{
    listaLivros = await helper.listaDeTodosOsLivros(); 
    print(listaLivros.toString());
    print("");
    print(listaLivros.runtimeType);
    for(int i = 0; i < listaLivros.length; i++){
      // ignore: avoid_print
      print(listaLivros[i].toString());
    }
  }

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  Widget getTodosListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listaLivros.length,
      itemBuilder: (BuildContext context, int position) {
        BibliotecaVirtual livro = listaLivros[position];
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(livro.title),
            ),
            title:
            Text(livro.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(livro.autor),
            trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.blueAccent,
                ),
                onTap: () {
                    _delete(context, livro);
                }),
            onTap: () {
              print("Lista detalhes");
              //navigateToDetail(livro, livro.title);

              //faça o navigate
            },
          ),
        );
      },
    );
  }

  titulosLivros(){
    return (
      FutureBuilder<List>(
        future: helper.listaDeTodosOsLivros(),
        initialData: [],
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data![position];
                    //get your item data here ...
                    return Card(
                      child: ListTile(
                        title: Text(
                            "Employee Name: " + snapshot.data![position].row[1]),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      )
    );
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
            IconButton(onPressed: _todosOsLivros, icon: const Icon(Icons.edit)),
            getTodosListView()
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => Livro()));
    return;
    var biblioteca = BibliotecaVirtual("Livro teste #2", "Carl Marx", "Saraiva", 0);
    int response = await helper.insereLivro(biblioteca);

    print(response);
    updateListView();
  }

  void _delete(context, livro) async{
    print('Acao: deletar');
    int response = await helper.excluiLivro(livro.id);
    print(">> $response");
    updateListView();
  }

  void updateListView() {
    Future<List<BibliotecaVirtual>> todoListFuture = helper.listaDeTodosOsLivros();
      todoListFuture.then((listaLivros) {
        setState(() {
          this.listaLivros = listaLivros;
        });
      });
  }
}
