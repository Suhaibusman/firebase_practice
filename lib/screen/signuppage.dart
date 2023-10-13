import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/functions/firebasefunction.dart';
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

  late FireBaseFunction firebaseFunction;

  @override
  void initState() {
    firebaseFunction = FireBaseFunction(emailAddress.text, password.text, name.text, userName.text);
    super.initState();
  }
  

  @override
  void dispose() {
    emailAddress.dispose();
    password.dispose();
    name.dispose();
    userName.dispose();
    super.dispose();
  }

  void addUserToFirestore() {
    // Update the values in the FireBaseFunction instance
    firebaseFunction.email = emailAddress.text;
    firebaseFunction.password = password.text;
    firebaseFunction.name = name.text;
    firebaseFunction.address = userName.text;

    // Call the addUser method to add a new user to Firestore
    firebaseFunction.addUser().then((_) {
      print('User added successfully');
    }).catchError((error) {
      print('Failed to add user: $error');
    });
  }

 Future registerUser() async {
  if (isAgree == false) {
    showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: const Text("Please agree to Privacy and Policy and User Agreement below"),
      
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Ok"))
      ],
    );
  },);
 
  }
   else{
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
  String errorMessage ="Please Enter Username And Password";
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
 }
 bool isAgree =false;
 bool isPassVisible =true;
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         resizeToAvoidBottomInset : false,
        body: Container(
          
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
           decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/signupscreenImage.png"),
            fit: BoxFit.cover,
          ),
      
          ),
          child: Column(
            children: [
              // const SizedBox(height: 40,),
              SizedBox(
                child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                       const TextWidget(textMessage: "Sign up to Shh!", textColor: Colors.white, textSize: 40),
                        
                        const SizedBox(height: 20,),
                         CustomButtonWidget(imageAddress: "assets/images/googlelogo.png", bgColor: Colors.black, textMessage: "Sign up with Google", textColor: Colors.white, textSize: 20, buttonWidth: MediaQuery.of(context).size.width*0.8,),
                      const SizedBox(height: 20,),
                       Image.asset("assets/images/continuewithEmail.png"),
                        const SizedBox(height: 20,),
                        CustomTextField(textFieldController: name, hintText: "Enter Your Name"),
                        
                    const SizedBox(height: 20,),
                     CustomTextField(textFieldController: userName, hintText: "Enter Your Username"),
                    const SizedBox(height: 20,),
                        CustomTextField(textFieldController: emailAddress, hintText: "Enter Email"),
                      const SizedBox(height: 20,),
                     CustomTextField(textFieldController: password, hintText: "Enter Password" , isPass: isPassVisible, textFieldIcon: IconButton(onPressed: (){
                      setState(() {
                        isPassVisible =!isPassVisible;
                      });
                     }, icon: const Icon(Icons.remove_red_eye_outlined))),
                   
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Checkbox(value: isAgree, onChanged: (value) {
                    setState(() {
                      isAgree =!isAgree;
                    });
                  },),
                   SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: const TextWidget(textMessage: "I agree with the Terms of Service and Privacy policy", textColor: Colors.white, textSize: 15)),
                ],),
                    
                    
                  ],
                ),
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                         
                              children: [
                                InkWell(
                      onTap: () {
                       addUserToFirestore();
                       // registerUser();
                      },
                      child: CustomButtonWidget( bgColor: Colors.black, textMessage: "Create Account", textColor: Colors.white, textSize: 20, buttonWidth: MediaQuery.of(context).size.width*0.5,)),
                            
                                 const SizedBox(height: 10,),
                                const TextWidget(textMessage: "Already have an account?", textColor: Colors.white, textSize: 20),
                                InkWell(
                                onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                                },
                                child: const TextWidget(textMessage: "Login", textColor: Colors.black, textSize: 20),),
                              const SizedBox(height: 10,),
                              
                              ],
                            ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}