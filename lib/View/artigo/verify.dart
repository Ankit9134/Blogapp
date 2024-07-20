import 'package:app_blog/View/artigo/criar_artigo_page.dart';
import 'package:app_blog/View/login/login_page.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/ViewModel/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.branco,
      body: Obx(
              (){
            return _authController.user.value == null ?
            LoginPage(mensagem: AppStrings.antesCriarArtigo) :
            CriarArtigoPage();
          }
      ),
    );
  }
}

