// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/firebase_options.dart';
import 'package:firebase_practice/future_and_stream.dart';
import 'package:flutter/material.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Ideal time to initialize
//  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureAndStreams()
    );
  }
}

