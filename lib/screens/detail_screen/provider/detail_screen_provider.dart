import 'package:flutter/material.dart';

class DetailScreenProvider extends ChangeNotifier {
  String selectedLanguage = 'Sanskrit';

  void languageTranslate(String value) {
    selectedLanguage = value;
    notifyListeners();
  }
}