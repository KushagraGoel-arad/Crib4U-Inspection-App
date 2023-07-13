import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crib4uinspect/inspection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  var email = "";
  var password = "";
  // var abc = "";

  main() async {
    final Headers = {'Content-Type': 'application/json','authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='};
    final Body = {
      "email": "$email",
      "password": "$password",
      "googleData": null
    };
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
      final userID = responseData['userID'];
      final role = responseData['role'];

      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('userID', userID);
      await prefs.setString('role', role);

      print(responseData);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => inspect(),
      //   ),
      // );
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
    return Scaffold(
      body: Container(
        child: Column(children: [
          SizedBox(
            height: 150,
          ),
          Text(
            "Crib4U",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(162, 154, 255, 1),
                fontSize: 80),
          ),
          SizedBox(height: 130),
          Center(
            child: Container(
              width: 316,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(162, 154, 255, 1),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(162, 154, 255, 1),
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Username',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 30),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(162, 154, 255, 1),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(162, 154, 255, 1),
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 90),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        backgroundColor: Color.fromRGBO(162, 154, 255, 1),
                      ),
                      onPressed: (() {
                        main();
                      }),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
