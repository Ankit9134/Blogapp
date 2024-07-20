import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/models/Usuario.dart';
import 'package:app_blog/Model/repository/database.dart';
import 'package:app_blog/Model/servicos/acessardados_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SeguirRepository implements Seguir{
  @override
  seguir({required String idUsuario, required String idUsuarioSeguido, required BuildContext context}) async{
    AcessarDadosRepository _acessarDados = AcessarDadosRepository();
    TipoAcessoDataBase _tipoAcesso = TipoAcessoDataBase();
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<Usuario> _currentUser= [];
    List<Usuario> _userSeguido = [];
    print('${idUsuario} vai seguir ${idUsuarioSeguido}');
    _tipoAcesso.tipo = TipoAcesso.acessarDadosUsuario;
    _userSeguido = await _acessarDados.acessarDados(_tipoAcesso, context, args: idUsuarioSeguido);
    _currentUser = await _acessarDados.acessarDados(_tipoAcesso, context, args: user!.uid);
    bool _executado = false;
    try{
      print('executando');
      await db.collection(CollectionsNames.seguindo).doc(idUsuario).collection(CollectionsNames.seguindo_usuarios).doc().set({
        'id':_userSeguido[0].idUsuario,
        'nome':_userSeguido[0].nome,
        'email':_userSeguido[0].email,
        'sobre':_userSeguido[0].sobre,
        'profilePic':_userSeguido[0].profilePic
      }).then((value) => _executado = true);
      print(_executado);
      if(_executado){
        await db.collection(CollectionsNames.seguidores).doc(idUsuarioSeguido).collection(CollectionsNames.seguidores_usuarios).doc().set({
          'id':_currentUser[0].idUsuario,
          'nome':_currentUser[0].nome,
          'email':_currentUser[0].email,
          'sobre':_currentUser[0].sobre,
          'profilePic':_currentUser[0].profilePic
        });
      }
      return _executado;
    }catch(e){
      return false;
    }
  }
}