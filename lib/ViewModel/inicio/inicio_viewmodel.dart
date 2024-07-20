import 'dart:math';
import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import '../../Model/models/Artigo.dart';
import 'package:exists_in/exists_in.dart';
part 'inicio_viewmodel.g.dart';

class InicioViewModel = InicioViewModelMobx with _$InicioViewModel;

abstract class InicioViewModelMobx with Store{

  final AcessarDadosRepository _repositoryAcessar = AcessarDadosRepository();
  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();

  @observable
  List<Artigo> _populares = [];

  @observable
  List<Artigo> _emAlta = [];

  @observable
  List<List<Artigo>> _artigosPorTopicos = [];

  @computed
  List<Artigo> get artigosPopulares => _populares;

  @computed
  List<Artigo> get artigosEmAlta => _emAlta;

  @action
  recuperarArtigosPopulares(BuildContext context)async{
    List<Artigo> artigos = [];
    _tipoAcesso.tipo = TipoAcesso.acessarArtigos;
    artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
    _populares.clear();
    if(artigos.length<=2){
      _populares = artigos;
    } else {
      List<Artigo> _artigos = [];
      while(_artigos.length < artigos.length~/2){
        var artigo = artigos[Random().nextInt(artigos.length)];
        if(!existsIn(artigo, _artigos)){
          _artigos.add(artigo);
        }
      }
      _populares = _artigos;
      // fatiamento em listas no dart 
      //_populares = [...artigos].getRange(0,artigos.length~/2).toList();
    }
  }

  @action
  recuperarArtigosEmAlta(BuildContext context)async{
    List<Artigo> artigos = [];
    _tipoAcesso.tipo = TipoAcesso.acessarArtigos;
    artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
    _emAlta.clear();
    if(artigos.length<=2){
      _emAlta = artigos;
    } else {
      List<Artigo> _artigos = [];
      while(_artigos.length < artigos.length~/2){
        var artigo = artigos[Random().nextInt(artigos.length)];
        if(!existsIn(artigo, _artigos)){
          _artigos.add(artigo);
        }
      }
      _emAlta = _artigos;
    }
  }

  @action
  recuperarArtigosTopico(BuildContext context)async{
    List<Artigo> artigos = [];
    List<String> topicosExistentes = [];
    _tipoAcesso.tipo = TipoAcesso.acessarArtigos;
    artigos = await _repositoryAcessar.acessarDados(_tipoAcesso, context);
    for(int i = 0; i < artigos.length; i++){
      if(!existsIn(artigos[i].topico, topicosExistentes)){
        topicosExistentes.add(artigos[i].topico);
      }
    }
    print('Tópicos existentes: $topicosExistentes');
    _artigosPorTopicos.clear();
    for(int t = 0; t < topicosExistentes.length; t++){
      if(_artigosPorTopicos.isEmpty){
        _artigosPorTopicos.add([artigos[t]]);
      } else {
        print(_artigosPorTopicos[t-1][0].topico);
        print(topicosExistentes[t]);
        if(t == 1){
          print('T = 1 -----------------');
          if(topicosExistentes[t] == _artigosPorTopicos[t-1][0].topico){
            print('Tópico já existe na lista');
            print('=========');
            _artigosPorTopicos[t].add(artigos[t]);
          } else {
            print('Tópico ainda não existe na lista');
            print('=========');
            _artigosPorTopicos.add([artigos[t]]);
          }
          print('T = 1 ------------------');
        } else {
          for(int o = 0; o < t; o++){
            if(topicosExistentes[t] == _artigosPorTopicos[o][0].topico){
              print('Tópico já existe na lista');
              print('=========');
              _artigosPorTopicos[t].add(artigos[t]);
            } else {
              print('Tópico ainda não existe na lista');
              print('=========');
              _artigosPorTopicos.add([artigos[t]]);
            }
          }
        }
      }
    }
    print(_artigosPorTopicos);
  }

  @action
  recuperarArtigoPorTopicoEspecifico(BuildContext context)async{

  }



}
