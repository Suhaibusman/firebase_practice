
import 'package:firebase_practice/widgets/textwidget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
           decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homeScreenImage.png"),
            fit: BoxFit.cover,
          ),
    
          ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(textMessage: "Welcome To", textColor: Colors.white, textSize: 40),
              TextWidget(textMessage: "Shh!", textColor: Colors.white, textSize: 40),
              TextWidget(textMessage: "A Hub Where Whispers Echo Loudest", textColor: Colors.black, textSize: 20)
            
            ],
          ),
        ),

        ),
      ),
    );
  }
}