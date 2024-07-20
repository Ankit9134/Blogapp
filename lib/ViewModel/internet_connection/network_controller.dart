import 'package:app_blog/View/resources/color_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../View/resources/style_manager.dart';

class NetworkController extends GetxController{
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult){
    if(connectivityResult == ConnectivityResult.none){
      Get.rawSnackbar(
        messageText: Text('Sem Internet',
          style: getAlexandriaStyle(color: Colors.white, fontSize: AppSize.s12),
        ),
        isDismissible: false,
        borderRadius: AppSize.s20,
        duration: const Duration(days: 1),
        backgroundColor: ColorManager.vermelho,
        icon: const Icon(Icons.wifi_off_rounded, color: ColorManager.branco, size: AppSize.s30,),
        padding: const EdgeInsets.all(AppSize.s20),
        margin: const EdgeInsets.only(top: AppSize.s20, right: AppSize.s80, left: AppSize.s80),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP
      );
    } else {
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}