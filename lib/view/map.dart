import 'dart:async';





import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';

import '../services/location.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';





class Wwe extends StatefulWidget{

  _WweState createState() => _WweState();

  
}



class _WweState extends State<Wwe> {


  String googleAPiKey = "AIzaSyA6kxssGdfyG_1ncqQuefJNNnEA6s7VPMc";
  Map<PolylineId, Polyline> polylines= {};

   PolylinePoints   polylinePoints=PolylinePoints();
  late StreamSubscription<Position> serviceStatusStream;





  Completer<GoogleMapController> _mapControl=new Completer();
 CameraPosition _initialCamera=CameraPosition(target: LatLng(37.26307,10.05672),
 zoom: 10.56789);
 List<LatLng> places=[LatLng(37.26307,10.05672)];

  LatLng? position1;




 Set<Marker> myMarker={
   Marker(markerId: MarkerId("1"),position: LatLng(36.80686,10.08599),infoWindow: InfoWindow(title: "Poste Manouba 1"),
     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)
   ),
   Marker(markerId: MarkerId("2"),position: LatLng(36.73526,10.20280),infoWindow: InfoWindow(title: "Poste BenArous 1"),
 icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
   Marker(markerId: MarkerId("3"),position: LatLng(36.83397,10.09520),infoWindow: InfoWindow(title: "Poste Ariana 1"),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
   Marker(markerId: MarkerId("4"),position: LatLng(36.81758,10.08427),infoWindow: InfoWindow(title: "Poste Manouba 2"),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
   Marker(markerId: MarkerId("5"),position: LatLng(37.03809,9.66938),infoWindow: InfoWindow(title: "Poste Mateur 1"),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
   Marker(markerId: MarkerId("6"),position: LatLng(37.03889,9.66474),infoWindow: InfoWindow(title: "Poste Mateur 2"),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),

 };



  Future<void> _getMyLocation()async {
    LocationData myLocation= await LocationService().perLocation();

      await _animateCamera(myLocation);
















      setState(() {

      });





  }
   Future<void>_animateCamera(LocationData loc)async{
    final GoogleMapController controller=await _mapControl.future;

     _initialCamera=  CameraPosition(
       target: LatLng(loc.latitude!,loc.longitude! ),
       zoom: 10.9876,
     );
      myMarker.add(Marker(markerId: MarkerId("mylocation"),position:LatLng(loc.latitude!,loc.longitude!)));
      position1=LatLng(loc.latitude!,loc.longitude!);



      controller.animateCamera(CameraUpdate.newCameraPosition(_initialCamera));
   }
   Future<void> _shortDistance(Position p)async{


     var short=places[1];
     var min=Geolocator.distanceBetween(places[1].latitude,places[1].longitude , p.latitude, p.longitude);

    for(var i=2;i<places.length;i++){




      var distanceBetweenPoints= Geolocator.distanceBetween(places[i].latitude,places[i].longitude , p.latitude, p.longitude);

       if(distanceBetweenPoints<min){
         min=distanceBetweenPoints;



           short=places[i];
        print(short);

       }



     }



     _getPolyline(p,short);
















   }




   void initState(){
    _getMyLocation();
   myMarker.forEach((element) {
     places.add(element.position);
   });










   super.initState();
  }
  Widget build(BuildContext context) {
      return Scaffold(

         body:
         GoogleMap(

           initialCameraPosition: _initialCamera ,
           mapType:MapType.normal ,
           onMapCreated: (GoogleMapController controller){
             _mapControl.complete(controller);

           },
           markers: myMarker,
           polylines:Set<Polyline>.of(polylines.values),







         ),
          floatingActionButton:Row(

            mainAxisAlignment: MainAxisAlignment.end,
            children:

            [FloatingActionButton.extended(onPressed: ()=> _livePosition()

            ,
                label:Text("Short Distance") ),
              SizedBox(width:50)
              ,FloatingActionButton(mini: true,onPressed: ()=> _getMyLocation(),
                  child:Icon(Icons.gps_fixed),backgroundColor: Colors.grey, ),



            ]
            ,)




















      );




  }

  _getPolyline(Position v , LatLng to) async {
    List<LatLng> polylineCoordinates=[];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(v.latitude,v.longitude),
        PointLatLng(to.latitude,to.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "")]);

    // result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(v.latitude, v.longitude));
    polylineCoordinates.add(LatLng(to.latitude, to.longitude));


     // });

    _addPolyLine(polylineCoordinates);
  }
  _addPolyLine(  List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id]= polyline ;
    setState(() {});
  }
  void _livePosition(){
    serviceStatusStream=Geolocator.getPositionStream().listen((Position position){
      _shortDistance(position);
      _update( position.latitude, position.longitude);


    }
    ) ;



  }
  _update( from, to){
    myMarker.remove(Marker(markerId: MarkerId("mylocation")));
    myMarker.add(Marker(markerId: MarkerId("mylocation"),position: LatLng(from,to)));
    setState(() {

    });


  }




  }















