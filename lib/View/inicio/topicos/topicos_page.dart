import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/inicio/inicio_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class TopicosPage extends StatefulWidget {
  const TopicosPage({super.key});

  @override
  State<TopicosPage> createState() => _TopicosPageState();
}

// TODO: implementar as artigos de cada tópico
// ideias:
//  - gerar automaticamente cada seção de tópico com base nos tópicos fonecidos pelo servidor.

class _TopicosPageState extends State<TopicosPage> {

  final InicioViewModel _viewModel = InicioViewModel();

  _bind()async{
    await _viewModel.recuperarArtigosTopico(context);
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
          children: [
            _porTopico('Tecnologia'),
            _porTopico('Programação'),
            _porTopico('Esporte'),
          ],
        );
      },
    );
  }

  _porTopico(String topico){
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
                Text(topico, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.topicosSelecionados, arguments: topico),
                  child: Text(AppStrings.verMais, style: getAlexandriaStyle(color: ColorManager.marrom, fontSize: AppSize.s16),),
                )
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
              itemCount: 5,
              itemBuilder: (_,i){
                return GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppPadding.p5),
                    margin: const EdgeInsets.all(AppMargin.m18),
                    decoration: BoxDecoration(
                      color: ColorManager.branco,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      boxShadow: [
                        BoxShadow(color: ColorManager.cinza, offset: const Offset(0, 0), blurRadius: AppSize.s8)
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
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(AssetsManager.image)
                              )
                            ),
                          ),
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
                                  Text('titulo', style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }

}

