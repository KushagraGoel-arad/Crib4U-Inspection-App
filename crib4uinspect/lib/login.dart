import 'dart:convert';
import 'package:crib4uinspect/inspection.dart';
import 'package:crib4uinspect/tokens/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_client/implementations/rest_api_client.dart';
import 'package:rest_api_client/options/auth_options.dart';
import 'package:rest_api_client/options/rest_api_client_options.dart';
import 'package:universal_html/html.dart'
    as html; // Import the universal_html package
import 'package:dio/dio.dart';
//import 'package:universal_html/prefer_universal/html.dart' as html;

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  var email = "";
  var password = "";
  String? accessToken; // Declare accessToken variable
  String? refreshToken;
  // final apiClient = RestApiClient(
  //   options:
  //       RestApiClientOptions(baseUrl: 'https://crib4u.axiomprotect.com:9497'),
  // );
  // final dio = Dio();
  // void setCookie(String name, String value, int days) {
  //   final expires = DateTime.now().add(Duration(days: days));
  //   final formattedExpires = expires.toUtc().toIso8601String();
  //   final cookie = '$name=$value; expires=$formattedExpires; path=/';
  //   html.document.cookie = cookie;
  // }

  void storeTokens(String accessToken, String refreshToken) {
    // Store tokens in sessionStorage
    html.window.sessionStorage['accessToken'] = accessToken;
    html.window.sessionStorage['refreshToken'] = refreshToken;
  }

  String? getAccessToken() {
    // Retrieve the access token from sessionStorage
    return html.window.sessionStorage['accessToken'];
  }

  String? getRefreshToken() {
    // Retrieve the refresh token from sessionStorage
    return html.window.sessionStorage['refreshToken'];
  }

  void clearTokens() {
    // Clear tokens from sessionStorage
    html.window.sessionStorage.remove('accessToken');
    html.window.sessionStorage.remove('refreshToken');
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the error dialog
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Login Successful"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> main() async {
    final Headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw==',
      "Access-Control-Allow-Origin": '*'
    };
    final Body = jsonEncode(
        {"email": "$email", "password": "$password", "googleData": null});
    //print(Body);
//http.get(url)
    final response = await http.post(
        Uri.parse(
            'https://crib4u.axiomprotect.com:9497/api/auth_gateway/login'),
        body: Body,
        headers: Headers);

    print(response);
    print("Response Data:");
    //print(response.data);
    //print(response.headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBodyJson = jsonDecode(response.body);
      final responseData = responseBodyJson['detail'];
      final resultMessage = responseBodyJson['detail'];

      if (resultMessage != null) {
        print('Result Message: $resultMessage');
      } else {
        print('Result Message is null.');
      }
      if (responseBodyJson['resultCode'] == 1) {
        // Access accessToken and refreshToken from the response
        var accessToken = responseData['accessToken'];
        var refreshToken = responseData['refreshToken'];
        storeTokens(accessToken, refreshToken);

        // setCookie('accessToken', accessToken, 2);
        // setCookie('refreshToken', refreshToken, 2);
        // // Set the accessToken and refreshToken in TokenStorage
        // TokenStorage.accessToken = accessToken;
        // TokenStorage.refreshToken = refreshToken;

        print('accessToken: $accessToken');
        print('refreshToken: $refreshToken');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                inspect(accessToken: accessToken, refreshToken: refreshToken),
          ),
        );
        showSuccessDialog();
      } else {
        showErrorDialog('Login Success');
      }
    } else {
      showErrorDialog('${response.body}');
      print('API request failed with status code: ${response.statusCode}');
      //print('Response body: ${response.Body}');
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
              fontSize: 80,
            ),
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
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
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
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 90),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      backgroundColor: Color.fromRGBO(162, 154, 255, 1),
                    ),
                    onPressed: () {
                      main();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
