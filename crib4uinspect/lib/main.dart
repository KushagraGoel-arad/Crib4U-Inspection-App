import 'package:crib4uinspect/areas_notes.dart';
import 'package:crib4uinspect/areas_photos.dart';
import 'package:crib4uinspect/basic_details.dart';
import 'package:crib4uinspect/compliance.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/inspection.dart';
import 'package:crib4uinspect/login.dart';
import 'package:crib4uinspect/report.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login_page (),
      title: 'Crib4U',
    );
  }
}
