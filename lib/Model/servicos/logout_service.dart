import 'package:app_blog/Model/repository/authentication.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../View/resources/routes_manager.dart';

class LogOutRepository implements SignOutRepository{
  @override
  sair(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final Mensagens mensagens = Mensagens();
    try{
      auth.signOut().then((value){
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.initialRoute,
          (route) => false
        );
      });
    }on FirebaseAuthException catch(e){
      mensagens.mensagemError = e.code;
      mensagens.state = false;
      return mensagens.scaffoldMessege(context);
    }
  }
}