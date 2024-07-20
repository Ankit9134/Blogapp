import 'package:app_blog/View/common/logo.dart';
import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/routes_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Model/models/Frase.dart';

class DrawerWidget extends StatelessWidget {
  Frase? frase;
  DrawerWidget({super.key, this.frase});

  final String _frasePadrao = 'A vantagem de ter péssima memória é divertir-se muitas vezes com as mesmas coisas boas como se fosse a primeira vez.';
  final String _autorFrasePadrao = 'Friedrich Nietzsche';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoApp(fontSize: AppSize.s48, center: false),
            const SizedBox(height: AppSize.s25,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Routes.verify);
              },
              child: Container(
                width: double.infinity,
                height: AppSize.s60,
                padding: const EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                    color: ColorManager.marrom,
                    borderRadius: BorderRadius.circular(AppSize.s20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: ColorManager.branco, size: AppSize.s25,),
                    const SizedBox(width: AppSize.s10,),
                    Text(AppStrings.criarArtgio, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s18),)
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSize.s10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(JsonManager.writting, height: AppSize.s100)
              ],
            ),
            const SizedBox(height: AppSize.s10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(frase?.frase == null ? _frasePadrao : frase!.frase,
                  style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s18),),
                const SizedBox(height: AppSize.s8),
                Text(frase?.autor == null ? _autorFrasePadrao : frase!.autor,
                  style: getAlexandriaStyle(color: ColorManager.marrom, fontSize: AppSize.s18),),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.settings),
              child: Container(
                width: double.infinity,
                height: AppSize.s60,
                margin: const EdgeInsets.only(bottom: AppMargin.m30),
                padding: const EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                    color: ColorManager.cinza,
                    borderRadius: BorderRadius.circular(AppSize.s20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.settings, color: ColorManager.branco, size: AppSize.s25,),
                    const SizedBox(width: AppSize.s10,),
                    Text(AppStrings.settings, style: getAliceStyle(color: ColorManager.branco, fontSize: AppSize.s18),)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

