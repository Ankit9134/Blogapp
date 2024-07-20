import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class ButtonEditar extends StatelessWidget {
  const ButtonEditar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.editorPage),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.cinza,
          borderRadius: BorderRadius.circular(AppSize.s20)
        ),
        padding: const EdgeInsets.all(AppPadding.p1),
        child: Container(
          width: AppSize.s150,
          height: AppSize.s45,
          decoration: BoxDecoration(
              color: ColorManager.branco,
              borderRadius: BorderRadius.circular(AppSize.s20)
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppStrings.editarPerfil, style: getAliceStyle(color: ColorManager.preto, fontSize: AppSize.s16),),
                const Icon(Icons.edit, size: AppSize.s18,)
              ],
            )
          ),
        ),
      ),
    );
  }
}

