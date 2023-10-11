import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screen/loginpage.dart';
import 'package:firebase_practice/widgets/buttonwidget.dart';
import 'package:firebase_practice/widgets/textfieldwidget.dart';
import 'package:firebase_practice/widgets/textwidget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   TextEditingController emailAddress =TextEditingController();
   TextEditingController password =TextEditingController();
   TextEditingController name =TextEditingController();
   TextEditingController userName =TextEditingController();
 
 Future registerUser() async {
   try {
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress.text,
    password: password.text,
  );
  // ignore: use_build_context_synchronously
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: const Text("Sign up Succesfull"),
      
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Ok"))
      ],
    );
  },);
} on FirebaseAuthException catch (e) {
  String errorMessage ="An error Occured";
  if (e.code == 'weak-password') {
    errorMessage='The password provided is too weak.';
  } else if (e.code == 'email-already-in-use') {
    errorMessage='The account already exists for that email.';
  }
  // ignore: use_build_context_synchronously
  showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Sign Up Error"),
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
} catch (e) {
  // ignore: avoid_print
  print(e);

}
 }
 
  @override

  Widget build(BuildContext context) {
    return Scaffold(
       
      body: Container(
        
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/homeScreenImage.png"),
          fit: BoxFit.cover,
        ),
    
        ),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
               const TextWidget(textMessage: "Sign up to Shh!", textColor: Colors.white, textSize: 40),
                
                const SizedBox(height: 40,),
                 CustomButtonWidget(imageAddress: "assets/images/googlelogo.png", bgColor: Colors.black, textMessage: "Sign up with Google", textColor: Colors.white, textSize: 20, buttonWidth: MediaQuery.of(context).size.width*0.8,),
                const SizedBox(height: 40,),
                CustomTextField(textFieldController: name, hintText: "Enter Your Name"),
                
            const SizedBox(height: 20,),
             CustomTextField(textFieldController: userName, hintText: "Enter Your Username"),
            const SizedBox(height: 20,),
                CustomTextField(textFieldController: emailAddress, hintText: "Enter Email"),
              const SizedBox(height: 20,),
             CustomTextField(textFieldController: name, hintText: "Enter Password"),
            const SizedBox(height: 20,),
            
      const SizedBox(height: 20,),

            ElevatedButton(onPressed: ()  {
                registerUser();
            }, child: const Text("Sign Up")),
             const SizedBox(height: 20,),
        InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
        },
        child: const Text("Already Have An Account?")),
          ],
        ),
      ),
    );
  }
}