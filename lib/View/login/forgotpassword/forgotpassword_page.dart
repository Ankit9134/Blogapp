import 'package:app_blog/Model/servicos/recuperarsenha_service.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/forgotpassword/forgotpassword_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final ForgotPasswordViewModel _viewModel = ForgotPasswordViewModel(ForgotPassword());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.branco,
      appBar: AppBar(
        title: Text('Recuperar Senha', style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
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
                  child: Text('Digite um endereço de e-mail para que seja enviado um link de recuperação de senha.', style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
                ),
                const SizedBox(height: AppSize.s30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s25),
                  child: TextFormField(
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    cursorColor: ColorManager.marrom,
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppStrings.email,
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
                GestureDetector(
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      var res = _viewModel.recuperarSenha(_email.text, context);
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
                      child: Text('Enviar link', style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
                    ),
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

