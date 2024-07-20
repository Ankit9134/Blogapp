// TODO: implementar arquivo mobx que recupera os artigos, usuários, tópicos e os aloca em uma lista que será pesquisada pela view



import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../Model/models/Artigo.dart';
part 'search_viewmodel.g.dart';

class SearchViewModel = SearchViewModelMobx with _$SearchViewModel;

abstract class SearchViewModelMobx with Store{

  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();
  final AcessarDadosRepository _acessarDados = AcessarDadosRepository();

  @observable
  List<Artigo> _artigos = [];

  @observable
  List<String> _topicos = [];

  @observable
  String filter = '';

  @observable
  String filterTopic = '';

  @observable
  bool _artigosFiltradosPorTopico = false;

  @observable
  String _topicoSelecionado = '';

  @computed
  List<Artigo> get artigos => _artigos;

  @computed
  List<String> get topicos => _topicos;

  @computed
  List<Artigo> get listFiltered{

    if(_topicoSelecionado != '' || _topicoSelecionado.isNotEmpty){
      return _artigos.where((artigo) =>
        artigo.topico.contains(_topicoSelecionado)).toList();
    }

    if(filter == '' || filter.isEmpty){
      return _artigos;
    } else {
      return _artigos.where((artigo) =>
        artigo.titulo.toLowerCase().contains(filter.toLowerCase())).toList();
    }
  }

  @computed
  List<String> get listTopicFiltered{
    if(filterTopic == '' || filterTopic.isEmpty){
      return _topicos;
    } else {
      return _topicos.where((topico) =>
          topico.toLowerCase().contains(filterTopic.toLowerCase())).toList();
    }
  }

  @computed
  bool get artigosFiltradosPorTopico => _artigosFiltradosPorTopico;

  @computed
  String get topicoSelecionado => _topicoSelecionado;

  @action
  recuperarDados(BuildContext context)async{
    _tipoAcesso.tipo = TipoAcesso.acessarArtigos;
    _artigos = await _acessarDados.acessarDados(_tipoAcesso, context);
  }

  @action
  recuperarTopicos(BuildContext context)async{
    _tipoAcesso.tipo = TipoAcesso.acessarTopicos;
    _topicos = await _acessarDados.acessarDados(_tipoAcesso, context);
  }

  @action
  setFilter(String value) => filter = value;

  @action
  setTopicFilter(String value) => filterTopic = value;

  @action
  setBoolTopico(String topico) {
    if(_topicoSelecionado != topico){
      _artigosFiltradosPorTopico = true;
      _topicoSelecionado = topico;
    } else if(_topicoSelecionado == topico){
      _artigosFiltradosPorTopico = false;
      _topicoSelecionado = '';
    }
  }

  @action
  limparFiltro(){
    _artigosFiltradosPorTopico = false;
    _topicoSelecionado = '';
  }

}
