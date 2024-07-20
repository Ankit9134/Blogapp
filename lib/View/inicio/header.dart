import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/style_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/ViewModel/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  NavigationController navigationController = Get.put(NavigationController());

  Widget _tabCell(String text, bool selected, BuildContext context){
    return selected ? Container(
      height: AppSize.s60,
      width: MediaQuery.of(context).size.width * 0.45 - 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text, style: getAlexandriaStyle(color: ColorManager.marrom, fontSize: AppSize.s18),),
          Container(
            height: AppSize.s8,
            width: AppSize.s8,
            decoration: BoxDecoration(
              color: ColorManager.marrom,
              borderRadius: BorderRadius.circular(AppSize.s8),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.marrom,
                  offset: const Offset(0, 2),
                  blurRadius: 3
                )
              ]
            ),
          )
        ],
      ),
    ) : SizedBox(
      width: MediaQuery.of(context).size.width * 0.45 - 10,
      height: AppSize.s60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(text, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s18),),
          Container(
            height: AppSize.s8,
            width: AppSize.s8,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(AppSize.s8)
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: AppMargin.m20, right: AppMargin.m20),
            height: AppSize.s60,
            child: Obx(
                    (){
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          navigationController.changeTab(AppStrings.populares);
                        },
                        child: _tabCell(AppStrings.populares, navigationController.tab.value == AppStrings.populares, context),
                      ),
                      GestureDetector(
                        onTap: (){
                          navigationController.changeTab(AppStrings.topicos);
                        },
                        child: _tabCell(AppStrings.topicos, navigationController.tab.value == AppStrings.topicos, context),
                      ),
                    ],
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}

