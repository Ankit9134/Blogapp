import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData(

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getAlexandriaStyle(color: ColorManager.hintStyleColor),
      labelStyle: getAlexandriaStyle(color: ColorManager.hintStyleColor),
      errorStyle: getAlexandriaStyle(color: ColorManager.vermelho),

      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.marrom, width: AppSize.s1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),

      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.preto, width: AppSize.s1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),

      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.vermelho, width: AppSize.s1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),

      focusedErrorBorder:  const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.marrom, width: AppSize.s1),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
      ),

      activeIndicatorBorder: const BorderSide(
        color: ColorManager.marrom
      )

    )

  );
}