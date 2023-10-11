import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screen/loginpage.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   TextEditingController emailAddress =TextEditingController();
   TextEditingController password =TextEditingController();
 
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
    return SafeArea(
      child: Scaffold(
         
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
           
            children: [
              
              const Text("Sign Up Page" ,style: TextStyle(fontSize: 50 , fontWeight: FontWeight.bold),) ,
                  
                  const SizedBox(height: 20,),
                  const Row(
                children: [
                  Text("Name",style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                 SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      // controller: emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Name",
                      ),
                    ),
                  ),
            
                ],
              ),
              const SizedBox(height: 20,),
                   const Row(
                children: [
                  Text("Phone Number",style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                 SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      // controller: emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Phone Number",
                      ),
                    ),
                  ),
            
                ],
              ), 
              const SizedBox(height: 20,),
                  const Row(
                children: [
                  Text("Address",style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                 SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      // controller: emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Address",
                      ),
                    ),
                  ),
            
                ],
              ),
                const SizedBox(height: 20,),
                Row(
                children: [
                  const Text("Username",style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                 const SizedBox(width: 20,),
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
                  const Text("Password",style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: password,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Password",
                      ),
                    ),
                  ),
            
                ],
        
        
              ),
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
      ),
    );
  }
}