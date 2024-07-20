import 'package:app_blog/Model/data/collections_names.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../repository/database.dart';

class ExcluirArtigoSalvoRepository implements ExcluirArtigoSalvoDataBase{

  @override
  excluirArtigoSalvo({required String idUsuario, required String idArtigo, required BuildContext context})async{
    Mensagens _mensagem = Mensagens();
    FirebaseFirestore db = FirebaseFirestore.instance;
    try{
      await db.collection(CollectionsNames.artigos_salvos).doc(idUsuario).collection(CollectionsNames.artigos_salvos_usuario).doc(idArtigo).delete().then((value){
        _mensagem.state = true;
        _mensagem.mensagemOk = AppStrings.artigoRemovidoDosSalvos;
        return _mensagem.scaffoldMessege(context);
      });
    } catch(e){
      _mensagem.state = false;
      _mensagem.mensagemError = ErrorStrings.naoFoiPossivelRemoverArtigo;
      return _mensagem.scaffoldMessege(context);
    }
  }

}