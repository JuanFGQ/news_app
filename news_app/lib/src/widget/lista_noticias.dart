import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/pages/tab3_page.dart';
import 'package:news_app/src/theme/tema.dart';
import 'package:news_app/utilis/url_launcher.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        // *********************************************************
        return _Noticia(noticia: this.noticias[index], index: index);
        /*
        aqui tengo que devolver valores referentes a las variable 
        declaradas en la clase _Noticia de la linea 31,32
        *************************************************************
        */
      },
    );
  }
}

// clase creada en 295 inicio

class _Noticia extends StatelessWidget {
  final Article noticia;

  // la objetivo de este index es saber en que noticia estoy 1,2,3 etc
  final int index;

  const _Noticia({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        _TarjetaBotones(noticia),
        SizedBox(height: 10),
        Divider()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  final Article noticia;
  const _TarjetaBotones(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () => launcherUrl(context, noticia),
            // {
            // print(noticia.url);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) => NewsBody(),
            //   ),
            // );
            // },
            fillColor: Colors.amber,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Read More',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text((noticia.description != null) ? noticia.description : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      child: Container(
          child: (noticia.urlToImage != null &&
                  noticia.urlToImage.startsWith('http'))
              ? FadeInImage(
                  placeholder: AssetImage('assets/barra_colores.gif'),
                  image: NetworkImage(noticia.urlToImage))
              : Image(image: AssetImage('assets/no-image.png'))),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          noticia.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          // este index me enumera las noticas
          Text('${index + 1}.',
              style: TextStyle(color: Colors.white, fontSize: 15)),
          // este text me dice las fuentes de las noticias
          Text(
            '${noticia.source.name}.',
            style: TextStyle(
                color: Colors.blue.shade600,
                fontSize: 15,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
