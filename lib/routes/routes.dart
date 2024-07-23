import 'package:bhagwat_geeta/screens/detail_screen/detail_screen.dart';
import 'package:bhagwat_geeta/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen/view/home_screen.dart';

class MyRoutes{
  static Map<String, Widget Function(BuildContext)> myRoutes = {
    '/detail' : (context) => const DetailScreen(),
    '/' : (context) => const HomeScreen(),
  };
}