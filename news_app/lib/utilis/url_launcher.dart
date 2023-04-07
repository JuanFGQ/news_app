import 'package:flutter/cupertino.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:url_launcher/url_launcher.dart';

// launcherUrl(BuildContext context, Article noticia) async {
//   final url = '';

//   if (noticia.url == 'http') {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launc $url';
//     }
//   } else {
//     print('noti');
//   }
// }

Future<void> launcherUrl(BuildContext context, Article noticia) async {
  final Uri url = Uri.parse(noticia.url!);

  if (noticia.url!.startsWith('http')) {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  } else {
    debugPrint('NotiTest');
  }
}
