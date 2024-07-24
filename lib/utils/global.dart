import 'package:flutter/material.dart';

import '../modal/shloks_modal.dart';

List<Verse> verses = [];

var repaintKey = GlobalKey();

List imageList = [
  'assets/img/bg.jpg',
  'assets/img/bg3.jpg',
];

List<PopupMenuEntry> popUpMenuItems = [
  const PopupMenuItem(
    value: 0,
    child: Text(
      'Sanskrit',
    ),
  ),
  const PopupMenuItem(
    value: 1,
    child: Text(
      'Hindi',
    ),
  ),
  const PopupMenuItem(
    value: 2,
    child: Text(
      'English',
    ),
  ),
  const PopupMenuItem(
    value: 3,
    child: Text(
      'Gujarati',
    ),
  ),
];
