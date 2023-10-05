import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screen/loginpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
    
        body: Column(
          children: [
            TextButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
            }, child: const Text("Sign out"))
          ],
        ),
      ),
    );
  }
}