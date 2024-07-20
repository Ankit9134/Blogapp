import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

//ignore: must_be_immutable
class SearchBox extends StatelessWidget {
  Function(String) function;
  SearchBox(this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p16),
      child: TextField(
        cursorColor: ColorManager.marrom,
        decoration: InputDecoration(
          hintText: AppStrings.pesquisar,
          hintStyle: getAlexandriaStyle(color: ColorManager.cinza),
          prefixIcon: const Icon(Icons.search_rounded, color:ColorManager.preto, size: AppSize.s30,),
        ),
        textInputAction: TextInputAction.search,
        onChanged: function,
        keyboardType: TextInputType.text,
        style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s16),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
