import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/inicio/inicio_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../Model/models/Artigo.dart';
import '../../resources/routes_manager.dart';

class PopularesPage extends StatefulWidget {
  const PopularesPage({super.key});

  @override
  State<PopularesPage> createState() => _PopularesPageState();
}

class _PopularesPageState extends State<PopularesPage> {

  final InicioViewModel _viewModel = InicioViewModel();

  _bind()async{
    await _viewModel.recuperarArtigosPopulares(context);
    await _viewModel.recuperarArtigosEmAlta(context);
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p20, bottom: AppPadding.p20),
              child: SizedBox(
                height: AppSize.s380,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: _viewModel.artigosPopulares.length,
                  itemBuilder: (_,i){
                    Artigo artigo = _viewModel.artigosPopulares[i];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                      child: Container(
                        height: AppSize.s300,
                        width: AppSize.s300,
                        margin: const EdgeInsets.only(left: AppMargin.m10, right: AppMargin.m2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            image: DecorationImage(
                                image: NetworkImage(artigo.img),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: AppSize.s300,
                              width: double.infinity,
                              padding: const EdgeInsets.all(AppPadding.p20),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(AppSize.s20),
                                      bottomLeft: Radius.circular(AppSize.s20)
                                  ),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black38,
                                        Colors.black
                                      ]
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(artigo.titulo, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s30),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            _emAlta(_viewModel.artigosEmAlta)
          ],
        );
      },
    );
  }

  Widget _emAlta(List<Artigo> artigos){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppMargin.m55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.emAlta, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s10,),
          SizedBox(
              height: AppSize.s450,
              width: double.infinity,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: AppSize.s2.toInt(),
                    mainAxisSpacing: AppSize.s10,
                    crossAxisSpacing: AppSize.s10
                ),
                itemCount: artigos.length,
                itemBuilder: (_, index){
                  Artigo artigo = artigos[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppPadding.p5),
                        margin: const EdgeInsets.all(AppMargin.m18),
                        decoration: BoxDecoration(
                            color: ColorManager.branco,
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            boxShadow: [
                              BoxShadow(color: ColorManager.cinza, offset: const Offset(0,0), blurRadius: AppSize.s8)
                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.all(AppMargin.m2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s8),
                                      color: Colors.black,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(artigo.img)
                                      )
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: AppSize.s6,),
                                        Text(artigo.titulo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),)
                                      ],
                                    )
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                  );
                },

              )
          )
        ],
      ),
    );
  }

}

