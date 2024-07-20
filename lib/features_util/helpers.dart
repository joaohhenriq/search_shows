class Helpers {
  static String removeHtmlFromString(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }
}