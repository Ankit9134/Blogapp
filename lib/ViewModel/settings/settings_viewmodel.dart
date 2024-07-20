import 'package:app_blog/Model/repository/authentication.dart';
import 'package:flutter/cupertino.dart';

class SettingsViewModel{

  late SignOutRepository _repository;
  SettingsViewModel(SignOutRepository repository){
    _repository = repository;
  }

  sair(BuildContext context){
    return _repository.sair(context);
  }

}