import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crib4uinspect/compliance.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/edit.dart';
import 'package:crib4uinspect/inspection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class report extends StatefulWidget {

 

  const report({super.key});

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  List<bool> _isExpandedList = [false, false, false, false, false, false];

  final List<String> items = [
    'Shared with User',
  ];
  final List<String> item1 = [
    'Shared with Tenant',
  ];
  final List<String> item2 = [
    'Rent review',
  ];
  final List<String> item3 = [
    'General Notes',
  ];
  final List<String> item4 = [
    'Follow Up Actions',
  ];
  final List<String> itemU = [
    'Compliance/Utilities',
  ];
  final List<String> item5 = [
    'Kitchen',
  ];
  final List<String> item6 = [
    'Dining Room',
  ];
  final List<String> item7 = [
    'Lounge Room',
  ];
  final List<String> item8 = [
    'Laundry',
  ];
  final List<String> item9 = [
    'Bedroom 2',
  ];
  final List<String> item10 = [
    'Bedroom 1',
  ];

copy() async {
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
    print(Body);

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
      print(responseData);
    } else {
      print('API request failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //! report back button functionality
          toolbarHeight: 80.0,
          backgroundColor: Color.fromRGBO(162, 154, 255, 1),
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => inspect(),
                ),
              );
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Report",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 37.0,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                copy(); //! here copy called
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.create),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => edit(),
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(4),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = items[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.sidebar_left,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item1[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item1[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.sidebar_left,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item2[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item2[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: item3.length,
                  itemBuilder: (context, index) {
                    return ExpansionPanelList(
                      expandedHeaderPadding: EdgeInsets.zero,
                      elevation: 1,
                      dividerColor: Colors.blue,
                      expansionCallback: (int panelIndex, bool isExpanded) {
                        setState(() {
                          _isExpandedList[index] = !isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              //leading: Icon(Icons.list),
                              title: Text(
                                item3[index],
                                style: TextStyle(fontSize: 18.0),
                              ),
                            );
                          },
                          body: ListTile(
                            title: TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'Comment',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          isExpanded: _isExpandedList[index],
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item4[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item4[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = itemU[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          itemU[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => compliance(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 381,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Areas',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item5[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item5[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => areas(
                                title: 'Kitchen',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item6[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item6[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => areas(
                                title: 'Dining Room',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item7[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item7[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => areas(
                                title: 'Lounge',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item8[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item8[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => areas(
                                title: 'laundry',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item9[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item9[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => areas(
                                title: 'Bedroom 2',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item10[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          item10[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => areas(
                                title: 'Bedroom 1',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
        ));
  }
}
