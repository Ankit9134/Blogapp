import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/inicio/inicio_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../Model/models/Artigo.dart';
import '../../common/card_artigo.dart';
import '../../resources/routes_manager.dart';

// ignore: must_be_immutable
class TopicosSelecionadosPage extends StatefulWidget {
  String topico;
  TopicosSelecionadosPage(this.topico, {super.key});

  @override
  State<TopicosSelecionadosPage> createState() => _TopicosSelecionadosPageState();
}

class _TopicosSelecionadosPageState extends State<TopicosSelecionadosPage> {

  final InicioViewModel _viewModel = InicioViewModel();

  _bind()async{
    await _viewModel.recuperarArtigosEmAlta(context);
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.branco,
      appBar: AppBar(
        title: Text(widget.topico, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
        backgroundColor: ColorManager.branco,
        leading: Builder(
          builder: (context){
            return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.preto,)
            );
          }
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.branco,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Observer(
        builder: (_){
          if(_viewModel.artigosEmAlta.isEmpty){
            return const Scaffold(
              backgroundColor: ColorManager.branco,
              body: Center(
                child: CircularProgressIndicator(backgroundColor: ColorManager.marrom, color: ColorManager.branco,),
              ),
            );
          }else{
            return RefreshIndicator(
              backgroundColor: ColorManager.marrom,
              color: ColorManager.branco,
              onRefresh: ()=>_bind(),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _viewModel.artigosEmAlta.length,
                  itemBuilder: (_,i){
                    Artigo artigo = _viewModel.artigosEmAlta[i];
                    return GestureDetector(
                      onTap: ()=>Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                      child: CardArtigo(artigo),
                    );
                  }
              ),
            );
          }
        },
      ),
    );
  }
}


