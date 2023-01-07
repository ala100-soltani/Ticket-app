

import 'package:location/location.dart';




class LocationService{
  Future<LocationData> perLocation() async {
    Location location=new Location();
    bool _serviceEnabled;
    PermissionStatus  _permissionGranted;
    LocationData _LocationData;

    _permissionGranted=await location.hasPermission();
    if(_permissionGranted== PermissionStatus.denied){
      _permissionGranted=await location.requestPermission();

      if(_permissionGranted== PermissionStatus.granted){

      }

    }
    _serviceEnabled=await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled=await location.requestService();

    }
    if(!_serviceEnabled){
      throw Exception();
    }
    _LocationData=await location.getLocation();

    return _LocationData;





  }


}