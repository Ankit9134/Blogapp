import 'package:app_blog/ViewModel/dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'View/common/error_widget.dart';
import 'ViewModel/app.dart';

void main() async {
  ErrorWidget.builder = (details) => ErrorWidgetMy(details);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
  DependencyInjection.init();
}

// TODO: resolver questão de reinicialização instantânea das widgets principais (início, pesquisa, salvos, notificações, conta)
