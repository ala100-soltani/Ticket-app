import 'dart:async';


import 'package:flutter/material.dart';
import 'package:untitled2/controllers/control.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/model/ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:untitled2/view/dashboard.dart';

class Ticket extends StatefulWidget{


  @override

  _TicketState  createState() => _TicketState();

}

class _TicketState extends State<Ticket>{
  StreamController<TicketClient> _streamController1=new StreamController();

  Control controle=new Control();
  Dashboard dash=new Dashboard();

  var selectedItem='manouba';
  Future<void>  getTicketClient()async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.getString(key) ?? 0;
    final response = await http.get(Uri.parse(
        'https://powerful-anchorage-79990.herokuapp.com/api/tickets/custom'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "$value"
      },


    );


      final data = json.decode(response.body);





    TicketClient ticketModel = new TicketClient.fromJson(data[0]);







    _streamController1.sink.add(ticketModel);



  }
  void initState(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      getTicketClient();

    });










    super.initState();
  }
  Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
         resizeToAvoidBottomInset: false,
         backgroundColor: Colors.grey.shade200,
         appBar: new AppBar(
           elevation: 0,

           backgroundColor: Colors.white,
         ),
       body:Column(

         children: [
           SizedBox(height: 60,),

         Container(

         child:  StreamBuilder<TicketClient>(
             stream: _streamController1.stream,
             builder: (context,snapshot){
               switch(snapshot.connectionState){
                 case ConnectionState.waiting :return Center(child: ticketWidget( "_","_","_" ),);
                 default:if(snapshot.hasError){
                   return Text('Error');
                 }else if(snapshot.hasData){
                   print(snapshot.data!.numero);
                   return Center(child: ticketWidget( snapshot.data!.postName,snapshot.data!.numero,snapshot.data!.date ));

                 }else{
                   return Center(child:ticketWidget( "_","_","_" ) ,);

                 }
               }
             },
           )
         ),
         Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
           Container(
               child: ElevatedButton(onPressed: (){

                   controle.getTicket(selectedItem);

                 if(controle.statusTicket){
                   _showDialog();

                 }





               },child: new Text("get Ticket"),)
           ),
           SizedBox(width: 20,),
           DropdownButton(items: ["manouba","bardo","ben arous"].map((e) => DropdownMenuItem(child:
           Text("$e"),value: e)).toList(),onChanged: ( String? val){
             setState(() {
               selectedItem= val!;
             });

           },value:selectedItem ,)

         ],)
       ],)
     ),
   );
  }

  Widget ticketWidget( String? ala,String? zina, String? bilel){

    return Padding(padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize:MainAxisSize.min ,
        children: <Widget>[
          Container(height: 100,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
            child: Column(children: <Widget>[
              Row(children: [
                Text('POSTE',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.blue)),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20)
                  ),

                  child:SizedBox(
                  height: 8,
                  width: 8,
                  child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(5)),
                  )
                  ,
                ) ,),

                Text('TUNISIE',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.yellowAccent)),
                Container(
                  padding: EdgeInsets.all(10),


                  child:SizedBox(
                    height: 8,
                    width: 5,
                    child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(5)),
                    )
                    ,
                  ) ,),
                Text('$bilel',style:TextStyle(fontSize: 14))
              ],),
              Center(child:Text('$zina',style:TextStyle(fontFamily: 'digital-7',fontSize: 50))),

            ],),
           ),
          Container(
            color: Colors.white,
            child:Row(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10) ),
                          color: Colors.grey.shade200
                      ),
                    ),
                  ),
                  Expanded(child: LayoutBuilder(builder: (context, constraints) {
                    return Flex(
                      children: List.generate((constraints.constrainWidth()/10).floor(), (index) =>
                          SizedBox(height: 1,width: 5,child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.shade300),),)),
                      direction: Axis.horizontal,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    );

                  }),),
                  SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10) ),
                          color: Colors.grey.shade200
                      ),
                    ),
                  ),

                ]
            ),

          ),




          Container(height: 50,
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16))),
            child: Center(child: Text('$ala',style: TextStyle(fontFamily: 'digital-7',fontSize: 50,))
    ),




          )],

      ),
    );


  }
  void _showDialog(){
    showDialog(
        context:context,
        builder:(BuildContext context){
          if(new DateTime.now().hour<=12 && new DateTime.now().hour>=6 ){
            return  const AlertDialog(
              content: Text("you already have a ticket"),

            );
          }else{
            return  const AlertDialog(
              content: Text(" server denied "),

            );

          }
        }
    );
  }


}