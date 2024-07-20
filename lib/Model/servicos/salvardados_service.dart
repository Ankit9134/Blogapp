import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/Model/repository/database.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import '../../View/resources/routes_manager.dart';
import '../models/Artigo.dart';
import '../models/Usuario.dart';

class SalvarDados implements DataBase{

  final Mensagens _mensagens = Mensagens();

  @override
  salvarDados(TipoSalvarDataBase tipoSalvarDataBase, BuildContext context, {dynamic args}) {

    switch(tipoSalvarDataBase.tipo){

      case TipoSalvar.salvarDadosUsuario:
        return _salvarDadosUsuario(context, args: args);
      case TipoSalvar.criarArtigo:
        return _criarArtigo(context, args: args);
      case TipoSalvar.salvarArtigo:
        return _salvarArtigo(context, args: args);

    }

  }

  _salvarDadosUsuario(BuildContext context, {Usuario? args}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    FirebaseFirestore dbUser = FirebaseFirestore.instance;
    Map<String, String> _dadosAtualizar;
    _dadosAtualizar = {
      'nome':args!.nome,
      'sobre':args.sobre,
      'profilePic':args.profilePic
    };
    try{
      dbUser.collection(CollectionsNames.usuarios).doc(user!.uid).update(_dadosAtualizar)
        .then((value){
        Navigator.pushNamedAndRemoveUntil(context, Routes.initialRoute, (route) => false, arguments: 4);
        _mensagens.mensagemOk = SuccessStrings.dadosAlterados;
        _mensagens.state = true;
        return _mensagens.scaffoldMessege(context);
      });
    } on FirebaseAuthException catch(e){
      _mensagens.mensagemError = ErrorStrings.dadosNaoAlterados;
      _mensagens.state = false;
      return _mensagens.scaffoldMessege(context);
    }
  }

  _criarArtigo(BuildContext context, {Artigo? args})async{
    FirebaseFirestore dbArtigos = FirebaseFirestore.instance;
    args?.data = DateFormat("dd/MM/yyyy").format(DateTime.now());
    try{
      dbArtigos.collection(CollectionsNames.artigos).doc(args!.id).set(
        {
          'id':args.id,
          'idAutor':args.idAutor,
          'titulo':args.titulo,
          'subTitulo':args.subTitulo,
          'texto':args.texto,
          'autor':args.autor,
          'img':args.img,
          'topico':args.topico,
          'data':args.data
        }
      ).then((value){
        Navigator.pushNamedAndRemoveUntil(context, Routes.initialRoute, (route) => false, arguments: 4);
        _mensagens.state = true;
        _mensagens.mensagemOk = SuccessStrings.artigoCriado;
        return _mensagens.scaffoldMessege(context);
      });
    }on FirebaseException catch(e){
      _mensagens.state = false;
      _mensagens.mensagemError = ErrorStrings.naoFoiPossivelCriarArtigo;
      return _mensagens.scaffoldMessege(context);
    }
  }

  _salvarArtigo(BuildContext context, {Artigo? args})async{
    Mensagens _mensagem = Mensagens();
    FirebaseFirestore dbArtigos = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await auth.currentUser;
    try{
      dbArtigos.collection(CollectionsNames.artigos_salvos).doc(user!.uid).collection(CollectionsNames.artigos_salvos_usuario).doc(args!.id).set(
        {
          'id':args.id,
          'idAutor':args.idAutor,
          'titulo':args.titulo,
          'subTitulo':args.subTitulo,
          'texto':args.texto,
          'autor':args.autor,
          'img':args.img,
          'topico':args.topico,
          'data':args.data
        }
      );
    } catch(e){
      _mensagem.state = false;
      if(user?.uid==null){
        _mensagem.mensagemError = ErrorStrings.crieContaParaSalvarArtigo;
      } else {
        _mensagem.mensagemError = ErrorStrings.naoFoiPossivelSalvarArtigo;
      }
      return _mensagem.scaffoldMessege(context);
    }
  }
  
}
