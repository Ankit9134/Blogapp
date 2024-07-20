import 'package:app_blog/Model/repository/authentication.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../View/resources/routes_manager.dart';

class ForgotPassword implements ForgotPasswordRepository{
  @override
  Future recuperarSenha(String email, BuildContext context) async {
    Mensagens _mensagem = Mensagens();
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim()).then((value){
        Navigator.pop(context);
        _mensagem.mensagemOk = SuccessStrings.linkEnviado;
        _mensagem.state = true;
        return _mensagem.scaffoldMessege(context);
      });
    } on FirebaseAuthException catch (e){
      _mensagem.state = false;
      if(e.code == 'network-request-failed'){
        _mensagem.mensagemError = ErrorStrings.semConexao;
      } else {
        _mensagem.mensagemError = ErrorStrings.erroLink;
      }
      return _mensagem.scaffoldMessege(context);
    }
  }
}
