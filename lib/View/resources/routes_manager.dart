import 'package:app_blog/View/artigo/criar_artigo_page.dart';
import 'package:app_blog/View/artigo/verify.dart';
import 'package:app_blog/View/conta/artigos_page.dart';
import 'package:app_blog/View/conta/seguir_seguindo_page.dart';
import 'package:app_blog/View/home/home_page.dart';
import 'package:app_blog/View/inicio/topicos/topicos_page.dart';
import 'package:app_blog/View/inicio/topicos/topicos_selecionados_page.dart';
import 'package:app_blog/View/leitura/leitura_page.dart';
import 'package:app_blog/View/login/criarconta_page.dart';
import 'package:app_blog/View/login/forgotpassword/forgotpassword_page.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/View/ver_usuario/ver_usuario_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../conta/editor_page.dart';
import '../login/entrar_page.dart';
import '../settings/settings_page.dart';
import 'color_manager.dart';

sealed class Routes{

  static const String initialRoute = '/';
  static const String leituraPage = 'leiturapage';
  static const String topicos = 'topicos';
  static const String topicosSelecionados = 'topicosselecionados';
  static const String loginCriarConta = 'logincriarconta';
  static const String loginEntrar = 'loginentrar';
  static const String forgotPassword = 'forgotPassword';
  static const String editorPage = 'editorpage';
  static const String seguirSeguindoPage = 'seguirseguindopage';
  static const String artigosPage = 'artigospages';
  static const String settings = 'configuracoes';
  static const String criarArtigoPage = 'criarArtigoPage';
  static const String verify = 'verify';
  static const String verUsuarioPage = 'verUsuarioPage';

}

sealed class RouteGenerator{

  static Route<dynamic> getRoute(RouteSettings routeSettings){

    dynamic args = routeSettings.arguments;

    switch(routeSettings.name){
      case Routes.initialRoute:
        if(args==null){
          return MaterialPageRoute(builder: (_) => HomePage());
        } else {
          return MaterialPageRoute(builder: (_) => HomePage(indexPage: args,));
        }
      case Routes.leituraPage:
        return MaterialPageRoute(builder: (_) => LeituraPage(args));
      case Routes.topicos:
        return MaterialPageRoute(builder: (_) => TopicosPage());
      case Routes.topicosSelecionados:
        return MaterialPageRoute(builder: (_) => TopicosSelecionadosPage(args));
      case Routes.loginCriarConta:
        return MaterialPageRoute(builder: (_) => CriarContaPage());
      case Routes.loginEntrar:
        return MaterialPageRoute(builder: (_) => EntrarPage());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case Routes.editorPage:
        return MaterialPageRoute(builder: (_) => EditorPage());
      case Routes.seguirSeguindoPage:
        return MaterialPageRoute(builder: (_) => SeguirSeguindoPage(title: args));
      case Routes.artigosPage:
        return MaterialPageRoute(builder: (_) => ArtigosPage(args));
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case Routes.criarArtigoPage:
        return MaterialPageRoute(builder: (_) => CriarArtigoPage());
      case Routes.verify:
        return MaterialPageRoute(builder: (_) => VerifyPage());
      case Routes.verUsuarioPage:
        return MaterialPageRoute(builder: (_) => VerUsuarioPage(args));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        backgroundColor: ColorManager.branco,
        appBar: AppBar(
          title: Text(AppStrings.routeNotFound, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
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
        body: Center(
          child: Text(AppStrings.routeNotFound, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s30),),
        ),
      );
    });
  }

}
