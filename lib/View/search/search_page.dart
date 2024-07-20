import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/search/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Model/models/Artigo.dart';
import '../common/card_artigo.dart';
import '../common/search_box.dart';
import '../resources/routes_manager.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  final SearchViewModel _viewModel = SearchViewModel();

  _bind()async{
    await _viewModel.recuperarDados(context);
    await _viewModel.recuperarTopicos(context);
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
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.branco,
        body: Observer(
          builder: (_){
            if(_viewModel.artigos.isEmpty){
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Barra de pesquisa
                      SearchBox(_viewModel.setFilter),

                      // opções de filtros
                      // TODO: aplicar autoSizeText par ajustar o tamanho do texto do topico
                      Container(
                        width: double.infinity,
                        height: AppSize.s80,
                        padding: const EdgeInsets.only(top: AppPadding.p5, bottom: AppPadding.p5, left: AppPadding.p20),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            GestureDetector(
                              onTap: () => _modal(),
                              child: Container(
                                width: AppSize.s130,
                                height: AppSize.s60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppSize.s20),
                                    border: Border.all(
                                      color: ColorManager.preto,
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.filter_list_rounded, color: ColorManager.preto,),
                                    _viewModel.artigosFiltradosPorTopico ?
                                    Text(_viewModel.topicoSelecionado, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),) :
                                    Text(AppStrings.filtrar, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSize.s10,),
                            _viewModel.artigosFiltradosPorTopico ? GestureDetector(
                              onTap: (){
                                _viewModel.limparFiltro();
                              },
                              child: Container(
                                width: AppSize.s150,
                                height: AppSize.s60,
                                decoration: BoxDecoration(
                                    color: ColorManager.marrom,
                                    borderRadius: BorderRadius.circular(AppSize.s20),
                                    border: Border.all(
                                      color: ColorManager.branco,
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.cancel_rounded, color: ColorManager.branco,),
                                    Text('Limpar Filtro', style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
                                  ],
                                ),
                              ),
                            ) : Container()
                          ],
                        ),
                      ),

                      // resultado da pesquisa
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.58,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _viewModel.listFiltered.length,
                            itemBuilder: (_,i){
                              Artigo artigo = _viewModel.listFiltered[i];
                              return GestureDetector(
                                onTap: ()=>Navigator.pushNamed(context, Routes.leituraPage, arguments: artigo),
                                child: CardArtigo(artigo),
                              );
                            }
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

  Future _modal(){
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.s25),
          topLeft: Radius.circular(AppSize.s25)
        )
      ),
      context: context,
      builder: (context){
        return Container(
          decoration: const BoxDecoration(
            color: ColorManager.branco,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppSize.s25),
              topLeft: Radius.circular(AppSize.s25)
            )
          ),
          height: AppSize.s580,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Text('Filtrar por Tópicos', style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s20),
                  textAlign: TextAlign.center,),
              ),
              SearchBox(_viewModel.setTopicFilter),
              Observer(
                builder: (_){
                  return Container(
                    constraints: const BoxConstraints(
                      maxHeight: 347
                    ),
                    color: ColorManager.branco,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _viewModel.listTopicFiltered.length,
                      itemBuilder: (_, i){
                        return _topico(_viewModel.listTopicFiltered[i]);
                      },
                    ),
                  );
                },
              )
            ],
          ),
        );
      }
    );
  }

  Widget _topico(String topico){
    return GestureDetector(
      onTap: (){
        _viewModel.setBoolTopico(topico);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        margin: const EdgeInsets.only(left: AppMargin.m6),
        child: Text(topico, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18),)
      ),
    );
  }

}

