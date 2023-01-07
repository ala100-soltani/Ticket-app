
import 'dart:async';


import 'package:flutter/material.dart';

import 'package:untitled2/model/dataModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget{

 _DashoardState createState() => _DashoardState();



}

class _DashoardState extends State<Dashboard> {
StreamController<DataModel> _streamController=new StreamController();
var selectedItem='manouba';



  @override

  void initState() {



    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      getNumero(selectedItem);

    });
  }
  Future<void> getNumero(poste)async {
    final prefs=await SharedPreferences.getInstance();
    const key='token';
    final value=prefs.getString(key) ?? 0;
   final response = await http.post(Uri.parse('https://powerful-anchorage-79990.herokuapp.com/api/tickets/courant'),
        headers: <String,String> {"Content-Type": "application/json","Authorization":"$value"},
       body: jsonEncode(<String,String>{
         'postName':'$poste'
       })

   );
    if(response.statusCode==200) {
      final dataBody = json.decode(response.body);
      DataModel dataModel = new DataModel.fromJson(dataBody);

      _streamController.sink.add(dataModel);
    }else{
      throw Exception("error");
    }

  }








  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home:Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: new AppBar(
              elevation: 0,

              backgroundColor: Colors.white,
            ),
    body: Column(children: <Widget>[
      Container( color: Colors.blue,child: Center(child:Text('${selectedItem}',style: TextStyle(fontSize: 40),) ,),),


      Container(height: 60,child:Center(




          child:StreamBuilder<DataModel>(
            stream: _streamController.stream,
            builder: (context,snapdata){
              switch(snapdata.connectionState){
                case ConnectionState.waiting :return Center(child: Text('0',style:TextStyle(fontFamily: 'digital-7',fontSize: 80)),);
                default:if(snapdata.hasError){
                  return Text('Error');
                }else{


                  return numberWidget(snapdata.data!);
                }
              }
            },
          )

      ), ),
      SizedBox(height: 30,),
      Container(height: 60,color: Colors.blue,),
      SizedBox(height: 50,),



      DropdownButton(items: ["manouba","bardo","ben arous"].map((e) => DropdownMenuItem(child:
      Text("$e"),value: e)).toList(),onChanged: ( String? val){
        setState(() {
          selectedItem= val!;
        });

      },value:selectedItem ,)

    ],)




    )

    );







  }
  Widget numberWidget(DataModel dataModel){

    return Center(
      child: Text('${dataModel.numero}',style:TextStyle(fontFamily: 'digital-7',fontSize: 80)),
    );

  }


  
}