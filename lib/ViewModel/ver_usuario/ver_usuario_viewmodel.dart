import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:app_blog/Model/servicos/seguir_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import '../../Model/models/Artigo.dart';
import '../../Model/models/Usuario.dart';
part 'ver_usuario_viewmodel.g.dart';

class VerUsuarioViewModel = VerUsuarioViewModelMobx with _$VerUsuarioViewModel;

abstract class VerUsuarioViewModelMobx with Store{

  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();
  final AcessarDadosRepository _acessarDados = AcessarDadosRepository();
  final SeguirRepository _seguirRepository = SeguirRepository();

  @observable
  List<Usuario> _infoUser = [];

  @observable
  List<Artigo> _artigos = [];

  @observable
  bool _seguido = false;

  @computed
  List<Usuario> get infoUser => _infoUser;

  @computed
  List<Artigo> get artigos => _artigos;

  @computed
  bool get seguido => _seguido;

  @action
  recuperarInfoUsuario(BuildContext context, String idUsuario)async{
    _tipoAcesso.tipo = TipoAcesso.acessarDadosUsuario;
    _infoUser = await _acessarDados.acessarDados(_tipoAcesso, context, args: idUsuario);
  }

  @action
  recuperarArtigos(BuildContext context, String idUsuario)async{
    _tipoAcesso.tipo = TipoAcesso.acessarArtigosUsuario;
    _artigos = await _acessarDados.acessarDados(_tipoAcesso, context, args: idUsuario);
  }

  @action
  seguir({required String idUsuario, required String idUsuarioSeguido, required BuildContext context}){
    _seguirRepository.seguir(idUsuario: idUsuario, idUsuarioSeguido: idUsuarioSeguido, context: context);
  }

}