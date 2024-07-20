import 'package:flutter/material.dart';
import '../../Model/models/Artigo.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

// ignore: must_be_immutable
class CardArtigo extends StatelessWidget {
  Artigo artigo;
  CardArtigo(this.artigo);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: AppSize.s145,
        padding: const EdgeInsets.all(AppPadding.p5),
        margin: const EdgeInsets.all(AppMargin.m18),
        decoration: BoxDecoration(
            color: ColorManager.branco,
            borderRadius: BorderRadius.circular(AppSize.s20),
            boxShadow: [
              BoxShadow(color: ColorManager.cinza, offset: const Offset(0,0), blurRadius: AppSize.s8)
            ]
        ),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(AppMargin.m6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      color: Colors.black,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(artigo.img)
                      )
                  ),
                )
            ),
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: AppSize.s100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSize.s6,),
                          Text(artigo.titulo, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),)
                        ],
                      ),
                    ),
                    Text(artigo.topico, style: getAlexandriaStyle(color: ColorManager.marrom),),
                    const SizedBox(height: AppSize.s2,),
                    Text(artigo.data, style: getAlexandriaStyle(color: ColorManager.cinza),),
                  ],
                )
            ),
          ],
        )
    );
  }
}

