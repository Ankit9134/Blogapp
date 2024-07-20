class Artigo{
  String? _id;
  String? _idAutor;
  String? _titulo;
  String? _subTitulo;
  dynamic _texto;
  String? _autor;
  String? _data;
  String? _img;
  String? _topico;


  String get data => _data!;

  set data(String value) {
    _data = value;
  }

  String get id => _id!;

  set id(String value) {
    _id = value;
  }

  String get titulo => _titulo!;

  set titulo(String value) {
    _titulo = value;
  }

  String get subTitulo => _subTitulo!;

  set subTitulo(String value) {
    _subTitulo = value;
  }

  String get img => _img!;

  set img(String value) {
    _img = value;
  }

  String get autor => _autor!;

  set autor(String value){
    _autor = value;
  }

  dynamic get texto => _texto;

  set texto(dynamic value) {
    _texto = value;
  }

  String get topico => _topico!;

  set topico(String value) {
    _topico = value;
  }

  String get idAutor => _idAutor!;

  set idAutor(String value) {
    _idAutor = value;
  }
}