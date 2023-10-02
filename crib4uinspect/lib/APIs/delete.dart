import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class delete extends StatefulWidget {
  const delete({super.key});

  @override
  State<delete> createState() => _deleteState();
}

class _deleteState extends State<delete> {

  var email = "";
  var password = "";
  // var abc = "";

  main() async {
    final Headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    final Body = jsonEncode(
        {"email": "$email", "password": "$password", "googleData": null});
    print(Body);

    final response = await http.post(
        Uri.parse(
            'https://crib4u.axiomprotect.com:9497/api/auth_gateway/login'),
        body: Body,
        headers: Headers);

    //http.StreamedResponse response = await request.send();
    print(response);
    if (response.statusCode == 200 && response.statusCode < 300) {
      final responseBodyJson = jsonDecode(response.body);

      final responseData = responseBodyJson['data'];
      // 
      print(responseData);

      
      //abc = await response.stream.bytesToString();
      //   if (abc == 'true') {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => inspect(),
      //       ),
      //     );
      //   // } else {
      //   //   print('Username or Password is not correct');
      //   // }
    } else {
      print('API request failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
