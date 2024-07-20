import 'package:app_blog/View/resources/routes_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/salvo/salvo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Model/models/Artigo.dart';
import '../resources/color_manager.dart';

//ignore: must_be_imutable
class LeituraPage extends StatefulWidget {
  Artigo artigo;
  LeituraPage(this.artigo, {super.key});

  @override
  State<LeituraPage> createState() => _LeituraPageState();
}

class _LeituraPageState extends State<LeituraPage> {

  final SalvoViewModel _viewModel = SalvoViewModel();

  _bind()async{
    await _viewModel.recuperarArtigosSalvos(context);
    _viewModel.aArtigoSalvo(context, widget.artigo);
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context){
    return Observer(
      builder: (_){
        return Scaffold(
          backgroundColor: ColorManager.branco,
          appBar: AppBar(
            backgroundColor: ColorManager.branco,
            actions: [
              Observer(
                builder: (_){
                  return IconButton(
                    onPressed: ()async{
                      dynamic res;
                      if(_viewModel.artigoEstaSalvo){
                        res = await _viewModel.retirarArtigoSalvo(context, artigo: widget.artigo);
                      } else {
                        res = _viewModel.salvarArtigo(context, artigo: widget.artigo);
                      }
                      await _bind();
                      return res;
                    },
                    icon: _viewModel.artigoEstaSalvo ?
                    const Icon(Icons.bookmark_rounded, color: ColorManager.preto,) :
                    const Icon(Icons.bookmark_border_rounded, color: ColorManager.preto,)
                  );
                },
              )
            ],
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Container(
                  width: double.infinity,
                  height: AppSize.s280,
                  margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
                  decoration: BoxDecoration(
                      color: ColorManager.preto,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.artigo.img)
                      )
                  ),
                ),


                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, Routes.verUsuarioPage, arguments: widget.artigo.idAutor),
                        child: Text('Por ${widget.artigo.autor}', style: getAlexandriaStyle(color: ColorManager.marrom),),
                      ),
                      Text(' - ${widget.artigo.data}', style: getAlexandriaStyle(color: ColorManager.preto),),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.artigo.titulo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                      const SizedBox(height: AppSize.s6,),
                      Text(widget.artigo.subTitulo, style: getAliceStyle(color: ColorManager.marrom, fontSize: AppSize.s20),),
                      const SizedBox(height: AppSize.s20,),
                      Text(widget.artigo.texto, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s16),)
                    ],
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }
}


