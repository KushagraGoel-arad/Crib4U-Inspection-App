import 'package:crib4uinspect/areas_notes.dart';
import 'package:crib4uinspect/areas_photos.dart';
import 'package:crib4uinspect/basic_details.dart';
import 'package:crib4uinspect/compliance.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/inspection.dart';
import 'package:crib4uinspect/login.dart';
import 'package:crib4uinspect/report.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_client/rest_api_client.dart';

void main() {
  runApp(const MyApp());
}

final apiClient = RestApiClient(
    options:
        RestApiClientOptions(baseUrl: 'https://crib4u.axiomprotect.com:9497'));

// final loginEndpoint = RestApiEndpoint(
//   method: HttpMethod.post,
//   path: '/api/auth_gateway/login',
//   headers: {
//     'Content-Type': 'application/json',
//     'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw==',
//   },
// );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_page(),
      title: 'Crib4U',
    );
  }
}
