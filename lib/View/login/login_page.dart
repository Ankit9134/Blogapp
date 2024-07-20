import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:flutter/material.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class LoginPage extends StatefulWidget {
  String? mensagem;
  LoginPage({super.key, this.mensagem = AppStrings.naoLogado});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.mensagem!,
              style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),
              textAlign: TextAlign.center,
            ),
            Column(
              children: [
                _botao(tituloBotao: AppStrings.criarConta, rota: Routes.loginCriarConta),
                const SizedBox(height: AppSize.s8,),
                _botao(tituloBotao: AppStrings.entrar, rota: Routes.loginEntrar),
              ],
            )

          ],
        ),
      )
    );
  }

  Widget _botao({required String tituloBotao, required String rota}){
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, rota),
      child: Container(
        width: AppSize.s140,
        height: AppSize.s60,
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
            color: ColorManager.marrom,
            borderRadius: BorderRadius.circular(AppSize.s10)
        ),
        child: Center(
          child: Text(tituloBotao, style: getAlexandriaStyle(color: ColorManager.branco, fontSize: AppSize.s16),),
        ),
      ),
    );
  }

}

