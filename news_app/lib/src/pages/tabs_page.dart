import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // *_NavegacionModel es una instacia de esta misma clase
      // *donde solo puedo tener acceso a
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override

  // *el context es u objeto que tiene toda la informacion de su
  // *arbol de widgets
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,

      /*
      *con el (i) obtengo el indice de valores disponibles segun
      *las opciones desplegadas en el bottomNavigationBar

      *con la variable final declarada obtengo la instacia
      *y en el on tab cambio el valor mediante la instancia llamada
      */
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'para ti'),
        BottomNavigationBarItem(
            icon: Icon(Icons.newspaper), label: 'Encabezados')
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,

      // efecto al hacer scroll a la pagina
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  // haciendo getter

  int get paginaActual => this._paginaActual;

  // haciendo setter
  set paginaActual(int valor) {
    this._paginaActual = valor;

// *el indice equivale al valor que recibo
    _pageController.animateToPage(valor,
        duration: Duration(microseconds: 250), curve: Curves.bounceOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
