import 'package:flutter/material.dart';

import '../modal/shloks_modal.dart';

List<Verse> verses = [];

var repaintKey = GlobalKey();

List imageList = [
  'assets/img/bg.jpg',
  'assets/img/bg3.jpg',
];

List imageListOfChapters = [
  'assets/img/gita.jpg',
  'assets/img/bg2.jpg',
  'assets/img/gita2.jpg',
  'assets/img/gita3.png',
  'assets/img/gita4.jpg',
  'assets/img/gita5.webp',
  'assets/img/gita6.jpeg',
  'assets/img/gita7.jpg',
  'assets/img/gita8.jpeg',
  'assets/img/gita9.jpg',
  'assets/img/gita10.jpg',
  'assets/img/gita11.jpg',
  'assets/img/gita12.webp',
  'assets/img/gita13.jpg',
  'assets/img/gita14.jpg',
  'assets/img/gita15.jpg',
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
