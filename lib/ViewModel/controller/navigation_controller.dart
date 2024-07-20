import 'package:get/get.dart';

class NavigationController extends GetxController{
  RxString tab = 'Populares'.obs;
  changeTab(String givenTab){
    tab.value = givenTab;
  }
}
