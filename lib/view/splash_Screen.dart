import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/view/login.dart';
import 'package:untitled2/view/register.dart';


class Splash extends StatefulWidget{

  Splash_State createState()=>Splash_State();



}

class Splash_State extends State<Splash>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(child:Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(children: [
                Text("Welcome Poste",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("connect to post",textAlign: TextAlign.center,style:TextStyle(color: Colors.grey[750],fontSize: 15 ),
                ),


              ]),
              Container(
                height: MediaQuery.of(context).size.height /3,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/myposte.png')),

                ),
              ),
              Column(
                children: <Widget>[
                  MaterialButton(minWidth: double.infinity,onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new Login()));},child: Text("Login",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                  ),height: 60,
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(50)),),
                  SizedBox(height: 20,),
                  Container(padding: EdgeInsets.only(top:2,left: 2),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  )),child:MaterialButton(minWidth: double.infinity,onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new Register()));},child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                  ),height: 60,color: Colors.lightBlue,elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),), )
                ],
              ),
            ],
          ),

        ),)
      ),

    );
  }

}
