import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class SeguirSeguindoPage extends StatefulWidget {
  String title;
  SeguirSeguindoPage({required this.title});

  @override
  State<SeguirSeguindoPage> createState() => _SeguirSeguindoPageState();
}

class _SeguirSeguindoPageState extends State<SeguirSeguindoPage> {

  _bind(){
    // a depender do tipo (Seguidores ou Seguindo) o método vai ser diferente
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.branco,
      appBar: AppBar(
        title: Text(widget.title, style: getAlexandriaStyle(color: ColorManager.preto, fontSize: AppSize.s25),),
        backgroundColor: ColorManager.branco,
        leading: Builder(
            builder: (context){
              return IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: ColorManager.preto,)
              );
            }
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.branco,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(),
    );
  }
}

