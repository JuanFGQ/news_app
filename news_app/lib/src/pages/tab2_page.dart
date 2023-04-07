import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/tema.dart';
import 'package:news_app/src/widget/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          _Lista_Categorias(),
          Expanded(
              child:
                  ListaNoticias(newsService.getArticulosCategoriaSeleccionada!))
        ],
      )),
    );
  }
}

class _Lista_Categorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
/*
*con este final es poner al provider a buscar dentro de newService
(la busqueda la representa con la palabra context)
*y el .categories es el docuemento en especifico que quiero traer
*/
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          /*
            *aqui busca dentro de categories... [index] es el indice
            *donde va a buscar la palabra name
            */
          final cName = categories[index].name;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(categories[index]),
                const SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    // final navigacionTagModel = Provider.of<NewsService>(context);
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(categoria.icon,

            /*metodo para cambiar el color del icono de la categoria seleccioanda
        */
            color: (newsService.selectedCategory == categoria.name)
                ? myTheme.colorScheme.secondary
                : Colors.black54),
      ),
    );
  }
}
