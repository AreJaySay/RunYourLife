import 'package:html/parser.dart';

class HtmlParsers{
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}

HtmlParsers htmlParser = new HtmlParsers();