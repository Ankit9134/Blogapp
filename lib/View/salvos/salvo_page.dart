import 'package:app_blog/View/common/search_box.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/salvo/salvo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../Model/models/Artigo.dart';
import '../common/card_artigo.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class SalvoPage extends StatefulWidget {
  const SalvoPage({super.key});

  @override
  State<SalvoPage> createState() => _SalvoPageState();
}

class _SalvoPageState extends State<SalvoPage> {

  final SalvoViewModel _viewModel = SalvoViewModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _bind()async{
    await _viewModel.recuperarArtigosSalvos(context);
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
          backgroundColor: ColorManager.branco,
          body: Observer(
            builder: (_){
              return RefreshIndicator(
                backgroundColor: ColorManager.marrom,
                color: ColorManager.branco,
                onRefresh: () => _bind(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: AppPadding.p10, bottom: AppPadding.p20),
                        child: Center(
                          child: Text(AppStrings.artigosSalvos, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
                        ),
                      ),
                      SearchBox(_viewModel.setFilter),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.60,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _viewModel.listFiltered.length,
                            itemBuilder: (_,i){
                              Artigo artigo = _viewModel.listFiltered[i];
                              return Slidable(
                                  key: ValueKey<Artigo>(artigo),
                                  startActionPane: ActionPane(
                                    motion: const DrawerMotion(),
                                    dragDismissible: false,
                                    children: [
                                      SlidableAction(
                                        onPressed: (_)=>_showDialog(artigo),
                                        backgroundColor: ColorManager.vermelho,
                                        icon: Icons.delete_outline_outlined,
                                        label: AppStrings.removerArtgio,
                                      )
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: ()=>Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                                    child: CardArtigo(artigo),
                                  )
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
      ),
    );
  }

  _showDialog(Artigo artigo){
    showDialog(
        context: _scaffoldKey.currentContext!,
        builder: (context){
          return Dialog(
            insetAnimationCurve: Curves.bounceInOut,
            insetAnimationDuration: const Duration(seconds: 1),
            backgroundColor: ColorManager.branco,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s20),
            ),
            child: Container(
              height: AppSize.s150,
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(AppStrings.excluirArtigo,
                    style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _button(tituloBotao: 'Não', onPressed: (){
                        return Navigator.of(context).pop(false);
                      }),
                      _button(
                          tituloBotao: 'Sim',
                          onPressed: ()async{
                            _viewModel.retirarArtigoSalvo(context, artigo: artigo);
                            await _bind();
                            Navigator.pop(context);
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _button({required String tituloBotao, required VoidCallback onPressed}){
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppSize.s80,
        height: AppSize.s40,
        padding: const EdgeInsets.all(AppPadding.p5),
        decoration: BoxDecoration(
            color: ColorManager.marrom,
            borderRadius: BorderRadius.circular(AppSize.s10)
        ),
        child: Center(
          child: Text(tituloBotao, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s12),),
        ),
      ),
    );
  }

}

