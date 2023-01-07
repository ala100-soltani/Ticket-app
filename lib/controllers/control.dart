import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/model/ticket.dart';

class Control extends ChangeNotifier{
 late bool authentification;
 var status;

 var raw;

 late bool statusTicket;



 Future<http.Response?> loginUser(String email,String password) async{

   http.Response  response = await http.post(Uri.parse('https://powerful-anchorage-79990.herokuapp.com/api/auth'),
        headers: <String,String>{"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode(<String,String>{
          'email':email,
          'password':password
        })
    );
    status=response.body.contains("error");
    var data=json.decode(response.body);
    if(status){

      authentification=false;

    }else{
      authentification=true;

_save(data['token']);

    }
    notifyListeners();

  }
  _save(String token) async{
    final prefs=await SharedPreferences.getInstance();
    final key='token';
    final value=token;
    prefs.setString(key, value);


  }
  read() async{
    final prefs=await SharedPreferences.getInstance();
    final key='token';
    final value=prefs.getString(key) ?? 0;




  }
   registerUser(String fullname,String email,String password) async{



    var response = await http.post(Uri.parse('https://powerful-anchorage-79990.herokuapp.com/api/users'),
        headers: <String,String>{"Content-Type": "application/json"},
        body: jsonEncode({
          'fullname':fullname,
          'email':email,
          'password':password
        })
    );
    status=response.body.contains('error');
    var data=json.decode(response.body);
    if(status){
      print('error');

    }else{
      _save(data['token']);
    }



  }
  Future getUsers() async{
    final prefs=await SharedPreferences.getInstance();
    const key='token';
    final value=prefs.getString(key) ?? 0;

    var response = await http.get(Uri.parse('https://powerful-anchorage-79990.herokuapp.com/api/users'),
      headers: {"Content-Type": "application/json","Authorization":"$value"},


    );
    return print(json.decode(response.body));




  }
  Future<TicketClient> getTicket( String poste) async{
    final prefs=await SharedPreferences.getInstance();
    const key='token';
    final value=prefs.getString(key) ?? 0;
    var response = await http.post(Uri.parse('https://powerful-anchorage-79990.herokuapp.com/api/tickets'),
      headers: <String,String> {"Content-Type": "application/json","Authorization":"$value"},
        body: jsonEncode(<String,String>{
        'postName':'$poste'
      })


    );
    if(response.statusCode==200){

      return TicketClient.fromJson(json.decode(response.body));


    }else{
      statusTicket=true;
      var data=json.decode(response.body);
      raw=data['error'];

      throw Exception("cant get nothing ${raw}");
    }




  }




}