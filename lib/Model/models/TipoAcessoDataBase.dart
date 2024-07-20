class TipoAcessoDataBase{

  String? tipo;

  TipoAcessoDataBase({this.tipo});

}

sealed class TipoAcesso{
  static const String acessarDadosUsuario = 'acessarDadosUsuario';
  static const String acessarDadosFrases = 'acessarDadosFrases';
  static const String acessarArtigosUsuario = 'acessarArtigosUsuario';
  static const String acessarTopicos = 'acessarTopicos';
  static const String acessarArtigos = 'acessarArtigos';
  static const String acessarArtigosSalvos = 'acessarArtigosSalvos';
}
