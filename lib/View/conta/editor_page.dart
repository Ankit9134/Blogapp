import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';
import 'dart:io';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {

  final TextEditingController _nome = TextEditingController();
  final TextEditingController _sobre = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;
  var formKey = GlobalKey<FormState>();
  final ContaViewModel _viewModel = ContaViewModel();
  final imagePicker = ImagePicker();
  bool uploading = false;
  bool loading = true;
  dynamic arquivo;

  _bind() async{
    await _viewModel.acessarDados(context);
    _nome.text = _viewModel.dadosUsuario[0].nome;
    _sobre.text = _viewModel.dadosUsuario[0].sobre;
  }

  Future<XFile?> getImageGallery()async{
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<XFile?> _getImageCamera()async{
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    return image;
  }

  pickAndUploadImageFromGallery()async{
    XFile? file = await getImageGallery();
    if(file != null){
      UploadTask task = await upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot)async{
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

  pickAndUploadImageFromCamera()async{
    XFile? file = await _getImageCamera();
    if(file != null){
      UploadTask task = await upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot)async{
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

  Future<UploadTask> upload(String path)async{
    File file = File(path);
    try{
      String ref = 'accounts/img-${DateTime.now().toString()}.jpg';
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch(e){
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  @override
  void initState() {
    super.initState();
    _bind();
    print(arquivo);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.branco,
        appBar: AppBar(
          title: Text(AppStrings.editarPerfil, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
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
            if(_viewModel.dadosUsuario.isEmpty){
              return const Center(child: CircularProgressIndicator(
                color: ColorManager.marrom,
              ),);
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [

                    // Foto Usuário
                    Container(
                      width: AppSize.s180,
                      height: AppSize.s180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s180),
                      ),
                      padding: const EdgeInsets.all(AppPadding.p2),
                      child: uploading ? const Center(
                        child: CircularProgressIndicator(color: ColorManager.marrom,),
                      ) : arquivo == null ? Container(
                        width: AppSize.s180,
                        height: AppSize.s180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s180),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(_viewModel.dadosUsuario[0].profilePic, scale: 1)
                          )
                        ),
                      ) : Container(
                        width: AppSize.s180,
                        height: AppSize.s180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s180),
                          image: DecorationImage(
                            image: NetworkImage(arquivo)
                          )
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _modalCamera,
                          icon: const Icon(Icons.add_a_photo_outlined, color: ColorManager.marrom, size: AppSize.s30,)
                        )
                      ],
                    ),


                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                            child: TextFormField(
                              cursorColor: ColorManager.marrom,
                              keyboardType: TextInputType.emailAddress,
                              controller: _nome,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: AppStrings.nome
                              ),
                              validator: (value){
                                if(value!.isEmpty || value.length < 2){
                                  return ErrorStrings.nomeValido;
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
                              cursorColor: ColorManager.marrom,
                              textInputAction: TextInputAction.newline,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: _sobre,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: AppStrings.sobre
                              ),
                              validator: (value){
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: AppSize.s85,
                      width: double.infinity,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(AppPadding.p12),
                      child: Center(
                        child: GestureDetector(
                          onTap: (){
                            if(formKey.currentState!.validate()){
                              dynamic res = _viewModel.salvarDados(
                                context,
                                nome: _nome.text,
                                sobre: _sobre.text,
                                profilePic: arquivo ?? _viewModel.dadosUsuario[0].profilePic
                              );
                              return res;
                            }
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorManager.marrom,
                                borderRadius: BorderRadius.circular(AppSize.s10)
                            ),
                            child: Center(
                              child: Text(AppStrings.salvarMudancas, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s18),),
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              );
            }
          },
        ),
      )
    );
  }

  Future _modalCamera(){
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSize.s30),
          topLeft: Radius.circular(AppSize.s30)
        )
      ),
      context: context,
      builder: (context){
        return Container(
          height: AppSize.s180,
          padding: const EdgeInsets.all(AppPadding.p12),
          decoration: BoxDecoration(
            color: ColorManager.branco,
            borderRadius: BorderRadius.circular(AppSize.s30)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: ()=>Navigator.pop(context),
                    icon: const Icon(Icons.close, color: ColorManager.marrom, size: AppSize.s30,)
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: AppSize.s48,
                        width: AppSize.s48,
                        decoration: BoxDecoration(
                          color: ColorManager.cinza,
                          borderRadius: BorderRadius.circular(AppSize.s48)
                        ),
                        child: Center(
                          child: IconButton(
                              onPressed: (){
                                pickAndUploadImageFromCamera();
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.camera_alt_outlined, color: ColorManager.marrom,)
                          ),
                        ),
                      ),
                      Text(AppStrings.camera, style: getAlexandriaStyle(color: ColorManager.preto),)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: AppSize.s48,
                        width: AppSize.s48,
                        decoration: BoxDecoration(
                            color: ColorManager.cinza,
                            borderRadius: BorderRadius.circular(AppSize.s48)
                        ),
                        child: Center(
                          child: IconButton(
                              onPressed: (){
                                pickAndUploadImageFromGallery();
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.photo, color: ColorManager.marrom,)
                          ),
                        ),
                      ),
                      Text(AppStrings.galeria, style: getAlexandriaStyle(color: ColorManager.preto),)
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }

}

