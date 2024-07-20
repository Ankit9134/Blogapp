import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:app_blog/Model/servicos/excluirartigosalvo_service.dart';
import 'package:app_blog/Model/servicos/salvardados_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../Model/models/Artigo.dart';
part 'salvo_viewmodel.g.dart';

class SalvoViewModel = SalvoViewModelMobx with _$SalvoViewModel;

abstract class SalvoViewModelMobx with Store{

  final TipoSalvarDataBase _tipoSalvar = TipoSalvarDataBase();
  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();
  final AcessarDadosRepository _acessarDados = AcessarDadosRepository();
  final ExcluirArtigoSalvoRepository _excluirArtigoSalvo = ExcluirArtigoSalvoRepository();
  final SalvarDados _salvarDados = SalvarDados();

  @observable
  List<Artigo> _artigosSalvos = [];

  @observable
  bool _artigoEstaSalvo = false;

  @observable
  String filter = '';

  @computed
  List<Artigo> get artigosSalvos => _artigosSalvos;

  @computed
  bool get artigoEstaSalvo => _artigoEstaSalvo;

  @computed
  List<Artigo> get listFiltered{
    if(filter == '' || filter.isEmpty){
      return _artigosSalvos;
    } else {
      return _artigosSalvos.where((artigo) =>
          artigo.titulo.toLowerCase().contains(filter.toLowerCase())).toList();
    }
  }

  @action
  setFilter(String value) => filter = value;

  @action
  recuperarArtigosSalvos(BuildContext context)async{
    _tipoAcesso.tipo = TipoAcesso.acessarArtigosSalvos;
    _artigosSalvos = await _acessarDados.acessarDados(_tipoAcesso, context);
  }

  @action
  retirarArtigoSalvo(BuildContext context, {required Artigo artigo})async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    await _excluirArtigoSalvo.excluirArtigoSalvo(idUsuario: user!.uid, idArtigo: artigo.id, context: context);
    _artigoEstaSalvo = false;
    _tipoAcesso.tipo = TipoAcesso.acessarArtigosSalvos;
    _artigosSalvos = await _acessarDados.acessarDados(_tipoAcesso, context);
  }

  @action
  salvarArtigo(BuildContext context, {required Artigo artigo}){
    _tipoSalvar.tipo = TipoSalvar.salvarArtigo;
    _salvarDados.salvarDados(_tipoSalvar, context, args: artigo);
  }

  @action
  aArtigoSalvo(BuildContext context, Artigo artigo){
    for(int i = 0; i < artigosSalvos.length; i++){
      if(artigo.id == artigosSalvos[i].id){
        _artigoEstaSalvo = true;
        break;
      }
    }
  }

}
