import 'package:url_launcher/url_launcher.dart';

class UtilsFunction {
  static void launchLink(url) async {
    await launch(url);
  }
}
