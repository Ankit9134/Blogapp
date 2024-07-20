import 'package:app_blog/Model/models/Usuario.dart';
import 'package:app_blog/Model/repository/authentication.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel{

  late AuthenticationRepository _repository;
  LoginViewModel(AuthenticationRepository repository){
    _repository = repository;
  }

  criarConta(Usuario usuario, BuildContext context){
    return _repository.authentication(usuario, context);
  }

  entrar(Usuario usuario, BuildContext context){
    return _repository.authentication(usuario, context);
  }

}