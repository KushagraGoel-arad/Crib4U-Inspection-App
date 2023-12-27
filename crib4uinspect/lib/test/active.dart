import 'dart:convert';
import 'package:crib4uinspect/basic_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ActiveScreen extends StatefulWidget {
  final String? accessToken;
  const ActiveScreen({super.key, this.accessToken});

  @override
  State<ActiveScreen> createState() => earlier();
}

class earlier extends State<ActiveScreen> {
  List<Map<String, dynamic>> tableData = [];
  bool isLoading = true; //!
  @override
  void initState() {
    super.initState();
    ActiveCalling();
  }
//! earlier future
  // Future<void> ActiveCalling() async {
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'accessToken': widget.accessToken ?? '', // Use actual access token
  //   };

  //   var response = await http.get(
  //     Uri.https(
  //       'crib4u.axiomprotect.com:9497',
  //       '/api/prop_gateway/inspect/list/active',
  //     ),
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     var jsonData = jsonDecode(response.body);
  //     setState(() {
  //       tableData = List<Map<String, dynamic>>.from(jsonData['details']);
  //     });
  //   } else {
  //     print("Failed to fetch data. Status Code: ${response.statusCode}");
  //   }
  // }

  //! update
  Future<void> ActiveCalling() async {
    final headers = {
      'Content-Type': 'application/json',
      'accessToken': widget.accessToken ?? '', // Use actual access token
    };

    try {
      var response = await http.get(
        Uri.https(
          'crib4u.axiomprotect.com:9497',
          '/api/prop_gateway/inspect/list/active',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        setState(() {
          tableData = List<Map<String, dynamic>>.from(jsonData['details']);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tableData.length,
        itemBuilder: (context, index) {
          var item = tableData[index];
          return GestureDetector(
            onTap: () {
              var selectedItem = tableData[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => basicDetails(
                          type: selectedItem['type'],
                          startTime: selectedItem['startTime'],
                          date: DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(selectedItem['date'])),
                          endTime: selectedItem['endTime'],
                          summary: selectedItem['summary'],
                          property:
                              '${selectedItem['property']['property_basic_details']['address']['line_one']}, ${selectedItem['property']['property_basic_details']['address']['line_two']}',
                          manager:
                              '${selectedItem['manager']['name']['firstName']} ${selectedItem['manager']['name']['lastName']}',
                          tenant:
                              '${selectedItem['tenant']['users'][0]['name']['firstName']} ${selectedItem['tenant']['users'][0]['name']['lastName']}',
                          owner:
                              '${selectedItem['owner']['users'][0]['name']['firstName']} ${selectedItem['owner']['users'][0]['name']['lastName']}',
                          createdAt: selectedItem['createdAt'],
                          status: selectedItem['status'],
                          duration: selectedItem['duration'],
                        )),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(item['summary'] ?? 'No summary'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(item['date']))}'),
                    Text('Type: ${item['type']}'),
                    Text('Duration: ${item['duration']} minutes'),
                    Text('Status: ${item['status']}'),
                    Text(
                        'Property: ${item['property']['property_basic_details']['address']['line_one']}, ${item['property']['property_basic_details']['address']['line_two']}'),
                    // Add more fields as required
                  ],
                ),
                isThreeLine: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
