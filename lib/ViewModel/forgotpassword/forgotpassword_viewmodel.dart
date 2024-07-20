import 'package:app_blog/Model/repository/authentication.dart';
import 'package:flutter/cupertino.dart';

class ForgotPasswordViewModel{

  late ForgotPasswordRepository _repository;
  ForgotPasswordViewModel(ForgotPasswordRepository repository){
    _repository = repository;
  }

  recuperarSenha(String email, BuildContext context)async{
    return _repository.recuperarSenha(email, context);
  }

}