import 'package:url_launcher/url_launcher.dart';

class WebLaunch {
  static Future<void> loadWeb(String url) async {
    Uri webUrl = Uri.parse(url);

    if (!await launchUrl(webUrl)) {
      throw Exception('Could not launch pdf_url`');
    }
  }
}
