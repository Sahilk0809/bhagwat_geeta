import 'dart:convert';

import 'package:bhagwat_geeta/modal/shloks_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GitaProvider extends ChangeNotifier {
  List<GitaModal> gitaModalList = [];

  Future<void> jsonParsing() async {
    String json = await rootBundle.loadString('assets/json/shloks.json');
    List response = jsonDecode(json);
    gitaModalList = response
        .map(
          (e) => GitaModal.fromJson(e),
        )
        .toList();
    notifyListeners();
  }

  GitaProvider(){
    jsonParsing();
  }
}
