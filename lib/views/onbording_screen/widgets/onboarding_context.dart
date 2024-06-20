import 'package:flutter/material.dart';
import 'package:todolist_app/const/app_fonts.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Image.asset(imageAsset, height: 300.0,
          ),
        ),
        SizedBox(height: 40.0),
        Text(
          title,
          style: primaryfonts.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold,
          color: Colors.white),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: primaryfonts.copyWith(fontSize: 16.0, color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
