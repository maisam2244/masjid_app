import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sensors/sensors.dart';

void main() {
  runApp(QiblahCompassApp());
}

class QiblahCompassApp extends StatefulWidget {
  @override
  _QiblahCompassAppState createState() => _QiblahCompassAppState();
}

class _QiblahCompassAppState extends State<QiblahCompassApp> {
  String qiblahDirection = '';
  double azimuth = 0.0;

  Future<void> fetchQiblahDirection() async {
    try {
      var response = await http.get(Uri.parse('https://api.aladhan.com/qibla'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          qiblahDirection = data['data']['direction'].toString();
        });
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQiblahDirection();

    gyroscopeEvents.listen((GyroscopeEvent event) {
      // Use gyroscope data to calculate the azimuth angle
      double rotation = event.z;
      setState(() {
        azimuth = rotation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Qiblah Compass App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Qiblah Direction: $qiblahDirection'),
              SizedBox(height: 20),
              Transform.rotate(
                angle: -azimuth, // Rotate compass image based on azimuth angle
                child: CompassImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompassImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/compass.png',
      height: 200,
      width: 200,
    );
  }
}
