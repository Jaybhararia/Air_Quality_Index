// import 'dart:ffi';
import 'dart:core';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:core';

const newstyle = TextStyle(
  fontFamily: 'Short',
  fontWeight: FontWeight.w900,
  fontSize: 50,
);

const bottomstyle = TextStyle(
  fontFamily: 'Short',
  fontWeight: FontWeight.bold,
  fontSize: 25,
  color: Colors.black,
);

const bottomstylenumber = TextStyle(
  fontFamily: 'Short',
  fontWeight: FontWeight.bold,
  fontSize: 50,
  color: Colors.black,
);

const bottomunit = TextStyle(
  fontFamily: 'Short',
  fontWeight: FontWeight.w300,
  fontSize: 15,
  color: Colors.black,
);

class Aqi_screen extends StatefulWidget {
  final locationweather;
  final locationaqi;

  Aqi_screen({required this.locationweather, required this.locationaqi});

  @override
  State<Aqi_screen> createState() => _Aqi_screenState();
}

class _Aqi_screenState extends State<Aqi_screen> {
  var temp;
  var humidity;
  var aqi;
  var no2;
  var pm2_5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.locationweather);
    print(widget.locationaqi);

    updateUI(widget.locationweather, widget.locationaqi);
  }

  void updateUI(dynamic weatherdata, dynamic aqidata) {
    temp = (weatherdata['main']['temp']);
    aqi = aqidata['list'][0]['main']['aqi'];
    no2 = aqidata['list'][0]['components']['no2'];
    humidity = weatherdata['main']['humidity'];
    pm2_5 = aqidata['list'][0]['components']['pm2_5'];
    print(temp.toString());
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  //rgba(61,103,178,255)
                  child: CircularPercentIndicator(
                    radius: 150.0,
                    lineWidth: 12.0,
                    percent: aqi * 0.2,
                    // progressColor: Color.fromARGB(255, 166, 208, 87),
                    progressColor: Colors.red,
                    backgroundColor: Color(0xff406fbf),
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animateFromLastPercent: true,
                    center: Text(
                      'Aqi : $aqi',
                      style: newstyle,
                    ),

                    //rgba(166,208,87,255)
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Color.fromARGB(255, 61, 103, 178),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: Colors.blue.shade900,
                          ),
                          Text(
                            '   $humidity',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellow.shade500,
                          ),
                          Text('   $temp°C',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Expanded(
                flex: 4,
                child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'NO\u2082',
                                  style: bottomstyle,
                                ),
                                Text(
                                  'µg/m3',
                                  style: bottomunit,
                                )
                              ],
                            ),
                            Text(
                              '$no2',
                              style: bottomstylenumber,
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: no2 / 140,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'PM 2.5',
                                  style: bottomstyle,
                                ),
                                Text(
                                  'µg/m3',
                                  style: bottomunit,
                                )
                              ],
                            ),
                            Text(
                              '$pm2_5',
                              style: bottomstylenumber,
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: pm2_5 / 400,
                          // semanticsLabel: 'Hello',
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
