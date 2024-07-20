import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';

class Mensagens{

  String? _mensagemOk;
  String? _mensagemError;
  bool? _state;

  scaffoldMessege(BuildContext context){
    int? tempo;
    if(state){
     tempo = _calculoTempo(mensagemOk);
      return ScaffoldMessenger.of(context).showSnackBar(
        _snackBar(tempo, mensagemOk, ColorManager.verde)
      );
    } else {
      tempo = _calculoTempo(mensagemError);
      return ScaffoldMessenger.of(context).showSnackBar(
          _snackBar(tempo, mensagemError, ColorManager.vermelho)
      );
    }

  }

  int _calculoTempo(String mensagem) => (((mensagem.length).toDouble()/2)-4).toInt();

  SnackBar _snackBar(int tempo, String mensagem, Color color){
    return SnackBar(
      content: Text(mensagem, style: getAlexandriaStyle(color: Colors.white),),
      elevation: AppSize.s2,
      backgroundColor: color,
      duration: Duration(seconds: tempo),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s20)
      ),
      padding: const EdgeInsets.all(AppSize.s20),
      margin: const EdgeInsets.all(AppSize.s20),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: ColorManager.branco,
    );
  }

  bool get state => _state!;

  set state(bool value) {
    _state = value;
  }

  String get mensagemError => _mensagemError!;

  set mensagemError(String value) {
    _mensagemError = value;
  }

  String get mensagemOk => _mensagemOk!;

  set mensagemOk(String value) {
    _mensagemOk = value;
  }
}