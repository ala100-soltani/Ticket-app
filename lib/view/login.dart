

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/controllers/control.dart';


import 'package:untitled2/view/register.dart';

import 'dashboard2.dart';



class Login extends StatefulWidget{


  @override

  _LoginState  createState() => _LoginState();

}

class _LoginState extends State<Login> {



 final TextEditingController emailcontroller=new TextEditingController();
   final TextEditingController passwordcontroller=TextEditingController();




  Widget build(BuildContext context) {
   return  MaterialApp(
   home:Scaffold(
     resizeToAvoidBottomInset: false,
     backgroundColor: Colors.white,
     appBar: new AppBar(
       elevation: 0,

       backgroundColor: Colors.white,
     ),
     body:SingleChildScrollView(child:Container(
         height: MediaQuery.of(context).size.height,
         width: double.infinity,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween
           ,children: <Widget>[

           Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
             Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
             SizedBox(height: 20,),
             Text("Login to your account",style: TextStyle(fontSize: 15,color: Colors.grey[700]),)


           ],),
           Padding(padding: EdgeInsets.symmetric(horizontal: 40),
             child: Column(children: <Widget>[
               designInput(label:"Email",controller:emailcontroller),
               designInput(label:"Password",obscureText: true,controller:passwordcontroller)

             ],
             ),
           ),
           Padding(
               padding: EdgeInsets.symmetric(horizontal: 40),
               child:  ChangeNotifierProvider<Control>(create: (context)=>Control(),child: Container(
                 child: Consumer<Control>(builder: (context,controle,child){
                   return Container(padding: EdgeInsets.only(top:2,left: 2),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border(
                     bottom: BorderSide(color: Colors.black),
                     top: BorderSide(color: Colors.black),
                     left: BorderSide(color: Colors.black),
                     right: BorderSide(color: Colors.black),
                   )),child:MaterialButton(minWidth: double.infinity,onPressed: (){
                     if(emailcontroller.text.trim().isNotEmpty && passwordcontroller.text.trim().toLowerCase().isNotEmpty){
                       controle.loginUser(emailcontroller.text.trim().toLowerCase(), passwordcontroller.text.trim()).whenComplete((){
                         if(controle.authentification){
                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> new Dashboard2()));



                         }else{
                           _showDialog();
                         }


                       });
                     }
                   },child: Text("Login",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                   ),height: 60,color: Colors.lightBlue,elevation: 0,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),),
                   );
                 },
                 ),
               )


               )
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center
             ,children: <Widget>[
             Text("Dont have an account"),
             InkWell(child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),onTap:(){
               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new Register()));
             },)

           ],
           ),
           Container(height: MediaQuery.of(context).size.height /3,decoration: BoxDecoration(
               image: DecorationImage(
                   image: AssetImage('images/myposte2.png'),
                   fit: BoxFit.cover
               )
           ),
           )


         ]




           ,)


     ), )
   ),
   );






  }
  Widget designInput({label,obscureText=false,controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start
    ,children: <Widget>[
      Text(label,style:TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color:Colors.black87
      )),
      SizedBox(height: 5,),
      TextField(obscureText:obscureText ,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.grey,)),
          border: OutlineInputBorder(borderSide: BorderSide(color:Colors.grey,),
        ),

      ),
        controller: controller,




      ),
    SizedBox(height: 30,)
    ],);

  }



  void _showDialog(){
    showDialog(
        context:context,
        builder:(BuildContext context){
    return const AlertDialog(
    content: Text("password or email invalid"),

    );
    }
    );
  }






  }

