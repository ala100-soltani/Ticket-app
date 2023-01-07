

import 'package:flutter/material.dart';
import 'package:untitled2/view/dashboard2.dart';

import 'package:untitled2/view/splash_Screen.dart';




void main() async{




runApp(Myapp()
);
}
class Myapp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title:"soltani ala eddine",
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: Splash(),


    );


  }



}



