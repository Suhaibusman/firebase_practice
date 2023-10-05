import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screen/homepage.dart';
import 'package:firebase_practice/screen/signuppage.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> loginUser() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailAddress.text, password: password.text);

      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }

      // Show an error dialog with the error message.
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Login Error"),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Login Page",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text(
                    "Username",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Username",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: password,
                      obscureText: true, // Hide the password input
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Password",
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  loginUser();
                },
                child: const Text("Login"),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text("Do You Want to Create an Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
