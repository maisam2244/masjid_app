import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masjid_app/ApiServices/Api_model.dart';

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    List prayers = [];
    String url =
        'https://api.aladhan.com/timingsByAddress/09-03-2015?address=Pakistan,Karachi&method=8&tune=2,3,4,5,2,3,4,5,-3';
    Future fetchApi() async {
      final response = await http.Client().get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (Map<String, dynamic> i in data) {
          prayers.add(PrayerTimingsModel.fromJson(i));
        }
      } else {
        return Text("data not found");
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: fetchApi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: prayers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(prayers[index].fajr.toString()));
                        },
                      );
                    } else {
                      return Text("Some");
                    }
                  }))
        ],
      ),
    );
  }
}
