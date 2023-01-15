import 'dart:convert';
// import 'dart:html';
import 'package:aqi_flutter/screens/aqi_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:climate_condition/services/location.dart';
import 'package:aqi_flutter/location.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading_Screen_State extends StatefulWidget {
  const Loading_Screen_State({Key? key}) : super(key: key);

  @override
  State<Loading_Screen_State> createState() => _Loading_Screen_StateState();
}

class _Loading_Screen_StateState extends State<Loading_Screen_State> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    getlocation();
    getdata();
    print('started');
  }

  void getlocation() async {
    Location location = Location();
    await location.getlocation();

    longitude = location.longitude;
    latitude = location.latitude;
    print(latitude);
    print(longitude);

    // await getdata();
    getdata();
  }

  void getdata() async {
    String apiKey = 'bb3cb61ef8c6a2e4bbadef80bcbf22eb';

    https.Response responseaqi = await https.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    https.Response responseweather = await https.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));
    if (responseaqi.statusCode == 200 && responseweather.statusCode == 200) {
      String data = responseaqi.body;
      String dataweather = responseweather.body;
//       var temp = jsonDecode(dataweather)['main']['temp'];
//       var aqi = jsonDecode(data)['list'][0]['main']['aqi'];
//       var n02 = jsonDecode(data)['list'][0]['components']['no2'];
//       var preci = jsonDecode(dataweather)['main']['humidity'];
//       var pm2 = jsonDecode(data)['list'][0]['components']['pm2_5'];
// //list[0].components.pm2_5
//       //list[0].components.pm2_5
//       print(temp);
//       print(aqi);
//       print(n02);
//       print(preci);
//       print(pm2);
//       print(dataweather);

      var weatherdata = jsonDecode(dataweather);
      var aqidata = jsonDecode(data);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Aqi_screen(
          locationweather: weatherdata,
          locationaqi: aqidata,
        );
      }));
    } else {
      print(responseweather.statusCode);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
