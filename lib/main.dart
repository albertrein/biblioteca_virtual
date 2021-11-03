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
    listagemTodosLivros();
  }

  Widget getLivrosListView() {
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
            title: Text(livro.title+" - "+livro.autor, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(livro.editora),
            trailing: GestureDetector(
              child: const Icon(
                Icons.delete,
                color: Colors.blueAccent,
              ),
              onTap: () {
                  _delete(context, livro);
              }
            ), 
            onTap: () {
              _editaLivro(context, livro);
            },
          ),
        );
      },
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
          children: <Widget>[
            filtrosOrdenamento(),
            getLivrosListView()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insereLivro,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }

  Widget filtrosOrdenamento(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            SizedBox(height:20.0),
            ExpansionTile(
              title: const Text(
                "Ordenar por",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              children: <Widget>[
                ListTile(
                  title: const Text('Titulo'),
                  onTap: ()=>{
                    ordenaListaPorTitulo()
                  },
                ),
                ListTile(
                  title: const Text('Autor'),
                  onTap: ()=>{
                    ordenaListaPorAutor()
                  },
                ),
                ListTile(
                  title: const Text('Editora'),
                  onTap: ()=>{
                    ordenaListaPorEditora()
                  },
                ),
                ListTile(
                  title: const Text('Lidos'),
                  onTap: ()=>{
                    ordenaListaPorLido()
                  },
                ),
              ],
            ),
          ],
        ),
      );   
  }

  void _insereLivro() async{
    BibliotecaVirtual livro = BibliotecaVirtual("", "", "",0);
    await Navigator.push(context, MaterialPageRoute(builder: (context) => LivroHandlerPage(livroEdicao:livro)));    
    listagemTodosLivros();
    return;
  }

  void _editaLivro(context, livro) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => LivroHandlerPage(livroEdicao: livro)));
    listagemTodosLivros();
    return;
  }

  void _delete(context, livro) async{
    int response = await helper.excluiLivro(livro.id);
    listagemTodosLivros();
  }

  void listagemTodosLivros() {
    Future<List<BibliotecaVirtual>> livrosListFuture = helper.listaDeTodosOsLivros();
    atualizaListaDeLivrosBy(livrosListFuture);
  }

  void atualizaListaDeLivrosBy(Future<List<BibliotecaVirtual>> livrosListFuture){
    livrosListFuture.then((listaLivros) {
      setState(() {
        this.listaLivros = listaLivros;
      });
    });
  }
  
  void ordenaListaPorTitulo() {
    Future<List<BibliotecaVirtual>> livrosListFuture = helper.getListaLivrosOrdenadosPorTitulo();
    atualizaListaDeLivrosBy(livrosListFuture);
  }

  void ordenaListaPorAutor() {
    Future<List<BibliotecaVirtual>> livrosListFuture = helper.getListaLivrosOrdenadosPorAutor();
    atualizaListaDeLivrosBy(livrosListFuture);
  }

  void ordenaListaPorEditora() {
    Future<List<BibliotecaVirtual>> livrosListFuture = helper.getListaLivrosOrdenadosPorEditora();
    atualizaListaDeLivrosBy(livrosListFuture);
  }

  void ordenaListaPorLido() {
    Future<List<BibliotecaVirtual>> livrosListFuture = helper.getListaLivrosOrdenadosPorLido();
    atualizaListaDeLivrosBy(livrosListFuture);
  }
}
