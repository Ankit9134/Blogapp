import 'package:flutter/material.dart';
import '../models/Usuario.dart';

abstract class AuthenticationRepository{
  authentication(Usuario usuario, BuildContext context);
}

abstract class SignOutRepository{
  sair(BuildContext context);
}

abstract class ForgotPasswordRepository{
  Future recuperarSenha(String email, BuildContext context);
}
