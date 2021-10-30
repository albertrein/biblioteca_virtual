import 'package:biblioteca_virtual/Models/biblioteca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Livro extends StatelessWidget {
  BibliotecaVirtual ?livro;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController tituloController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController editoraController = TextEditingController();

  Livro();
  Livro.edicao(BibliotecaVirtual livroEdicao){
    livro = livroEdicao;
    var livroMap = livro!.toMap();
    tituloController.text = livroMap["titulo"];
    autorController.text = livroMap["autor"];
    editoraController.text = livroMap["editora"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livro'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Título do livro",
                  labelStyle: TextStyle(color: Color(0XFF1921D2), fontWeight: FontWeight.bold)
                ),                
                style: const TextStyle (color: Color(0XFF1921D2), fontSize: 30, fontWeight: FontWeight.bold),
                controller: tituloController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Informe o título do livro";
                  }
                }
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Autor do livro",
                  labelStyle: TextStyle(color: Color(0XFF1921D2), fontWeight: FontWeight.bold)
                ),                
                style: const TextStyle (color: Color(0XFF1921D2), fontSize: 30, fontWeight: FontWeight.bold),
                controller: autorController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Informe o autor do livro";
                  }
                }
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Editora do livro",
                  labelStyle: TextStyle(color: Color(0XFF1921D2), fontWeight: FontWeight.bold)
                ),                
                style: const TextStyle (color: Color(0XFF1921D2), fontSize: 30, fontWeight: FontWeight.bold),
                controller: editoraController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Informe a editora do livro";
                  }
                }
              ),
              Padding(
                  padding: EdgeInsets.all(30),
                  child: Container(
                    height: 60,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          ///executa algo
                          //_calcular();
                        }
                      },
                      child: const Text("Salvar",
                        style: TextStyle(color: Color(0XFF1921D2), fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

}