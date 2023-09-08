import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

//  292 , 5:29"

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '2a9b8b7fb27348e8a959c3d43b8fc3e1';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  String _selectedCategory = 'business';

  //  299

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach(
      (item) {
        this.categoryArticles[item.name] = [];
      },
    );
  }
// **********************************************************************

  //  301

  get selectedCategory => this._selectedCategory;
  set selectedCategory(valor) {
    this._selectedCategory = valor;


    this.getArticlesByCategory(valor);
    notifyListeners();
  }
  //****************************************************************** */
//  303 .

  List<Article>? get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

//******************************************************************

  getTopHeadlines() async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=2a9b8b7fb27348e8a959c3d43b8fc3e1';

    // '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co';
    print('cargando headlines');

    final resp = await http.get(Uri.parse(url));
    print('httpsUri');

/*
*/
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

//********************************************************************* */

//  301

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';

    print('cargando categorias');

    final resp = await http.get(Uri.parse(url));
    print('http categoria');

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category]!.addAll(newsResponse.articles);
    print('articulos cargados');

    notifyListeners();
    print('notifies OK');

    //********************************************************************* */
  }
}
