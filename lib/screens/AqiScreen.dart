import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AQI extends StatefulWidget {
  final locationweather;
  final locationaqi;

  AQI({required this.locationweather, required this.locationaqi});

  @override
  State<AQI> createState() => _AQIState();
}

class _AQIState extends State<AQI> {
  Map<double, Color> valueColorMap = {
    1: Colors.green,
    2: Colors.greenAccent,
    3: Colors.orange,
    4: Colors.deepOrange,
    5: Colors.red,
  };

  Color getProgressColor(double value) {
    Color? progressColor;
    for (var key in valueColorMap.keys) {
      if (value == key) {
        progressColor = valueColorMap[key];
        break;
      }
    }
    return progressColor ?? Colors.red;
  }

  var temp;
  var humidity;
  var aqi;
  var no2;
  var pm2_5;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationweather, widget.locationaqi);
  }

  void updateUI(dynamic weatherdata, dynamic aqidata) {
    temp = (weatherdata['main']['temp']);
    aqi = aqidata['list'][0]['main']['aqi'];
    no2 = aqidata['list'][0]['components']['no2'];
    humidity = weatherdata['main']['humidity'];
    pm2_5 = aqidata['list'][0]['components']['pm2_5'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: const Text(
              'Air Quality Index',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
          color: Color.fromARGB(255, 61, 103, 178),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CircularPercentIndicator(
                  radius: 200.0,
                  lineWidth: 20.0,
                  percent: aqi * 0.2,
                  progressColor: getProgressColor(aqi),
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animateFromLastPercent: true,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AQI',
                        style: TextStyle(
                          fontFamily: 'Short',
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$aqi',
                        style: TextStyle(
                          fontFamily: 'Short',
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: Colors.blue.shade900,
                          size: 30,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Humidity',
                          style: TextStyle(
                            fontFamily: 'Short',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '$humidity%',
                          style: TextStyle(
                            fontFamily: 'Short',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.thermostat_outlined,
                          color: Colors.yellow.shade500,
                          size: 30,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Temperature',
                          style: TextStyle(
                            fontFamily: 'Short',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '$temp°C',
                          style: TextStyle(
                            fontFamily: 'Short',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      _buildAQIInfo('NO\u2082', '$no2 µg/m³', no2 / 140),
                      SizedBox(height: 20),
                      _buildAQIInfo('PM 2.5', '$pm2_5 µg/m³', pm2_5 / 400),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAQIInfo(String title, String value, double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Short',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Short',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade300,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ],
    );
  }
}
