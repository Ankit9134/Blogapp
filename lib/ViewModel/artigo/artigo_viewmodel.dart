import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:app_blog/Model/servicos/salvardados_service.dart';
import 'package:app_blog/View/common/gerador_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../Model/models/Artigo.dart';
part 'artigo_viewmodel.g.dart';

class ArtigoViewModel = ArtigoViewModelMobx with _$ArtigoViewModel;

abstract class ArtigoViewModelMobx with Store{

  final TipoSalvarDataBase _tipoSalvar = TipoSalvarDataBase();
  final TipoAcessoDataBase _tipoAcessar = TipoAcessoDataBase();
  final AcessarDadosRepository _acessarDados = AcessarDadosRepository();
  final SalvarDados _salvarDados = SalvarDados();
  final Artigo _artigo = Artigo();

  @observable
  List<String> _topicos = [];

  @computed
  List<String> get topicos => _topicos;

  @action
  salvarDados(BuildContext context, {required Artigo artigo}){
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    _tipoSalvar.tipo = TipoSalvar.criarArtigo;
    _artigo.id = GeradorId.gerarId();
    _artigo.idAutor = user!.uid;
    _artigo.titulo = artigo.titulo;
    _artigo.subTitulo = artigo.subTitulo;
    _artigo.texto = artigo.texto;
    _artigo.autor = artigo.autor;
    _artigo.img = artigo.img;
    _artigo.topico = artigo.topico;
    _salvarDados.salvarDados(_tipoSalvar, context, args: _artigo);
  }

  @action
  acessarTopicos(BuildContext context)async{
    _tipoAcessar.tipo = TipoAcesso.acessarTopicos;
    _topicos = await _acessarDados.acessarDados(_tipoAcessar, context);
  }

}
