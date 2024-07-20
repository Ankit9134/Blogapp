import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:app_blog/Model/servicos/excluirdoc_service.dart';
import 'package:app_blog/Model/servicos/salvardados_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../Model/models/Artigo.dart';
import '../../Model/models/Usuario.dart';
part 'conta_viewmodel.g.dart';

class ContaViewModel = ContaViewModelMobx with _$ContaViewModel;

abstract class ContaViewModelMobx with Store{

  final AcessarDadosRepository _repositoryAcessar = AcessarDadosRepository();
  final ExcluirDocRepository _excluirDocRepository = ExcluirDocRepository();
  final SalvarDados _repositorySalvar = SalvarDados();
  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();
  final TipoSalvarDataBase _tipoSalvar = TipoSalvarDataBase();
  final Usuario _usuario = Usuario();

  @observable
  List<Usuario> _infoUser = [];

  @observable
  List<Artigo> _artigos = [];

  @observable
  String filter = '';

  @computed
  List<Usuario> get dadosUsuario => _infoUser;

  @computed
  List<Artigo> get artigosUsuario => _artigos;

  @computed
  List<Artigo> get listFiltered{
    if(filter == ''|| filter.isEmpty){
      return _artigos;
    } else {
      return _artigos.where((artigo) =>
          artigo.titulo.toLowerCase().contains(filter.toLowerCase())).toList();
    }
  }

  @action
  acessarDados(BuildContext context) async {
    _tipoAcesso.tipo = TipoAcesso.acessarDadosUsuario;
    User? user = FirebaseAuth.instance.currentUser;
    _infoUser = await _repositoryAcessar.acessarDados(_tipoAcesso, context, args: user!.uid);
  }

  @action
  salvarDados(BuildContext context, {String? nome, sobre, profilePic}) async {
    _tipoSalvar.tipo = TipoSalvar.salvarDadosUsuario;
    _usuario.nome = nome!;
    _usuario.sobre = sobre!;
    _usuario.profilePic = profilePic!;
    _repositorySalvar.salvarDados(_tipoSalvar, context, args: _usuario);
    _tipoAcesso.tipo = TipoAcesso.acessarDadosUsuario;
    _infoUser = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
  }

  @action
  acessarQuantidadeArtigos(BuildContext context, {String? idUsuario})async{
    _tipoAcesso.tipo = TipoAcesso.acessarArtigosUsuario;
    if(idUsuario == null){
      User? user = FirebaseAuth.instance.currentUser;
      _artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context, args: user!.uid);
    } else {
      _artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context, args: idUsuario);
    }
  }

  @action
  excluirArtigo({required String collection, required String idDoc, required BuildContext context})async{
    await _excluirDocRepository.excluirDoc(collection: collection, idDoc: idDoc, context: context);
    _tipoAcesso.tipo = TipoAcesso.acessarArtigosUsuario;
    _artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
  }

  @action
  setFilter(String value) => filter = value;

}