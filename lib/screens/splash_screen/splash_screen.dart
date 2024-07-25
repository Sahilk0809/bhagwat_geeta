import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(
        seconds: 3,
      ),
      () {
        Navigator.of(context).pushNamed('/home');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/gita.jpg'),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          color: Colors.black45,
          child: const Text(
            'श्रीमद्भगवद्गीता',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 55,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}