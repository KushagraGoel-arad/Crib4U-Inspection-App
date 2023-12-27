// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class copy extends StatefulWidget {
//   const copy({super.key});

//   @override
//   State<copy> createState() => _copyState();
// }

// class _copyState extends State<copy> {
//   main() async {
//     final Headers = {
//       'Content-Type': 'application/json',
//       'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
//     };
//     final Body = jsonEncode({
//       "propertyId": {
//         "_id": "64928545561b3e18c05a7ae1",
//         "property_basic_details": {
//           "_id": "64928545561b3e18c05a7adc",
//           "reference": "PR2YXHNNB",
//           "address": {
//             "line_two": "Mosman Park",
//             "line_one": "30, Harvey Street",
//             "zip_code": "6012"
//           }
//         }
//       },
//       "copyReportId": "64a25218af9f3121438639c7"
//     });
//     //print(Body);

//     final response = await http.post(
//         Uri.parse(
//             'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/copyReport/YOUR_INSPECTION_ID/REPORT_ID'),
//         body: Body,
//         headers: Headers);

//     //http.StreamedResponse response = await request.send();
//     print(response);
//     if (response.statusCode == 200 && response.statusCode < 300) {
//       final responseBodyJson = jsonDecode(response.body);

//       final responseData = responseBodyJson['data'];
//       //
//       //print(responseData);

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
//     return Container();
//   }
// }

//! changed

import 'dart:convert';
import 'package:crib4uinspect/areas_photos.dart';
import 'package:crib4uinspect/test/addimage.dart';
import 'package:crib4uinspect/test/historyreport.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Copy extends StatefulWidget {
  final String? inspectionid;
  final String? accessToken;

  const Copy({Key? key, this.inspectionid, this.accessToken}) : super(key: key);

  @override
  State<Copy> createState() => _CopyState();
}

class _CopyState extends State<Copy> {
  String? reportIdGlobal;
  String? propertyId;

  //! copy report
  Future<void> copyReport() async {
    final headers = {
      'Content-Type': 'application/json',
      'accessToken': '${widget.accessToken}', // Use accessToken from widget
    };
    final body = jsonEncode({
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
      "copyReportId": "64d376888c796a505c124ae3"
    });

    final response = await http.post(
      Uri.parse(
          'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/copyReport/${widget.inspectionid}/${reportIdGlobal}'),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseBodyJson = jsonDecode(response.body);
      final responseData = responseBodyJson['data'];
      print(responseData); //!
      // Handle your response data here
    } else {
      print('API request failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  //! report id  and other data present in this api
//! https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/getInspectReportDetails/$inspectionId

  Future<void> fetchReportDetails(String inspectionId) async {
    final headers = {
      'Content-Type': 'application/json',
      'accessToken': '${widget.accessToken}', // Use accessToken from widget
    };
    var response = await http.get(
      Uri.https(
        'crib4u.axiomprotect.com:9497',
        '/api/prop_gateway/inspect/getInspectReportDetails/$inspectionId',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print("Data from API: $jsonData");

      // Accessing the _id in ReportDetails
      if (jsonData.containsKey('details') &&
          jsonData['details'].containsKey('ReportDetails')) {
        final reportDetails = jsonData['details']['ReportDetails'];
        reportIdGlobal = reportDetails['_id'];

        propertyId = jsonData['details']['BasicDetails']['property']
            ['property_basic_details']['_id'];

        print("Report ID: $reportIdGlobal");
        print("Property ID: $propertyId");

        // Storing reportId in the global variable
        setState(() {
          reportIdGlobal = reportDetails['_id'];
        });
      }
    } else {
      print("Failed to fetch data. Status Code: ${response.statusCode}");
    }
  }
  //! history report api

  Future<void> historyReportDetails() async {
    final headers = {
      'Content-Type': 'application/json',
      'accessToken': '${widget.accessToken}', // Use accessToken from widget
    };
    var response = await http.get(
      Uri.https(
        'crib4u.axiomprotect.com:9497',
        '/api/prop_gateway/inspect/getReportList/$propertyId',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print("Data from API: $jsonData");
    } else {
      print("Failed to fetch data. Status Code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if (widget.inspectionid != null) {
                fetchReportDetails(widget.inspectionid!);
              } else {
                print("Inspection ID is null");
                // Handle the case when inspectionid is null
              }
            },
            child: Text(
              "report id Button",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              copyReport();
            },
            child: Text(
              "copy report Button",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              historyReportDetails();
            },
            child: Text(
              "History Button",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryReport(
                          accessToken: widget.accessToken,
                          propertyId: propertyId,
                        )),
              );
            },
            child: Text(
              "HISTORY SCREEN Button",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => photos(
                          title: "photo",
                          accessToken: widget.accessToken,
                          reportId: reportIdGlobal,
                          propertyId: propertyId,
                          inspectionid: widget.inspectionid,
                        )),
              );
            },
            child: Text(
              "image upload Button",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Photosview(
                          title: "photo",
                          accessToken: widget.accessToken,
                          reportId: reportIdGlobal,
                          propertyId: propertyId,
                          inspectionid: widget.inspectionid,
                          areaName: "shivank",
                        )),
              );
            },
            child: Text(
              "god Button",
            ),
          ),
        ],
      ),
    );
  }
}
