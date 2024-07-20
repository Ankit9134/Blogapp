import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:flutter/cupertino.dart';

abstract class AcessarDados{
  acessarDados(TipoAcessoDataBase tipoAcesso, BuildContext context);
}