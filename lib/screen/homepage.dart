import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
 final  _picker = ImagePicker();

getImage()async{
final imagefile = await _picker.pickImage(source: ImageSource.camera);
if (imagefile != null) {
  print("image picked");
} 

}
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
    
        body: Column(
          children: [
              TextButton(onPressed: (){}, child: const Text("Pick Image")),

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