

import 'package:flutter/material.dart';
import 'package:untitled2/controllers/control.dart';

import 'login.dart';

class Register extends StatefulWidget{
  @override

  _RegisterState  createState() => _RegisterState();

}

class _RegisterState extends State<Register> {
  Control controle=new Control();
  var message;
  final TextEditingController _namecontroller=new TextEditingController();
  final TextEditingController _emailcontroller=new TextEditingController();
  final TextEditingController _passwordcontroller=TextEditingController();
  _onPressed(){
    setState(() {
      if(_emailcontroller.text.trim().isNotEmpty && _passwordcontroller.text.trim().toLowerCase().isNotEmpty){
        controle.registerUser(_namecontroller.text.trim(),_emailcontroller.text.trim().toLowerCase(), _passwordcontroller.text.trim()).whenComplete((){
          if(controle.status){
            _showDialog();
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> new Login()));
          }


        });
      }
    });
  }



  Widget build(BuildContext context) {
    return  MaterialApp(
      home:Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: new AppBar(
          elevation: 0,

          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(child:Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween
              ,children: <Widget>[

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
                Text("Sign Up",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Register here",style: TextStyle(fontSize: 15,color: Colors.grey[700]),)


              ],),
              Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(children: <Widget>[
                  designInput(label:"Fullname",controller:_namecontroller),
                  designInput(label:"Email",controller:_emailcontroller),
                  designInput(label:"Password",obscureText: true,controller:_passwordcontroller)

                ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child:   Container(
                    child:  Container(padding: EdgeInsets.only(top:2,left: 2),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),child:MaterialButton(minWidth: double.infinity,onPressed: (){
                      _onPressed();

                    }
                      ,child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                      ),height: 60,color: Colors.yellowAccent,elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),),
                    ))
                ,
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center
                ,children: <Widget>[
                Text("If you have an acoount"),
                InkWell(child: Text("Login",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new Login()));
                },)

              ],
              ),



            ]




              ,)
        ) ,)


    )
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

