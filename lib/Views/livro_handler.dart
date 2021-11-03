import 'package:biblioteca_virtual/Models/biblioteca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LivroHandlerPage extends StatefulWidget {
  final BibliotecaVirtual ?livroEdicao;
  
  const LivroHandlerPage({Key? key, this.livroEdicao}) : super(key: key);

  @override
  _Livro createState() =>_Livro(livroEdicao);
}

class _Livro extends State<LivroHandlerPage> {
  BibliotecaVirtual ?livro;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController tituloController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController editoraController = TextEditingController();
  bool lidoController = false;

  _Livro(livroEdicao){
    livro = livroEdicao;
  }

  bool isLivroVazio(Map<String, dynamic> mapLivro){
    if(mapLivro["titulo"] != "" && mapLivro["autor"] != "" && mapLivro["editora"] != "") {
      return false;
    }    
    return true;
  }

  void preencheDadosParaEdicao(Map<String, dynamic> mapLivro){
    tituloController.text = mapLivro["titulo"];
    autorController.text = mapLivro["autor"];
    editoraController.text = mapLivro["editora"];
    mapLivro["lido"] == 1 ? lidoController = true : lidoController = false;
  }

  @override
  Widget build(BuildContext context) {
    var livroMap = livro!.toMap();
    if(!isLivroVazio(livroMap)){
      preencheDadosParaEdicao(livroMap);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livro'),
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
              Row(
                children: [
                  const Text("Lido: ", style: const TextStyle (color: Color(0XFF1921D2), fontSize: 30, fontWeight: FontWeight.bold),),
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: lidoController,
                    onChanged: (bool? value) {
                      setState(() {
                        lidoController = value!;
                      });
                    },
                  ),
                ],
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
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blueGrey;
  }

}