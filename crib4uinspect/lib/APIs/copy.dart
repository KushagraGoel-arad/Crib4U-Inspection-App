import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class copy extends StatefulWidget {
  const copy({super.key});

  @override
  State<copy> createState() => _copyState();
}

class _copyState extends State<copy> {
  main() async {
    final Headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    final Body = jsonEncode({
      "propertyId": {
        "_id": "64928545561b3e18c05a7ae1",
        "property_basic_details": {
          "_id": "64928545561b3e18c05a7adc",
          "reference": "PR2YXHNNB",
          "address": {
            "line_two": "Mosman Park",
            "line_one": "30, Harvey Street",
            "zip_code": "6012"
          }
        }
      },
      "copyReportId": "64a25218af9f3121438639c7"
    });
    //print(Body);

    final response = await http.post(
        Uri.parse(
            'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/copyReport/YOUR_INSPECTION_ID/REPORT_ID'),
        body: Body,
        headers: Headers);

    //http.StreamedResponse response = await request.send();
    print(response);
    if (response.statusCode == 200 && response.statusCode < 300) {
      final responseBodyJson = jsonDecode(response.body);

      final responseData = responseBodyJson['data'];
      //
      //print(responseData);

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
