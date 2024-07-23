import 'package:bhagwat_geeta/provider/shloks_provider.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier{
  int languageIndex = 0;

  void translateLanguage(){
    if(languageIndex<3){
      languageIndex++;
      notifyListeners();
    }
    else{
      notifyListeners();
      languageIndex = 0;
    }
  }
}