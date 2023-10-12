// import 'dart:convert';
// import 'package:crib4uinspect/tokens/token.dart';
// import 'package:http/http.dart' as http;
// import 'package:crib4uinspect/inspection.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:universal_html/html.dart' as html;
// import 'package:cookie_jar/cookie_jar.dart';

// class login_page extends StatefulWidget {
//   const login_page({Key? key}) : super(key: key);

//   @override
//   State<login_page> createState() => _login_pageState();
// }

// class _login_pageState extends State<login_page> {
//   var email = "";
//   var password = "";
//   // var abc = "";
//   final cookieJar = CookieJar();
//   String? accessToken; // Declare accessToken variable
//   String? refreshToken;
//   main() async {
//     final client = http.Client();
//     client.cookieJar = cookieJar;
//     final Headers = {
//       'Content-Type': 'application/json',
//       'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
//     };
//     final Body = jsonEncode(
//         {"email": "$email", "password": "$password", "googleData": null});
//     print(Body);

//     final response = await http.post(
//         Uri.parse(
//             'https://crib4u.axiomprotect.com:9497/api/auth_gateway/login'),
//         body: Body,
//         headers: Headers);

//     //http.StreamedResponse response = await request.send();
//     print(response);
//     if (response.statusCode == 200 && response.statusCode < 300) {
//       Map<String, dynamic> responseBodyJson = jsonDecode(response.body);
//       //String? resultMessage = responseBodyJson['detail'];
//       final responseData = responseBodyJson['data'];
//       //print(html.window.navigator.cookieEnabled);
//       final cookies1 = response.headers['Set-Cookie'];
//       print("Get Cookies:$cookies1");
//       final cookies = response.headers['Set-Cookie']?.split(';');
//       if (cookies != null) {
//         for (var cookie in cookies) {
//           if (cookie.contains('accessToken')) {
//             accessToken = cookie.split('=').last;
//             print("accessToken: $accessToken");
//           } else if (cookie.contains('refreshToken')) {
//             refreshToken = cookie.split('=').last;
//           }
//         }
//       }

//       TokenStorage.accessToken = accessToken;
//       TokenStorage.refreshToken = refreshToken;
//       // print(accessToken);
//       // print(refreshToken);
//       //
//       // if (resultMessage != null) {
//       //   print('Result Message: $resultMessage');
//       // } else {
//       //   print('Result Message is null.');
//       // }

//       // if (responseBodyJson['resultCode'] == 1) {

//       // } else {}
//       print(responseData);

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => inspect(
//             accessToken: TokenStorage.accessToken,
//             refreshToken: TokenStorage.refreshToken,
//           ),
//         ),
//       );
//       //abc = await response.stream.bytesToString();
//       //   if (abc == 'true') {
//       //     Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //         builder: (context) => inspect(),
//       //       ),
//       //     );
//       //   // } else {
//       //   //   print('Username or Password is not correct');
//       //   // }
//     } else {
//       print('API request failed with status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(children: [
//           SizedBox(
//             height: 150,
//           ),
//           Text(
//             "Crib4U",
//             style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 color: Color.fromRGBO(162, 154, 255, 1),
//                 fontSize: 80),
//           ),
//           SizedBox(height: 130),
//           Center(
//             child: Container(
//               width: 316,
//               child: Column(
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(162, 154, 255, 1),
//                           width: 2.0,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(162, 154, 255, 1),
//                           width: 2.0,
//                         ),
//                       ),
//                       hintText: 'Username',
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 12.0, horizontal: 16.0),
//                     ),
//                     onChanged: (value) {
//                       email = value;
//                     },
//                   ),
//                   SizedBox(height: 30),
//                   TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(162, 154, 255, 1),
//                           width: 2.0,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(162, 154, 255, 1),
//                           width: 2.0,
//                         ),
//                       ),
//                       hintText: 'Password',
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 12.0, horizontal: 16.0),
//                     ),
//                     onChanged: (value) {
//                       password = value;
//                     },
//                   ),
//                   SizedBox(height: 90),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(12))),
//                         backgroundColor: Color.fromRGBO(162, 154, 255, 1),
//                       ),
//                       onPressed: (() {
//                         main();
//                       }),
//                       child: Text(
//                         "Login",
//                         style: TextStyle(
//                             fontSize: 25, fontWeight: FontWeight.w500),
//                       )),
//                 ],
//               ),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:http/browser_client.dart';

// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:crib4uinspect/inspection.dart';
// // import 'package:crib4uinspect/tokens/token.dart';
// // import 'package:http/browser_client.dart';

// // class login_page extends StatefulWidget {
// //   const login_page({Key? key}) : super(key: key);

// //   @override
// //   State<login_page> createState() => _login_pageState();
// // }

// // class _login_pageState extends State<login_page> {
// //   var email = "";
// //   var password = "";
// //   String? accessToken; // Declare accessToken variable
// //   String? refreshToken;

// //   Future<void> main() async {
// //     // Create a browser HTTP client (Use http.BrowserClient)
// //     //final client = http.BrowserClient();

// //     final Headers = {
// //       'Content-Type': 'application/json',
// //       'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
// //     };
// //     final Body = jsonEncode(
// //         {"email": "$email", "password": "$password", "googleData": null});
// //     print(Body);

// //     final response = await client.post( // Use the client for making requests
// //         Uri.parse(
// //             'https://crib4u.axiomprotect.com:9497/api/auth_gateway/login'),
// //         body: Body,
// //         headers: Headers);

// //     print(response);
// //     if (response.statusCode == 200 && response.statusCode < 300) {
// //       Map<String, dynamic> responseBodyJson = jsonDecode(response.body);
// //       final responseData = responseBodyJson['data'];

// //       final cookies = response.headers['set-cookie']?.split(';');
// //       if (cookies != null) {
// //         for (var cookie in cookies) {
// //           if (cookie.contains('accessToken')) {
// //             accessToken = cookie.split('=').last;
// //             print("accessToken: $accessToken");
// //           } else if (cookie.contains('refreshToken')) {
// //             refreshToken = cookie.split('=').last;
// //           }
// //         }
// //       }
// //       TokenStorage.accessToken = accessToken;
// //       TokenStorage.refreshToken = refreshToken;

// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => inspect(
// //             accessToken: TokenStorage.accessToken,
// //             refreshToken: TokenStorage.refreshToken,
// //           ),
// //         ),
// //       );
// //     } else {
// //       print('API request failed with status code: ${response.statusCode}');
// //       print('Response body: ${response.body}');
// //     }

// //     // Close the client when done
// //     client.close();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         child: Column(children: [
// //           SizedBox(
// //             height: 150,
// //           ),
// //           Text(
// //             "Crib4U",
// //             style: TextStyle(
// //               fontWeight: FontWeight.w700,
// //               color: Color.fromRGBO(162, 154, 255, 1),
// //               fontSize: 80,
// //             ),
// //           ),
// //           SizedBox(height: 130),
// //           Center(
// //             child: Container(
// //               width: 316,
// //               child: Column(
// //                 children: [
// //                   TextField(
// //                     decoration: InputDecoration(
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(8.0),
// //                         borderSide: BorderSide(
// //                           color: Color.fromRGBO(162, 154, 255, 1),
// //                           width: 2.0,
// //                         ),
// //                       ),
// //                       focusedBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(8.0),
// //                         borderSide: BorderSide(
// //                           color: Color.fromRGBO(162, 154, 255, 1),
// //                           width: 2.0,
// //                         ),
// //                       ),
// //                       hintText: 'Username',
// //                       contentPadding: EdgeInsets.symmetric(
// //                         vertical: 12.0,
// //                         horizontal: 16.0,
// //                       ),
// //                     ),
// //                     onChanged: (value) {
// //                       email = value;
// //                     },
// //                   ),
// //                   SizedBox(height: 30),
// //                   TextField(
// //                     obscureText: true,
// //                     decoration: InputDecoration(
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(8.0),
// //                         borderSide: BorderSide(
// //                           color: Color.fromRGBO(162, 154, 255, 1),
// //                           width: 2.0,
// //                         ),
// //                       ),
// //                       focusedBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(8.0),
// //                         borderSide: BorderSide(
// //                           color: Color.fromRGBO(162, 154, 255, 1),
// //                           width: 2.0,
// //                         ),
// //                       ),
// //                       hintText: 'Password',
// //                       contentPadding: EdgeInsets.symmetric(
// //                         vertical: 12.0,
// //                         horizontal: 16.0,
// //                       ),
// //                     ),
// //                     onChanged: (value) {
// //                       password = value;
// //                     },
// //                   ),
// //                   SizedBox(height: 90),
// //                   ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.all(
// //                           Radius.circular(12),
// //                         ),
// //                       ),
// //                       backgroundColor: Color.fromRGBO(162, 154, 255, 1),
// //                     ),
// //                     onPressed: () {
// //                       main();
// //                     },
// //                     child: Text(
// //                       "Login",
// //                       style: TextStyle(
// //                         fontSize: 25,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ]),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:crib4uinspect/inspection.dart';
// import 'package:crib4uinspect/tokens/token.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:cookie_jar/cookie_jar.dart';

// class login_page extends StatefulWidget {
//   const login_page({Key? key}) : super(key: key);

//   @override
//   State<login_page> createState() => _login_pageState();
// }

// class _login_pageState extends State<login_page> {
//   var email = "";
//   var password = "";
//   String? accessToken; // Declare accessToken variable
//   String? refreshToken;
//   late CookieJar cookieJar; // Declare the CookieJar

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the CookieJar
//     cookieJar = CookieJar();
//   }

//   Future<void> main() async {
//     final client = http.Client();
//     client.cookieJar = cookieJar; // Set the client's cookieJar

//     final Headers = {
//       'Content-Type': 'application/json',
//       'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
//     };
//     final Body = jsonEncode(
//         {"email": "$email", "password": "$password", "googleData": null});
//     print(Body);

//     final response = await client.post(
//         Uri.parse('https://crib4u.axiomprotect.com:9497/api/auth_gateway/login'),
//         body: Body,
//         headers: Headers);

//     print(response);
//     if (response.statusCode == 200 && response.statusCode < 300) {
//       Map<String, dynamic> responseBodyJson = jsonDecode(response.body);
//       final responseData = responseBodyJson['data'];

//       // Retrieve cookies from the cookieJar
//       final cookies = cookieJar.loadForRequest(response.request!.url);
//       for (var cookie in cookies) {
//         if (cookie.name == 'accessToken') {
//           accessToken = cookie.value;
//           print("accessToken: $accessToken");
//         } else if (cookie.name == 'refreshToken') {
//           refreshToken = cookie.value;
//         }
//       }

//       TokenStorage.accessToken = accessToken;
//       TokenStorage.refreshToken = refreshToken;

//       print(responseData);

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => inspect(
//             accessToken: TokenStorage.accessToken,
//             refreshToken: TokenStorage.refreshToken,
//           ),
//         ),
//       );
//     } else {
//       print('API request failed with status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }

//     // Close the client when done
//     client.close();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(children: [
//           SizedBox(
//             height: 150,
//           ),
//           Text(
//             "Crib4U",
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               color: Color.fromRGBO(162, 154, 255, 1),
//               fontSize: 80,
//             ),
//           ),
//           SizedBox(height: 130),
//           Center(
//             child: Container(
//               width: 316,
//               child: Column(
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(162, 154, 255, 1),
//                           width: 2.0,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(162, 154, 255, 1),
//                           width: 2.0,
//                         ),
//                       ),
//                       hintText: 'Username',
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 12.0,
//                         horizontal: 16.0,
//                       ),
//                     ),
//                     onChanged: (value) {
//                       email = value;
//                     },
//                   ),
//                   SizedBox(height: 30),
//                   TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(162, 154, 255, 1),
//                           width: 2.0,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(162, 154, 255, 1),
//                           width: 2.0,
//                         ),
//                       ),
//                       hintText: 'Password',
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 12.0,
//                         horizontal: 16.0,
//                       ),
//                     ),
//                     onChanged: (value) {
//                       password = value;
//                     },
//                   ),
//                   SizedBox(height: 90),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(12),
//                         ),
//                       ),
//                       backgroundColor: Color.fromRGBO(162, 154, 255, 1),
//                     ),
//                     onPressed: () {
//                       main();
//                     },
//                     child: Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

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
  final apiClient = RestApiClient(
    options:
        RestApiClientOptions(baseUrl: 'https://crib4u.axiomprotect.com:9497'),
  );
  final dio = Dio();
  void setCookie(String name, String value, int days) {
    final expires = DateTime.now().add(Duration(days: days));
    final formattedExpires = expires.toUtc().toIso8601String();
    final cookie = '$name=$value; expires=$formattedExpires; path=/';
    html.document.cookie = cookie;
  }

  Future<void> main() async {
    final Headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
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

      // Access accessToken and refreshToken from the response
      var accessToken = responseData['accessToken'];
      var refreshToken = responseData['refreshToken'];

      setCookie('accessToken', accessToken, 2);
setCookie('refreshToken', refreshToken, 2);
      // Set the accessToken and refreshToken in TokenStorage
      TokenStorage.accessToken = accessToken;
      TokenStorage.refreshToken = refreshToken;

      print('accessToken: $accessToken');
      print('refreshToken: $refreshToken');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => inspect(
            accessToken: TokenStorage.accessToken,
            refreshToken: TokenStorage.refreshToken,
          ),
        ),
      );
    } else {
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
