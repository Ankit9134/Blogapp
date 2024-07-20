import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import '../resources/color_manager.dart';

//ignore: must_be_immutable
class ErrorWidgetMy extends StatelessWidget {
  FlutterErrorDetails details;
  ErrorWidgetMy(this.details, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorManager.branco,
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppSize.s20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_rounded, color: ColorManager.marrom, size: AppSize.s60,),
              const SizedBox(height: AppSize.s10,),
              Text(
                details.exception.toString(),
                textAlign: TextAlign.center,
                style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s25),
              )
            ],
          ),
        )
      )
    );
  }
}

