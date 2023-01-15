import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as https;

class Location {
  double? latitude;
  double? longitude;

  Future<void> getlocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //nothing
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      // Position position = await Geolocator.getCurrentPosition(
      //     forceAndroidLocationManager: true,
      //     desiredAccuracy: LocationAccuracy.lowest);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Location();
}
