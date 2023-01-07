

import 'package:flutter/material.dart';

import 'package:untitled2/view/dashboard.dart';
import 'package:untitled2/view/map.dart';
import 'package:untitled2/view/ticket.dart';


class Dashboard2 extends StatefulWidget{

  Dashboard2_State  createState()=>Dashboard2_State();
}

class Dashboard2_State extends State<Dashboard2> {
  int currentIndex=0;
  final screens=[

    Ticket(),
    Dashboard(),
    Wwe(),


  ];






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index)=>{
          setState(()=>
            currentIndex=index
          )
        },
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket_outlined),
            label: 'Ticket',

          ),
          BottomNavigationBarItem(icon: Icon(Icons.home),
              label: 'Poste',

          ),
          BottomNavigationBarItem(icon: Icon(Icons.map),
              label: 'Map',

          ),
         // BottomNavigationBarItem(icon: Icon(Icons.person),
            //  label: 'Profile',

         // ),



        ],
      ),





    );
  }

}