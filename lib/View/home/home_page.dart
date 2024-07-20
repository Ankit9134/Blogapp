import 'package:app_blog/View/inicio/inicio_page.dart';
import 'package:app_blog/View/notificacao/notifica_page.dart';
import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/View/salvos/salvo_page.dart';
import 'package:app_blog/View/search/search_page.dart';
import 'package:app_blog/ViewModel/conta/conta_viewmodel.dart';
import 'package:app_blog/ViewModel/controller/auth_controller.dart';
import 'package:app_blog/ViewModel/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../../Model/models/Frase.dart';
import '../../Model/models/TipoAcessoDataBase.dart';
import '../../Model/servicos/acessardados_service.dart';
import '../common/logo.dart';
import '../conta/conta_page.dart';
import '../resources/color_manager.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  int? indexPage;

  HomePage({this.indexPage = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeViewModel _viewModel = HomeViewModel();
  final AuthController _authController = AuthController();
  final ContaViewModel _contaViewModel = ContaViewModel();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  SnakeShape snakeShape = SnakeShape.circle;
  int _selectedItemPosition = 0;
  Frase frase = Frase();

  final List<Widget> _pages = [
    InicioPage(),
    SearchPage(),
    SalvoPage(),
    NotificationPage(),
    ContaPage()
  ];

  _bind()async{
    await _viewModel.sortearFrase(context);
    await _contaViewModel.acessarDados(context);
  }

  @override
  void initState() {
    super.initState();
    _selectedItemPosition = widget.indexPage!;
    _bind();
  }

  @override
  Widget build(BuildContext context) {

    return Obx(
      (){
        return _authController.user.value == null ?
        _scaffold():
        Observer(
          builder: (_){
            if(_contaViewModel.dadosUsuario.isEmpty){
              return const Scaffold(
                backgroundColor: ColorManager.branco,
                body: Center(
                  child: CircularProgressIndicator(color: ColorManager.marrom,),
                )
              );
            } else {
              return _scaffold(urlProfilePic: _contaViewModel.dadosUsuario[0].profilePic);
            }
          }
        );
      }
    );
  }

  Widget _scaffold({String? urlProfilePic, Function? withoutInternet}){
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: ColorManager.branco,
        elevation: 0,
        toolbarHeight: AppSize.s85,
        title: LogoApp(fontSize: AppSize.s18,),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => setState(() {
              _selectedItemPosition = 4;
            }),
            child: urlProfilePic == null ? const Padding(
                padding: EdgeInsets.all(AppPadding.p12),
                child: CircleAvatar(
                  backgroundColor: ColorManager.branco,
                  maxRadius: AppSize.s25,
                  backgroundImage: AssetImage(AssetsManager.defaultAccount),
                )
            ) : Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: CircleAvatar(
                backgroundColor: ColorManager.branco,
                maxRadius: AppSize.s25,
                backgroundImage: NetworkImage(urlProfilePic),
              ),
            ),
          )
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding: const EdgeInsets.all(AppPadding.p12),
              icon: Image.asset(AssetsManager.menu, width: AppSize.s48, height: AppSize.s48,),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.branco,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      drawer: Drawer(
        backgroundColor: ColorManager.branco,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(AppSize.s70))
        ),
        child: DrawerWidget(frase: _viewModel.fraseSorteada),
      ),
      body: _pages[_selectedItemPosition],
      bottomNavigationBar: SnakeNavigationBar.color(
        //height: 80,
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: snakeShape,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        padding: const EdgeInsets.all(AppPadding.p12),
        backgroundColor: ColorManager.preto,

        //configuration for SnakeNavigationBar.color
        snakeViewColor: ColorManager.branco,
        selectedItemColor: snakeShape == SnakeShape.indicator ? null : ColorManager.marrom,
        unselectedItemColor: ColorManager.branco,

        //configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showSelectedLabels: false,
        showUnselectedLabels: false,

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
              icon: LineIcon.home(),
              label: AppStrings.inicio
          ),
          BottomNavigationBarItem(
              icon: LineIcon.search(),
              label: AppStrings.inicio
          ),
          BottomNavigationBarItem(
              icon: LineIcon.bookmarkAlt(),
              label: AppStrings.salvos
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: AppStrings.notificacoes
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: AppStrings.conta
          ),
        ],

      ),
    );
  }
}

