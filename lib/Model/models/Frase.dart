class Frase{

  String? _frase;
  String? _autor;

  String get frase => _frase!;

  set frase(String value) {
    _frase = value;
  }

  String get autor => _autor!;

  set autor(String value) {
    _autor = value;
  }
}