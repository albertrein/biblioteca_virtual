class BibliotecaVirtual{
  int ?_id;
  String _titulo;
  String _autor;
  String _editora;
  int _lido;

  BibliotecaVirtual(this._titulo, this._autor, this._editora, this._lido);
  BibliotecaVirtual.comId(this._id, this._titulo, this._autor, this._editora, this._lido);

  int get id => _id!;

  String get title => _titulo;

  String get autor => _autor;

  String get editora => _editora;

  int get lido => _lido;

  set titulo(String novoTitulo) {
    _titulo = novoTitulo;
  }

  set autor(String novoAutor) {
    _autor = novoAutor;
  }

  set editora(String novaEditora) {
    _editora = novaEditora;
  }

  set lido(int novoLido) {
    _lido = novoLido;
  }

  set livroLido(bool isLido) {
    if(isLido){
      _lido = 1;
    }else{
      _lido = 0;
    }    
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'titulo': _titulo,
      'editora': _editora,
      'autor': _autor,
      'lido': _lido,
    };
  }

  @override
  String toString() {
    return 'BibliotecaVirtual{id: $id, titulo: $_titulo, editora: $_editora}';
  }
}