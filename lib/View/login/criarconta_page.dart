import 'package:app_blog/Model/models/Usuario.dart';
import 'package:app_blog/Model/servicos/authentication_service.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/ViewModel/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class CriarContaPage extends StatefulWidget {
  const CriarContaPage({super.key});

  @override
  State<CriarContaPage> createState() => _CriarContaPageState();
}

class _CriarContaPageState extends State<CriarContaPage> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController _nome = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  final LoginViewModel _viewModel = LoginViewModel(CreateUserWithEmailAndPassword());

  Usuario usuario = Usuario();

  bool _senhaObscura = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.branco,
      appBar: AppBar(
        title: Text(AppStrings.criarConta, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                  child: TextFormField(
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    cursorColor: ColorManager.marrom,
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
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: ColorManager.marrom,
                    controller: _email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppStrings.email
                    ),
                    validator: (value){
                      if(!value!.contains('@') || !value.contains('.com')){
                        return ErrorStrings.emailValido;
                      } else if(value.isEmpty){
                        return ErrorStrings.emailVazio;
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
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    cursorColor: ColorManager.marrom,
                    controller: _senha,
                    obscureText: _senhaObscura,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppStrings.senha,
                      suffixIcon: IconButton(
                        icon: _senhaObscura ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined),
                        color: ColorManager.marrom,
                        onPressed: (){
                          setState(() {
                            _senhaObscura = !_senhaObscura;
                          });
                        },
                      ),
                    ),
                    validator: (value){
                      if(value!.length < 6){
                        return ErrorStrings.senhaCurta;
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s20,),
                GestureDetector(
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      usuario.nome = _nome.text;
                      usuario.email = _email.text;
                      usuario.senha = _senha.text;
                      var res = _viewModel.criarConta(usuario, context);
                      return res;
                    }
                  },
                  child: Container(
                    width: AppSize.s330,
                    height: AppSize.s60,
                    padding: const EdgeInsets.all(AppPadding.p16),
                    decoration: BoxDecoration(
                        color: ColorManager.marrom,
                        borderRadius: BorderRadius.circular(AppSize.s10)
                    ),
                    child: Center(
                      child: Text(AppStrings.criarConta, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
                    ),
                  )
                )
              ],
            )
          ),
          const SizedBox(height: AppSize.s60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.jaTemConta, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),),
              const SizedBox(width: AppSize.s2,),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.loginEntrar),
                child: Text(AppStrings.facaLogin, style: getAliceStyle(color: ColorManager.marrom, fontSize: AppSize.s16),),
              )
            ],
          )
        ],
      ),
    );
  }
}

