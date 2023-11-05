import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masjid_app/Qibla/Qibla.dart';
import 'package:masjid_app/Qibla/qib.dart';

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final String apiUrl =
      'http://api.aladhan.com/timingsByAddress/09-03-2015?address=Pakistan,Karachi&method=8&tune=2,3,4,5,2,3,4,5,-3'; // Changed to HTTP

  Map<String, dynamic>? prayerTimings;

  @override
  void initState() {
    super.initState();
    fetchPrayerTimings();
  }

  Future<void> fetchPrayerTimings() async {
    // Bypass SSL verification. This should only be used for development/testing purposes.
    http.Client client = http.Client();
    http.Response response;

    try {
      response = await client.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          prayerTimings = json.decode(response.body);
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to make the HTTP request: $e');
    } finally {
      client.close(); // Close the HTTP client to release resources.
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Prayer Times App'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QiblahCompassApp()));
              },
            )
          ],
        ),
        body: Center(
          child: prayerTimings != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrayerTimeCard(
                      title: 'Fajr',
                      time: prayerTimings!['data']['timings']['Fajr'],
                    ),
                    PrayerTimeCard(
                      title: 'Dhuhr',
                      time: prayerTimings!['data']['timings']['Dhuhr'],
                    ),
                    PrayerTimeCard(
                      title: 'Asr',
                      time: prayerTimings!['data']['timings']['Asr'],
                    ),
                    PrayerTimeCard(
                      title: 'Maghrib',
                      time: prayerTimings!['data']['timings']['Maghrib'],
                    ),
                    PrayerTimeCard(
                      title: 'Isha',
                      time: prayerTimings!['data']['timings']['Isha'],
                    ),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class PrayerTimeCard extends StatelessWidget {
  final String title;
  final String time;

  PrayerTimeCard({required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              time,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
