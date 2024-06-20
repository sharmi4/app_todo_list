import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_app/views/onbording_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      toHomePageMember();
   
  }

  toHomePageMember() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image(image: AssetImage("assets/images/to do_image.png")),
      ),
    );
  }
}
