import 'dart:convert';

import 'package:crib4uinspect/basic_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Task {
  final String title;
  final String description;
  final String date;
  final String time;

  Task(
      {required this.title,
      required this.description,
      required this.date,
      required this.time});
}

class inspect extends StatefulWidget {
  const inspect({Key? key}) : super(key: key);

  @override
  State<inspect> createState() => _inspectState();
}

class _inspectState extends State<inspect> {
  List<String> items = ["Active", "Schedule"];
  int current = 0;
  List<Task> tasks = [];
  getUserData() async {
    print('get Inspect list calling');
    var response = await http.get(Uri.https(
        'https://crib4u.axiomprotect.com:9497/api',
        '/prop_gateway/inspect/list/active'));
    print(response.body);
    var jsonData = jsonDecode(response.body) ;

    List<Map<String, dynamic>> _tableRows = [];
    print(jsonData);
    if (jsonData > 0) {
      for (int i = 0; i < jsonData.length; i++) {
        dynamic _obj = jsonData[i];

        String propertyName =
            '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
        String tenantName =
            '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
        String managerName =
            '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';

        _tableRows.add({
          '_id': _obj['_id'],
          'inspectionOn':
              '${DateFormat('dd-MM-yyyy').format(_obj['date'])} ${DateFormat('hh:mm a').format(_obj['startTime'])}',
          'type': _obj['type'],
          'summary': _obj['summary'],
          'property': propertyName,
          'manager': managerName,
          'tenant': tenantName,
          'createdAt':
              DateFormat('dd-MMM-yyyy hh:mm a').format(_obj['createdAt']),
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat.yMMMMd().format(dateTime);
    String formattedTime = DateFormat.jm().format(dateTime);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color.fromRGBO(162, 154, 255, 1),
        leading: IconButton(
          icon: Icon(CupertinoIcons.calendar_badge_plus),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Inspection",
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
              // Handle search button press
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                    },
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.all(5),
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(162, 154, 255,
                                  1), // Set purple color for the border
                              width: 2.0, // Set desired border thickness
                            ),
                            color: current == index
                                ? Color.fromRGBO(198, 198, 206, 1)
                                : Colors.white,
                            borderRadius: current == index
                                ? BorderRadius.circular(30)
                                : BorderRadius.circular(25)),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                                color: Color.fromRGBO(162, 154, 255, 1),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: ((context, index) {
                    final task = tasks[index];
                    final previousTask = index > 0 ? tasks[index - 1] : null;
                    final isDateChanged = previousTask?.date != task.date;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isDateChanged)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              task.date.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Card(
                          child: ListTile(
                            leading: Text(
                              task.time,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(task.description),
                            trailing: IconButton(
                              icon: Icon(CupertinoIcons.ellipsis_vertical),
                              onPressed: () {
                                _deleteTask();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => basicDetails(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                )
              ],
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(127, 117, 240, 1),
        splashColor: Color.fromRGBO(162, 154, 255, 1),
        child: Icon(Icons.add),
        onPressed: () {
          _addTask();
        },
      ),
    );
  }

  void _addTask() {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat.yMMMMd().format(dateTime);
    String formattedTime = DateFormat.jm().format(dateTime);
    setState(() {
      tasks.add(Task(
          title: 'Inspection at Beach rd.22 ',
          date: '$formattedDate',
          description: ' Beach rd. 22',
          time: '$formattedTime'));
      current++;
    });
  }

  void _deleteTask() {
    setState(() {
      tasks.remove((task) => task);
    });
  }
}
