import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:app_blog/ViewModel/ver_usuario/ver_usuario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../common/buttonEditar.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

// ignore: must_be_immutable
class VerUsuarioPage extends StatefulWidget {
  String idUsuario;
  VerUsuarioPage(this.idUsuario, {super.key});

  @override
  State<VerUsuarioPage> createState() => _VerUsuarioPageState();
}

class _VerUsuarioPageState extends State<VerUsuarioPage> {

  final VerUsuarioViewModel _viewModel = VerUsuarioViewModel();
  final ContaViewModel _contaViewModel = ContaViewModel();

  _bind()async{
    await _contaViewModel.acessarDados(context);
    await _viewModel.recuperarInfoUsuario(context, widget.idUsuario);
    await _viewModel.recuperarArtigos(context, widget.idUsuario);
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
        appBar: AppBar(
          title: Observer(
            builder: (_){
              return Text(_viewModel.infoUser[0].nome, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),);
            },
          ),
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
            if(_viewModel.infoUser.isEmpty){
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
                            backgroundImage: NetworkImage(_viewModel.infoUser[0].profilePic),
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
                            Text(_viewModel.infoUser[0].nome,
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
                              onTap: ()=>_viewModel.artigos.isNotEmpty ? Navigator.pushNamed(context, Routes.artigosPage, arguments: widget.idUsuario) : null,
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
                                      Text('${_viewModel.artigos.length}',
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

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppPadding.p5),
                        margin: const EdgeInsets.only(top: AppMargin.m6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.idUsuario == _contaViewModel.dadosUsuario[0].idUsuario ? const ButtonEditar() : _buttonSeguir()
                          ],
                        ),
                      ),

                      // Sobre
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                            minHeight: AppSize.s350
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
                              _viewModel.infoUser[0].sobre,
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
        ),
      ),
    );
  }

  Widget _buttonSeguir(){
    return GestureDetector(
      onTap: (){
        _viewModel.seguir(idUsuario: _contaViewModel.dadosUsuario[0].idUsuario, idUsuarioSeguido: widget.idUsuario, context: context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.branco,
            borderRadius: BorderRadius.circular(AppSize.s20)
        ),
        padding: const EdgeInsets.all(AppPadding.p1),
        child: Container(
          width: AppSize.s150,
          height: AppSize.s45,
          decoration: BoxDecoration(
              color: ColorManager.preto,
              borderRadius: BorderRadius.circular(AppSize.s20)
          ),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppStrings.seguir, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
                ],
              )
          ),
        ),
      ),
    );
  }

}

