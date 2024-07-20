import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';

class LogoApp extends StatelessWidget {
  double fontSize;
  bool center;

  LogoApp({super.key, this.fontSize = 48, this.center = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          'App',
          style: getAlexandriaStyle(color: ColorManager.preto, fontSize: fontSize),
        ),
        Text(
          'Blog',
          style: getAliceStyle(color: ColorManager.marrom, fontSize: fontSize),
        )
      ],
    );
  }
}

