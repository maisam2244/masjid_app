// import 'package:flutter/material.dart';
// import 'package:flutter_qiblah/flutter_qiblah.dart';
// import 'package:masjid_app/Qibla/qibla_compass.dart';

// class Qibla extends StatelessWidget {
//   const Qibla({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Qiblah',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       darkTheme: ThemeData.dark().copyWith(),
//       themeMode: ThemeMode.system,
//       home: Scaffold(
//         body: FutureBuilder(
//           future: FlutterQiblah.androidDeviceSensorSupport(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                 ),
//               );
//             }

//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error.toString()}'),
//               );
//             }
//             if (snapshot.hasData) {
//               return const QiblaCompass();
//             } else {
//               return const Text('Error');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
