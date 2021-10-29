class BibliotecaVirtual{
  int _id;
  String _titulo;
  String _autor;
  String _editora;
  int _lido;

  BibliotecaVirtual(this._id, this._titulo, this._autor, this._editora, this._lido);

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'titulo': _titulo,
      'editora': _editora,
      'lido': _lido,
    };
  }
}