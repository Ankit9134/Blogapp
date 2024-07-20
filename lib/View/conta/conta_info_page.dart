import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/routes_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import '../../ViewModel/conta/conta_viewmodel.dart';
import '../common/buttonEditar.dart';

class ContaInfoPage extends StatefulWidget {
  const ContaInfoPage({super.key});

  @override
  State<ContaInfoPage> createState() => _ContaInfoPageState();
}

class _ContaInfoPageState extends State<ContaInfoPage> {

  final ContaViewModel _viewModel = ContaViewModel();

  _bind() async {
    await _viewModel.acessarDados(context);
    await _viewModel.acessarQuantidadeArtigos(context);
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
        backgroundColor: ColorManager.branco,
        body: Observer(
          builder: (_){
            if(_viewModel.dadosUsuario.isEmpty){
              return const Center(child: CircularProgressIndicator(
                color: ColorManager.marrom,
              ),);
            } else {
              return RefreshIndicator(
                backgroundColor: ColorManager.marrom,
                color: ColorManager.branco,
                onRefresh: () => _bind(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [

                      // Foto Usuário
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppPadding.p20),
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: 80,
                            backgroundColor: ColorManager.branco,
                            backgroundImage: NetworkImage(_viewModel.dadosUsuario[0].profilePic),
                          ),
                        ),
                      ),


                      // Nome Usuário
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppPadding.p5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_viewModel.dadosUsuario[0].nome,
                              style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),)
                          ],
                        ),
                      ),


                      // Info Usuário
                      // TODO: adicionar auto_sized_text para redimensionamento automático dos números de artigos, seguidores e seguindo
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppPadding.p5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            // Seguidores
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, Routes.seguirSeguindoPage, arguments: AppStrings.seguidores),
                              child: Container(
                                height: AppSize.s100,
                                width: AppSize.s100,
                                decoration: BoxDecoration(
                                  color: ColorManager.marrom,
                                  borderRadius: BorderRadius.circular(AppSize.s20)
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(0.toString(),
                                        style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s30),),
                                      Text(AppStrings.seguidores,
                                        style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSize.s10,),

                            // Seguindo
                            GestureDetector(
                              onTap: ()=>Navigator.pushNamed(context, Routes.seguirSeguindoPage, arguments: AppStrings.seguindo),
                              child: Container(
                                height: AppSize.s100,
                                width: AppSize.s100,
                                decoration: BoxDecoration(
                                  color: ColorManager.marrom,
                                  borderRadius: BorderRadius.circular(AppSize.s20)
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(0.toString(),
                                        style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s30),),
                                      Text(AppStrings.seguindo,
                                        style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSize.s10,),

                            // Artigos
                            GestureDetector(
                              onTap: ()=>_viewModel.artigosUsuario.isNotEmpty ? Navigator.pushNamed(context, Routes.artigosPage, arguments: _viewModel.dadosUsuario[0].idUsuario) : null,
                              child: Container(
                                height: AppSize.s100,
                                width: AppSize.s100,
                                decoration: BoxDecoration(
                                    color: ColorManager.marrom,
                                    borderRadius: BorderRadius.circular(AppSize.s20)
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('${_viewModel.artigosUsuario.length}',
                                        style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s30),),
                                      Text(AppStrings.artigos,
                                        style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      // Botão editar e configurações
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppPadding.p5),
                        margin: const EdgeInsets.only(top: AppMargin.m6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ButtonEditar(),
                            const SizedBox(width: AppSize.s8,),
                            IconButton(
                                onPressed: () => Navigator.pushNamed(context, Routes.settings),
                                icon: const Icon(Icons.settings, size: 30, color: ColorManager.preto,)
                            )
                          ],
                        ),
                      ),


                      // Sobre
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          minHeight: AppSize.s250
                        ),
                        padding: const EdgeInsets.all(AppPadding.p20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text(AppStrings.sobre, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),)],
                            ),
                            const SizedBox(height: AppSize.s10,),
                            Text(
                              _viewModel.dadosUsuario[0].sobre,
                              style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        )
      )
    );
  }

}
