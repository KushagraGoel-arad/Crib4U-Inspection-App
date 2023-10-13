import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crib4uinspect/inspection.dart';
import 'package:crib4uinspect/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class basicDetails extends StatefulWidget {
  final String? type;
  final String? startTime;
  final String? date;
  final String? endTime;
  final String? summary;
  final String? property;
  final String? manager;
  final String? tenant;
  final String? owner;
  final String? createdAt;
  final String? status;
  final String? duration;
  basicDetails(
      {Key? key,
      this.type,
      this.date,
      this.endTime,
      this.startTime,
      this.summary,
      this.property,
      this.manager,
      this.tenant,
      this.owner,
      this.createdAt,
      this.status,
      this.duration})
      : super(key: key);

  @override
  State<basicDetails> createState() => _basicDetailsState();
}

class _basicDetailsState extends State<basicDetails> {
  final List<String> items = [
    'Inspection Report',
  ];
  final List<String> items1 = [
    'Status Inspected',
  ];
  final List<String> items2 = [
    'Date',
  ];
  final List<String> items3 = [
    'Type',
  ];
  final List<String> items4 = [
    'Start Time',
  ];
  final List<String> items5 = [
    'End Time',
  ];
  final List<String> items6 = [
    'Duration',
  ];
  final List<String> items7 = [
    'Manager',
  ];
  final List<String> items8 = [
    'Labels',
  ];
  final List<String> items9 = [
    'Summary',
  ];
  final List<String> items10 = [
    'Property',
  ];
  final List<String> items11 = [
    'Tenant',
  ];
  final List<String> items12 = ['Owner'];
  @override
  void initState() {
    super.initState();
    print('Date: ${widget.date}');
  }

  // getUserData() async {
  //   var response = await http.get(Uri.https(
  //       'https://crib4u.axiomprotect.com:9497/api',
  //       '/prop_gateway/inspect/getInspectReportDetails/YOUR_INSPECTION_ID'));
  //   var jsonData = jsonDecode(response.body);

  //   List<Map<String, dynamic>> _tableRows = [];

  //   if (jsonData > 0) {
  //     for (int i = 0; i < jsonData.length; i++) {
  //       dynamic _obj = jsonData[i];

  //       String propertyName =
  //           '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
  //       String tenantName =
  //           '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
  //       String managerName =
  //           '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';

  //       _tableRows.add({
  //         '_id': _obj['_id'],
  //         'inspectionOn':
  //             '${DateFormat('dd-MM-yyyy').format(_obj['date'])} ${DateFormat('hh:mm a').format(_obj['startTime'])}',
  //         'type': _obj['type'],
  //         'summary': _obj['summary'],
  //         'property': propertyName,
  //         'manager': managerName,
  //         'tenant': tenantName,
  //         'createdAt':
  //             DateFormat('dd-MMM-yyyy hh:mm a').format(_obj['createdAt']),
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                "Basic Details",
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
              icon: Icon(CupertinoIcons.create),
              onPressed: () {
                //  edit button press
              },
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
              Column(
                children: [
                  Container(
                    height: 200,
                    color: Colors.white,
                    child: Center(
                      child: Image.asset(
                        'images/image 73.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      widget.property ?? '',
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    )
                  ],
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
                    final listItem = items[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items[index],
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
                              builder: (context) => report(),
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
                  itemCount: items1.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = items1[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items1[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.status ?? '',
                        ),
                        trailing: Text(
                          "Change Status",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items2.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = items2[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items2[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.date ?? '',
                        ),
                        trailing: IconButton(
                          icon: Icon(CupertinoIcons.calendar),
                          onPressed: () {
                            //  edit button press
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: items3.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final listItem = items3[index];
                      Color? inkWellColor = Colors.grey[300]; // Default color

                      if (widget.type != null) {
                        if (widget.type == 'Entry') {
                          inkWellColor =
                              Colors.green; // Change color for Entry type
                        } else if (widget.type == 'Exit') {
                          inkWellColor =
                              Colors.red; // Change color for Exit type
                        } else if (widget.type == 'Routine') {
                          inkWellColor =
                              Colors.blue; // Change color for Routine type
                        }
                      }

                      return Card(
                        child: ListTile(
                          title: Text(
                            items3[index],
                            style: TextStyle(fontSize: 18.0),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 30.0,
                                    color: inkWellColor, // Set the color here
                                    child: Center(
                                      child: Text(
                                        'Entry',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 30.0,
                                    color: inkWellColor, // Set the color here
                                    child: Center(
                                      child: Text(
                                        'Exit',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 30.0,
                                    color: inkWellColor, // Set the color here
                                    child: Center(
                                      child: Text(
                                        'Routine',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  )),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items4.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = items4[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items4[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.startTime ?? '',
                        ),
                        trailing: IconButton(
                          icon: Icon(CupertinoIcons.clock),
                          onPressed: () {
                            //  edit button press
                          },
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items5.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = items5[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items5[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.endTime ?? '',
                        ),
                        trailing: IconButton(
                          icon: Icon(CupertinoIcons.clock),
                          onPressed: () {
                            //  edit button press
                          },
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
                    final listItem = items6[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items6[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.duration ?? '',
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
                    final listItem = items7[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items7[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.manager ?? '',
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(
              //   height: 60,
              //   width: double.infinity,
              //   child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: items.length,
              //     scrollDirection: Axis.vertical,
              //     itemBuilder: (context, index) {
              //       final listItem = items8[index];

              //       return Card(
              //         child: ListTile(
              //           title: Text(
              //             items8[index],
              //             style: TextStyle(fontSize: 18.0),
              //           ),
              //           onTap: () {},
              //         ),
              //       );
              //     },
              //   ),
              // ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = items9[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items9[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.summary ?? '',
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
                    final listItem = items10[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items10[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.property ?? '',
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
                    final listItem = items11[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items11[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.tenant ?? '',
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
                    final listItem = items12[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          items12[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          widget.owner ?? '',
                        ),
                        onTap: () {},
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
