//! less data preview in user interface

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class ScheduleData extends StatefulWidget {
//   final String? accessToken;

//   const ScheduleData({Key? key, this.accessToken}) : super(key: key);

//   @override
//   State<ScheduleData> createState() => _ScheduleDataState();
// }

// class _ScheduleDataState extends State<ScheduleData> {
//   List<dynamic> scheduleData = [];

//   @override
//   void initState() {
//     super.initState();
//     ScheduleCalling();
//   }

//   Future<void> ScheduleCalling() async {
//     final headers = {
//       'Content-Type': 'application/json',
//       'accessToken': widget.accessToken ?? '',
//     };

//     var response = await http.get(
//       Uri.https(
//         'crib4u.axiomprotect.com:9497',
//         '/api/prop_gateway/inspect/list/schedule',
//       ),
//       headers: headers,
//     );

//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);
//       setState(() {
//         scheduleData = jsonData['details'] as List<dynamic>;
//       });
//     } else {
//       print("Failed to fetch data. Status Code: ${response.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scheduled Inspections'),
//       ),
//       body: ListView.builder(
//         itemCount: scheduleData.length,
//         itemBuilder: (context, index) {
//           var item = scheduleData[index];
//           return ListTile(
//             title: Text(item['summary']),
//             subtitle: Text('${item['property']['property_basic_details']['address']['line_one']} ${item['property']['property_basic_details']['address']['line_two']}'),
//             trailing: Text(item['type']),
//             onTap: () {
//               // Additional actions when a list item is tapped
//             },
//           );
//         },
//       ),
//     );
//   }
// }

//! more data preview in user interface  code

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ScheduleData extends StatefulWidget {
  final String? accessToken;

  const ScheduleData({Key? key, this.accessToken}) : super(key: key);

  @override
  State<ScheduleData> createState() => _ScheduleDataState();
}

class _ScheduleDataState extends State<ScheduleData> {
  List<Map<String, dynamic>> scheduleData = [];
  bool isLoading = true; // Indicates if data is still being loaded

  @override
  void initState() {
    super.initState();
    scheduleCalling(); // Call the API
  }

  Future<void> scheduleCalling() async {
    setState(() {
      isLoading = true; // Data is loading
    });

    final headers = {
      'Content-Type': 'application/json',
      'accessToken': widget.accessToken ?? '', // Use actual access token
    };

    try {
      var response = await http.get(
        Uri.https(
          'crib4u.axiomprotect.com:9497',
          '/api/prop_gateway/inspect/list/schedule',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['resultCode'] == 1) {
          setState(() {
            scheduleData = List<Map<String, dynamic>>.from(jsonData['details']);
            isLoading = false; // Data loading is done
          });
        } else {
          print("Failed to fetch data.");
        }
      } else {
        print("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setState(() {
        isLoading = false; // Ensure loading indicator is hidden
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: scheduleData.length,
              itemBuilder: (context, index) {
                var item = scheduleData[index];
                var property =
                    item['property']['property_basic_details']['address'];
                var manager = item['manager']['name'];
                var tenant = item['tenant']['users'][0]['name'];
                var owner = item['owner']['users'][0]['name'];

                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['summary'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Type: ${item['type']}'),
                        Text(
                            'Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(item['date']))}'),
                        Text('Time: ${item['startTime']} - ${item['endTime']}'),
                        Text('Duration: ${item['duration']} minutes'),
                        Text(
                            'Property: ${property['line_one']} ${property['line_two']}'),
                        Text(
                            'Manager: ${manager['firstName']} ${manager['lastName']}'),
                        Text(
                            'Tenant: ${tenant['firstName']} ${tenant['lastName']}'),
                        Text(
                            'Owner: ${owner['firstName']} ${owner['lastName']}'),
                        Text('Status: ${item['status']}'),
                        // Add more fields as required
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
