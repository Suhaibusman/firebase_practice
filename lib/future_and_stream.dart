
import 'package:flutter/material.dart';

class FutureAndStreams extends StatefulWidget {
  const FutureAndStreams({super.key});

  @override
  State<FutureAndStreams> createState() => _FutureAndStreamsState();
}

class _FutureAndStreamsState extends State<FutureAndStreams> {

Future <int> futureCounter(counter) async{
 await Future.delayed(const Duration(seconds: 3));
return counter+counter;
  }

 Stream <int> streamCounter(int counter) async*{
  while (counter <=40) {
     await Future.delayed(const Duration(seconds: 1));
  
  yield counter ++;
  }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         FutureBuilder(future: futureCounter(20), builder: (context, snapshot) {
            if (snapshot.hasData) {
              return   Text("Future : ${snapshot.data}", style: const TextStyle(
              fontSize: 40
             ),);
            }
            return const CircularProgressIndicator();
           
         },),
         StreamBuilder(stream: streamCounter(0), builder: (context, snapshot) {
            if (snapshot.hasData) {
              return   Text("Stream : ${snapshot.data}", style: const TextStyle(
              fontSize: 40
             ),);
            }
            return const CircularProgressIndicator();
           
         },)
        ],
      ),),
    );
  }
}