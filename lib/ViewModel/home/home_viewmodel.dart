import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../Model/models/Frase.dart';
import '../../Model/models/TipoAcessoDataBase.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = HomeViewModelMobx with _$HomeViewModel;

abstract class HomeViewModelMobx with Store{

  final AcessarDadosRepository _repository = AcessarDadosRepository();
  final TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();

  @observable
  List<Frase> _frases = [];

  @observable
  Frase _fraseSorteada = Frase();

  @computed
  List<Frase> get frases{
    return _frases;
  }

  @computed
  Frase get fraseSorteada{
    return _fraseSorteada;
  }

  @action
  sortearFrase(BuildContext context)async{
    _tipoAcesso.tipo = TipoAcesso.acessarDadosFrases;
    _frases = await _repository.acessarDados(_tipoAcesso, context);
    int index = Random().nextInt(_frases.length);
    _fraseSorteada = _frases[index];
  }

}
