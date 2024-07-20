import 'dart:io';
import 'package:app_blog/Model/models/TipoAcessoDataBase.dart';
import 'package:app_blog/Model/models/TipoSalvarDataBase.dart';
import 'package:app_blog/View/common/mensagens.dart';
import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/ViewModel/artigo/artigo_viewmodel.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Model/models/Artigo.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class CriarArtigoPage extends StatefulWidget {
  const CriarArtigoPage({Key? key}) : super(key: key);

  @override
  State<CriarArtigoPage> createState() => _CriarArtigoPageState();
}

class _CriarArtigoPageState extends State<CriarArtigoPage> {

  final FirebaseStorage storage = FirebaseStorage.instance;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _subTituloController = TextEditingController();
  final TextEditingController _textoController = TextEditingController();
  final ArtigoViewModel _artigoViewModel = ArtigoViewModel();
  final PageController _pageController = PageController(
    initialPage: 0
  );
  int _pageChanged = 0;
  String data = '';
  final ContaViewModel _viewModel = ContaViewModel();
  _bind()async{
    await _viewModel.acessarDados(context);
    await _artigoViewModel.acessarTopicos(context);
    data = DateFormat("dd/MM/yyyy").format(DateTime.now());
  }
  final Artigo artigo = Artigo();
  bool shouldPop = true;
  bool uploading = false;
  bool loading = true;
  dynamic arquivo;
  String topicoSelecionado = '';

  final dropValueTopico = ValueNotifier('');

  Future<XFile?> getImage() async{
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  pickAndUploadImage() async {
    XFile? file = await getImage();
    if(file != null){
      UploadTask task = await upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot) async{
        if(snapshot.state == TaskState.running){
          setState(() {
            uploading = true;
          });
        } else if(snapshot.state == TaskState.success){
          arquivo = await snapshot.ref.getDownloadURL();
          setState(() {
            uploading = false;
          });
        }
      });
    }
  }

  Future<UploadTask> upload(String path) async{
    File file = File(path);
    try{
      String ref = 'images/img-${DateTime.now().toString()}.jpg';
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch(e){
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        await _showDialog(leading: false);
        return shouldPop;
      },
      child: Scaffold(
        backgroundColor: ColorManager.branco,
        appBar: AppBar(
          title: Text(AppStrings.criarArtgio, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
          backgroundColor: ColorManager.branco,
          leading: Builder(
            builder: (context){
              return IconButton(
                onPressed: () => _showDialog(leading: true),
                icon: const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.preto,)
              );
            }
          ),
          actions: [
            _progressStatus()
          ],
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorManager.branco,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index){
            setState(() {
              _pageChanged = index;
            });
          },
          children: [
            // titulo e subtitulo
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSize.s48,),
                      Padding(
                        padding: const EdgeInsets.only(right: AppPadding.p5, left: AppPadding.p5),
                        child: Text(AppStrings.tituloDoArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30), textAlign: TextAlign.center,),
                      ),
                      const SizedBox(height: AppSize.s48,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                        child: TextFormField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(115),
                          ],
                          maxLines: null,
                          cursorColor: ColorManager.marrom,
                          controller: _tituloController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppStrings.titulo
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return ErrorStrings.tituloVazio;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: AppSize.s20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                        child: TextFormField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          maxLines: null,
                          cursorColor: ColorManager.marrom,
                          controller: _subTituloController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppStrings.subTitulo
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return ErrorStrings.subtituloVazio;
                            } else if(value.length < 10) {
                              return ErrorStrings.subtituloCurto;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: AppSize.s20),
                      _topicoW(),
                      const SizedBox(height: AppSize.s48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _button(
                            toNext: true,
                            formKey: _formKey1
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),


            // imagem principal
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSize.s20,),
                      Padding(
                        padding: const EdgeInsets.only(right: AppPadding.p5, left: AppPadding.p5),
                        child: Text(AppStrings.imagemPrincipalArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                      ),
                      const SizedBox(height: AppSize.s48,),
                      Container(
                        margin: const EdgeInsets.only(right: AppMargin.m12, left: AppMargin.m12),
                        width: double.infinity,
                        height: AppSize.s280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s20),
                          border: Border.all(
                            color: ColorManager.preto,
                            width: 1.5
                          ),
                        ),
                        child: uploading ? const Center(
                          child: CircularProgressIndicator(color: ColorManager.marrom,),
                        ) : arquivo == null ? Center(child: Image.asset(AssetsManager.withoutImage),)
                            :
                        Container(
                          width: double.infinity,
                          height: AppSize.s280,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(arquivo)
                            )
                          ),
                        )
                      ),
                      const SizedBox(height: AppSize.s10,),
                      GestureDetector(
                        onTap: pickAndUploadImage,
                        child: Container(
                          width: AppSize.s140,
                          height: AppSize.s60,
                          padding: const EdgeInsets.all(AppPadding.p16),
                          decoration: BoxDecoration(
                              color: ColorManager.marrom,
                              borderRadius: BorderRadius.circular(AppSize.s10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: uploading ? [const CircularProgressIndicator(color: ColorManager.branco)]:[
                              Text(AppStrings.upload, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
                              const Icon(Icons.upload, color: ColorManager.branco,)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.s48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _button(toNext: false),
                          _button(
                            toNext: true,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),


            // texto do artigo
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppSize.s20,),
                        Padding(
                          padding: const EdgeInsets.only(right: AppPadding.p5, left: AppPadding.p5),
                          child: Text(AppStrings.textoArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30), textAlign: TextAlign.center,),
                        ),
                        const SizedBox(height: AppSize.s48,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                          child: TextFormField(
                            onTapOutside: (_) => FocusScope.of(context).unfocus(),
                            maxLines: null,
                            cursorColor: ColorManager.marrom,
                            controller: _textoController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: AppStrings.texto
                            ),
                            validator: (value){
                              if(value!.isEmpty || value.length < 2){
                                return ErrorStrings.textoCurto;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: AppSize.s48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _button(toNext: false),
                            _button(toNext: true, formKey: _formKey3)
                          ],
                        )
                      ],
                    ),
                  ),
                )
            ),


            // Pré-visualização
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
                  child: Observer(
                    builder: (_){
                      return Column(
                        children: [
                          const SizedBox(height: AppSize.s20,),
                          Padding(
                            padding: const EdgeInsets.only(right: AppPadding.p5, left: AppPadding.p5),
                            child: Text(AppStrings.preView, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30), textAlign: TextAlign.center,),
                          ),
                          const SizedBox(height: AppSize.s48),

                          // Pré-visualização do artigo
                          Container(
                            width: double.infinity,
                            height: AppSize.s280,
                            margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
                            decoration: BoxDecoration(
                              color: ColorManager.marrom,
                              borderRadius: BorderRadius.circular(AppSize.s20),
                            ),
                            child: SizedBox(
                              child: arquivo == null ? Image.asset(AssetsManager.withoutImage) : Container(
                                width: double.infinity,
                                height: AppSize.s180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppSize.s20),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(arquivo)
                                  )
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Por ${_viewModel.dadosUsuario[0].nome}', style: getAlexandriaStyle(color: ColorManager.marrom),),
                                Text(' - ${data}', style: getAlexandriaStyle(color: ColorManager.preto),),
                              ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(right: AppMargin.m30, left: AppMargin.m30, bottom: AppMargin.m10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_tituloController.text, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                                const SizedBox(height: AppSize.s6,),
                                Text(_subTituloController.text, style: getAliceStyle(color: ColorManager.marrom, fontSize: AppSize.s20),),
                                const SizedBox(height: AppSize.s6,),
                                Text(_textoController.text, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),),

                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s48),
                          Text(AppStrings.algoErradoArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18), textAlign: TextAlign.center,),
                          const SizedBox(height: AppSize.s48),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _button(toNext: false),
                              _button(toNext: true)
                            ],
                          )
                        ],
                      );
                    },
                  )
              ),
            ),


            // confirmação
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.s20,),
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p5, left: AppPadding.p5),
                  child: Text(AppStrings.confirmacaoArtigo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30), textAlign: TextAlign.center,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _button(toNext: false, text: AppStrings.nao),
                    GestureDetector(
                      onTap: (){
                        Mensagens _mensagem = Mensagens();
                        if(arquivo==null){
                          _mensagem.state = false;
                          _mensagem.mensagemError = ErrorStrings.imagemArtigo;
                          return _mensagem.scaffoldMessege(context);
                        } else if(topicoSelecionado == '') {
                          _mensagem.state = false;
                          _mensagem.mensagemError = ErrorStrings.topico;
                          return _mensagem.scaffoldMessege(context);
                        } else {
                          artigo.titulo = _tituloController.text;
                          artigo.subTitulo = _subTituloController.text;
                          artigo.texto = _textoController.text;
                          artigo.autor = _viewModel.dadosUsuario[0].nome;
                          artigo.img = arquivo;
                          artigo.topico = topicoSelecionado;
                          dynamic res = _artigoViewModel.salvarDados(context,
                            artigo: artigo
                          );
                          return res;
                        }
                      },
                      child: Container(
                        width: AppSize.s140,
                        height: AppSize.s60,
                        padding: const EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                            color: ColorManager.marrom,
                            borderRadius: BorderRadius.circular(AppSize.s10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(AppStrings.sim, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }


  /// Método responsável por implementar o botão de *próximo* ou *anterior*, a depender do parâmentro **toNext**.
  ///
  /// Exemplo de uso:
  ///
  ///  - Se o parâmetro **toNext** for **True** , o botão será setado como *próximo* e executará sua respectiva função.
  ///
  ///  - Se o parâmetro **toNext** for **False** , o botão será setado como *anterior* e executará sua respectiva função.
  ///
  /// Observação:
  ///
  /// É possível setar a **formKey**. Sua função é indicar a chave global, para que seja possível verificar e validar os campos daquela respectiva chave.
  Widget _button({required bool toNext, GlobalKey<FormState>? formKey, String? text}){
    _toNext(){
      if(_pageChanged==4){
        _pageController.animateToPage(
          4,
          duration: Duration(milliseconds: AppSize.s250.toInt()),
          curve: Curves.easeInOut
        );
      } else {
        if(formKey!=null){
          if(formKey.currentState!.validate()){
            _pageController.animateToPage(
              ++_pageChanged,
              duration: Duration(milliseconds: AppSize.s250.toInt()),
              curve: Curves.easeInOut
            );
          }
        }else{
          _pageController.animateToPage(
            ++_pageChanged,
            duration: Duration(milliseconds: AppSize.s250.toInt()),
            curve: Curves.easeInOut
          );
        }
      }
    }
    _toBack(){
      if(_pageChanged==0){
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: AppSize.s250.toInt()),
          curve: Curves.easeInOut
        );
      } else {
        _pageController.animateToPage(
          --_pageChanged,
          duration: Duration(milliseconds: AppSize.s250.toInt()),
          curve: Curves.easeInOut
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: GestureDetector(
        onTap: () => toNext ? _toNext() : _toBack(),
        child: Container(
          width: AppSize.s140,
          height: AppSize.s60,
          padding: const EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
              color: ColorManager.marrom,
              borderRadius: BorderRadius.circular(AppSize.s10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: toNext ? [
              Text(text ?? AppStrings.next, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
              const Icon(Icons.arrow_forward_ios_rounded, color: ColorManager.branco,)
            ] : [
              const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.branco,),
              Text(text ?? AppStrings.back, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),)
            ],
          ),
        ),
      ),
    );
  }

  _showDialog({required bool leading})async{
    await showDialog(
      context: context,
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
                  Text(AppStrings.sairCriarArtigo,
                    style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buttonDialog(tituloBotao: AppStrings.nao, onPressed: (){
                        setState(() {
                          shouldPop = false;
                        });
                        print(shouldPop);
                        Navigator.pop(context);
                      }),
                      _buttonDialog(
                        tituloBotao: AppStrings.sim,
                        onPressed: (){
                          if(leading){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              shouldPop = true;
                            });
                            Navigator.pop(context);
                          }
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

  Widget _buttonDialog({required String tituloBotao, required VoidCallback onPressed}){
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

  Widget _topicoW(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: () => _modal(),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p10),
          width: double.infinity,
          height: AppSize.s50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            color: ColorManager.branco,
            border: Border.all(
              color: ColorManager.marrom,
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(topicoSelecionado==''?AppStrings.topico:topicoSelecionado, style: getAlexandriaStyle(color: ColorManager.preto),),
              const Icon(Icons.keyboard_arrow_down_rounded, color: ColorManager.marrom, size: AppSize.s30,)
            ],
          ),
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
                child: Text('Tópicos', style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s20),
                  textAlign: TextAlign.center,),
              ),
              Observer(
                builder: (_){
                  return Container(
                    constraints: const BoxConstraints(
                      maxHeight: AppSize.s400
                    ),
                    color: ColorManager.branco,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _artigoViewModel.topicos.length,
                      itemBuilder: (_, i){
                        return _topico(_artigoViewModel.topicos[i]);
                      },
                    ),
                  );
                },
              )
            ]
          )
        );
      }
    );
  }

  Widget _topico(String topico){
    return GestureDetector(
      onTap: (){
        setState(() {
          topicoSelecionado = topico;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        margin: const EdgeInsets.only(left: AppMargin.m6),
        child: Text(topico, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18),)
      ),
    );
  }

  Widget _progressStatus(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: AppPadding.p20),
          child: Text('${_pageChanged+1} de 5', style: getAlexandriaStyle(color: ColorManager.marrom, fontSize: AppSize.s16),),
        )
      ],
    );
  }

}

