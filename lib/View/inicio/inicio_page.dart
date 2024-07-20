import 'package:app_blog/View/inicio/populares/populares_page.dart';
import 'package:app_blog/View/inicio/topicos/topicos_page.dart';
import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/ViewModel/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'header.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  Future<void> _reloadList() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorManager.branco,
          body: RefreshIndicator(
            backgroundColor: ColorManager.marrom,
            color: ColorManager.branco,
            onRefresh: () => _reloadList(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const Header(),
                  Obx(
                    (){
                      return Get.find<NavigationController>().tab.value == 'Populares'
                          ? PopularesPage() : TopicosPage();
                    }
                  )
                ],
              ),
            ),
          )
      )
    );
  }
}

