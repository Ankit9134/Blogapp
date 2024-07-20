import 'package:app_blog/Model/repository/database.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExcluirDocRepository implements ExcluirDocDataBase{

  @override
  excluirDoc({required String collection, required String idDoc, required BuildContext context}) {
    Mensagens _mensagem = Mensagens();
    FirebaseFirestore db = FirebaseFirestore.instance;
    try{
      db.collection(collection).doc(idDoc).delete().then((value){
        _mensagem.state = true;
        _mensagem.mensagemOk = AppStrings.artigoExcluido;
        return _mensagem.scaffoldMessege(context);
      });
    } on FirebaseException catch(e){
      _mensagem.state = false;
      _mensagem.mensagemError = ErrorStrings.naoFoiPossivelExcluirArtigo;
    }
  }

}