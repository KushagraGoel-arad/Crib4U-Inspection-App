// import 'dart:convert';

// import 'package:crib4uinspect/basic_details.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// class Task {
//   final String title;
//   final String description;
//   final String date;
//   final String time;

//   Task(
//       {required this.title,
//       required this.description,
//       required this.date,
//       required this.time});
// }

// class inspect extends StatefulWidget {
//   final String? accessToken;
//   final String? refreshToken;
//   const inspect({Key? key, this.accessToken, this.refreshToken})
//       : super(key: key);

//   @override
//   State<inspect> createState() => _inspectState();
// }

// class _inspectState extends State<inspect> {
//   List<String> items = ["Active", "Schedule"];
//   int current = 0;
//   List<Task> tasks = [];
//   List<Map<String, dynamic>> _tableRows = [];
//   final dio = Dio();
//   Future<void> active() async {
//     // Map<String, String> cookies = {
//     //   'accessToken': '${widget.accessToken}',
//     // };
//     final headers = {
//       'Content-Type': 'application/json',
//       'accessToken': '${widget.accessToken}',
//     };

//     var response = await http.get(
//       Uri.https(
//         'crib4u.axiomprotect.com:9497',
//         '/api/prop_gateway/inspect/list/active',
//       ),
//       headers: headers,
//     );

//     print(response.body);

//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);

//       List<Map<String, dynamic>> _tableRows = [];
//       print(jsonData);
//       List<dynamic> jData = jsonData['details'];
//       if (jData.length > 0) {
//         for (int i = 0; i < jData.length; i++) {
//           dynamic _obj = jData[i];
//           print(" ObjData");
//           print(_obj);

//           String propertyName =
//               '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
//           String tenantName =
//               '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
//           String managerName =
//               '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';

//           DateTime date = DateTime.parse(_obj['date']);
//           DateTime startTime = DateTime.parse(_obj['date']);
//           //print(dateTime);
//           DateTime createAt = DateTime.parse(_obj['createdAt']);

//           _tableRows.add({
//             '_id': _obj['_id'],
//             'inspectionOn':
//                 '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm a').format(startTime)}',
//             'type': _obj['type'],
//             'summary': _obj['summary'],
//             'property': propertyName,
//             'manager': managerName,
//             'tenant': tenantName,
//             'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
//           });
//         }
//       }
//     }
//   }

//   Future<void> detailsOfInspection() async {
//     final headers = {
//       'Content-Type': 'application/json',
//       'accessToken': '${widget.accessToken}', // Use accessToken from widget
//     };
//     var response = await http.get(
//       Uri.https(
//         'crib4u.axiomprotect.com:9497',
//         '/api/prop_gateway/inspect/getInspectReportDetails/YOUR_INSPECTION_ID',
//       ),
//       headers: headers,
//     );

//     print(response.body);

//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);

//       List<Map<String, dynamic>> _tableRows = [];
//       print(jsonData);
//       List<dynamic> jData = jsonData['details'];
//       if (jData.length > 0) {
//         for (int i = 0; i < jData.length; i++) {
//           dynamic _obj = jData[i];

//           String propertyName =
//               '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
//           String tenantName =
//               '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
//           String managerName =
//               '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';
//           DateTime date = DateTime.parse(_obj['date']);
//           DateTime startTime = DateTime.parse(_obj['startTime']);
//           //print(dateTime);
//           DateTime createAt = DateTime.parse(_obj['createdAt']);
//           _tableRows.add({
//             '_id': _obj['_id'],
//             'inspectionOn':
//                 '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm a').format(startTime)}',
//             'type': _obj['type'],
//             'summary': _obj['summary'],
//             'property': propertyName,
//             'manager': managerName,
//             'tenant': tenantName,
//             'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
//           });
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     DateTime dateTime = DateTime.now();
//     String formattedDate = DateFormat.yMMMMd().format(dateTime);
//     String formattedTime = DateFormat.jm().format(dateTime);
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80.0,
//         backgroundColor: Color.fromRGBO(162, 154, 255, 1),
//         leading: IconButton(
//           icon: Icon(CupertinoIcons.calendar_badge_plus),
//           onPressed: () {},
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Inspection",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 37.0,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(CupertinoIcons.create),
//             onPressed: () {
//               // Handle search button press
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         margin: EdgeInsets.all(4),
//         width: double.infinity,
//         height: double.infinity,
//         child: SingleChildScrollView(
//           child: Column(children: [
//             SizedBox(
//               height: 60,
//               width: double.infinity,
//               child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: items.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       active();
//                       setState(() {
//                         current = index;
//                       });
//                     },
//                     child: AnimatedContainer(
//                         duration: Duration(milliseconds: 300),
//                         margin: EdgeInsets.all(5),
//                         width: 80,
//                         height: 45,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Color.fromRGBO(162, 154, 255,
//                                   1), // Set purple color for the border
//                               width: 2.0, // Set desired border thickness
//                             ),
//                             color: current == index
//                                 ? Color.fromRGBO(198, 198, 206, 1)
//                                 : Colors.white,
//                             borderRadius: current == index
//                                 ? BorderRadius.circular(30)
//                                 : BorderRadius.circular(25)),
//                         child: Center(
//                           child: Text(
//                             items[index],
//                             style: TextStyle(
//                                 color: Color.fromRGBO(162, 154, 255, 1),
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         )),
//                   );
//                 },
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemCount: tasks.length,
//                   itemBuilder: ((context, index) {
//                     final task = tasks[index];
//                     final previousTask = index > 0 ? tasks[index - 1] : null;
//                     final isDateChanged = previousTask?.date != task.date;

//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (isDateChanged)
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               task.date.toString(),
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         Card(
//                           child: ListTile(
//                             leading: Text(
//                               task.time,
//                               style: TextStyle(
//                                   fontSize: 13, fontWeight: FontWeight.bold),
//                             ),
//                             title: Text(
//                               task.title,
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             subtitle: Text(task.description),
//                             trailing: IconButton(
//                               icon: Icon(CupertinoIcons.ellipsis_vertical),
//                               onPressed: () {
//                                 detailsOfInspection();
//                                 // _deleteTask();
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => basicDetails(),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//                 )
//               ],
//             ),
//           ]),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color.fromRGBO(127, 117, 240, 1),
//         splashColor: Color.fromRGBO(162, 154, 255, 1),
//         child: Icon(Icons.add),
//         onPressed: () {
//           _addTask();
//         },
//       ),
//     );
//   }

//   void _addTask() {
//     DateTime dateTime = DateTime.now();
//     String formattedDate = DateFormat.yMMMMd().format(dateTime);
//     String formattedTime = DateFormat.jm().format(dateTime);
//     setState(() {
//       tasks.add(Task(
//           title: 'Inspection at Beach rd',
//           date: '$formattedDate',
//           description: ' Beach rd. 22',
//           time: '$formattedTime'));
//       current++;
//     });
//   }

//   // void _addTask() {
//   //   if (_tableRows.isNotEmpty && current < _tableRows.length) {
//   //     final data = _tableRows[current];
//   //     setState(() {
//   //       tasks.add(Task(
//   //         title: data['type'],
//   //         date: data['inspectionOn'],
//   //         description: data['summary'],
//   //         time: data['createdAt'],
//   //       ));
//   //       current++;
//   //     });
//   //   }
//   // }

// //   void _deleteTask() {
// //     setState(() {
// //       tasks.remove((task) => task);
// //     });
// //   }
// }
//! change
import 'dart:convert';
import 'dart:async';
import 'package:crib4uinspect/APIs/copy.dart';
import 'package:crib4uinspect/basic_details.dart';
import 'package:crib4uinspect/basic_details.dart';
import 'package:crib4uinspect/test/active.dart';
import 'package:crib4uinspect/test/mainscreen.dart';
import 'package:crib4uinspect/test/schedule.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:crib4uinspect/basic_details.dart'; //!
import 'package:crib4uinspect/report.dart'; //!
import 'package:crib4uinspect/test/screen.dart'; //!

class Task {
  final String title;
  final String description;
  final String date;
  final String time;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });
}

class inspect extends StatefulWidget {
  final String? accessToken;
  final String? refreshToken;

  const inspect({Key? key, this.accessToken, this.refreshToken})
      : super(key: key);

  @override
  State<inspect> createState() => schedule();
}

class schedule extends State<inspect> {
//! start

  // Timer? _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   _timer = Timer.periodic(Duration(seconds: 120), (Timer t) => callPostApi());
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }

  // Future<void> callPostApi() async {
  //   try {
  //     var url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/auth_gateway/refreshToken'); // Replace with your API endpoint
  //     var response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'refreshToken': widget.refreshToken}),
  //       // Add headers if required
  //     );
  //     // Process your response
  //     print('yes');
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  //! end

  List<String> items = ["Active", "Schedule"];
  int current = 0;
  List<Task> tasks = [];
  List<Map<String, dynamic>> _tableRows =
      []; //! here response of active api is stored

  //final dio = Dio();
//! active get api call
  Future<void> active() async {
    final headers = {
      'Content-Type': 'application/json',
      'accessToken': '${widget.accessToken}',
    };

    var response = await http.get(
      Uri.https(
        'crib4u.axiomprotect.com:9497',
        '/api/prop_gateway/inspect/list/active',
      ),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      _tableRows.clear(); // Clear the previous data

      List<dynamic> jData = jsonData['details'];
      if (jData.isNotEmpty) {
        for (var _obj in jData) {
          var inspectionId = _obj['_id'];
          var property = _obj['property']['property_basic_details']['address'];
          var manager = _obj['manager']['name'];
          var tenant = _obj['tenant']['users'][0]['name'];
          var owner = _obj['owner']['users'][0]['name'];

          var propertyName = '${property['line_one']} ${property['line_two']}';
          var tenantName = '${tenant['firstName']} ${tenant['lastName']}';
          var managerName = '${manager['firstName']} ${manager['lastName']}';
          var ownerName = '${owner['firstName']} ${owner['lastName']}';
          var date = DateTime.parse(_obj['date']);
          var createdAt = DateTime.parse(_obj['createdAt']);

          _tableRows.add({
            '_id': inspectionId,
            'inspectionOn':
                '${DateFormat('dd-MM-yyyy').format(date)} ${_obj['startTime']}',
            'type': _obj['type'],
            'summary': _obj['summary'],
            'property': propertyName,
            'manager': managerName,
            'tenant': tenantName,
            'owner': ownerName,
            'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createdAt),
          });
        }
      }
    }
  }

//! get api of detail of inspection
  Future<void> detailsOfInspection(String inspectionId) async {
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

    print(response.body);

    // if (response.statusCode == 200) {
    //   var jsonData = jsonDecode(response.body);

    //   List<Map<String, dynamic>> _tableRows = [];
    //   print(jsonData);
    //   List<dynamic> jData = jsonData['details'];
    //   if (jData.length > 0) {
    //     for (int i = 0; i < jData.length; i++) {
    //       dynamic _obj = jData[i];

    //       String propertyName =
    //           '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
    //       String tenantName =
    //           '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
    //       String managerName =
    //           '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';
    //       DateTime date = DateTime.parse(_obj['date']);
    //       DateTime startTime = DateTime.parse(_obj['startTime']);
    //       //print(dateTime);
    //       DateTime createAt = DateTime.parse(_obj['createdAt']);
    //       _tableRows.add({
    //         '_id': _obj['_id'],
    //         'inspectionOn':
    //             '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm a').format(startTime)}',
    //         'type': _obj['type'],
    //         'summary': _obj['summary'],
    //         'property': propertyName,
    //         'manager': managerName,
    //         'tenant': tenantName,
    //         'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
    //       });
    //     }
    //   }
    // }
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      if (jsonData['resultCode'] == 1) {
        final basicDetails = jsonData['details']['BasicDetails'];

        final _obj = basicDetails; // Access the BasicDetails object

        String inspectionId = _obj['_id'];

        String propertyName =
            '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
        String tenantName =
            '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
        String managerName =
            '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';
        String ownerName =
            '${_obj['owner']['primaryUserId']['name']['firstName'] ?? ''}';
        DateTime date = DateTime.parse(_obj['date']);
        String startTimeString =
            _obj['startTime']; // Get the startTime as a string
        List<String> timeParts =
            startTimeString.split(':'); // Split it into hours and minutes

        int hours = int.parse(timeParts[0]); // Parse hours as an integer
        int minutes = int.parse(timeParts[1]); // Parse minutes as an integer

        DateTime startTime =
            DateTime(date.year, date.month, date.day, hours, minutes);
        String endTimeString = _obj['endTime']; // Get the startTime as a string
        List<String> timeParts1 =
            startTimeString.split(':'); // Split it into hours and minutes

        int hours1 = int.parse(timeParts[0]); // Parse hours as an integer
        int minutes1 = int.parse(timeParts[1]); // Parse minutes as an integer

        DateTime endTime =
            DateTime(date.year, date.month, date.day, hours, minutes);

        DateTime createAt = DateTime.parse(_obj['createdAt']);

        setState(() {
          _tableRows.clear(); // Clear the previous data

          _tableRows.add({
            '_id': inspectionId,
            'date':
                '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm').format(startTime)}',
            'startTime': '${DateFormat('hh:mm').format(startTime)}',
            'endTime': '${DateFormat('hh:mm').format(endTime)}',
            'type': _obj['type'],
            'summary': _obj['summary'],
            'property': propertyName,
            'manager': managerName,
            'tenant': tenantName,
            'owner': ownerName,
            'status': _obj['status'],
            'duration': _obj['duration'],
            'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
          });
        });
      }
    }
  }

//! code for checking data of tablerows list
  void printTableRows(List<Map<String, dynamic>> tableRows) {
    print("called printtable");
    for (var row in tableRows) {
      print(row);
      print('ID: ${row['_id']}');
      print('Inspection On: ${row['inspectionOn']}');
      print('Type: ${row['type']}');
      print('Summary: ${row['summary']}');
      print('Property: ${row['property']}');
      print('Manager: ${row['manager']}');
      print('Tenant: ${row['tenant']}');
      print('Owner: ${row['owner']}');
      print('Created At: ${row['createdAt']}');
      print('-----------------------------------');
    }
  }

//! user interface started
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
          icon: Icon(CupertinoIcons.calendar_badge_plus), //! app bar calender
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
                fontSize: 40.0,
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
          child: Column(
            children: [
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
                        active();
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
                            color: Color.fromRGBO(162, 154, 255, 1),
                            width: 2.0,
                          ),
                          color: current == index
                              ? Color.fromRGBO(198, 198, 206, 1)
                              : Colors.white,
                          borderRadius: current == index
                              ? BorderRadius.circular(30)
                              : BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                              color: Color.fromRGBO(162, 154, 255, 1),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
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
                    itemCount: _tableRows.length,
                    itemBuilder: (context, index) {
                      final data = _tableRows[index];

                      return GestureDetector(
                        onTap: () {
                          String inspectionId =
                              data['_id']; //! id is inspection id
                          detailsOfInspection(
                              inspectionId); // Call your API or any other action
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => basicDetails(
                                type: data['type'],
                                startTime: data['startTime'],
                                endTime: data['endTime'],
                                date: data['inspectionOn'],
                                summary: data['summary'],
                                property: data['property'],
                                manager: data['manager'],
                                tenant: data['tenant'],
                                createdAt: data['createdAt'],
                                owner: data['owner'],
                                status: data['status'],
                                duration: data['duration'],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Text(data['createdAt']),
                          title: Text(
                            data['property'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(data['summary']),
                          trailing: Text(data['type']),
                        ),
                      );
                    },
                  ),
                  //! changes made here
                  ElevatedButton(
                    onPressed: () {
                      activate();
                    },
                    child: Text(
                      "Elevated Button",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Assuming you want to pass the data of the first row in _tableRows
                      //       print(_tableRows[0]['property']);
                      if (_tableRows.isNotEmpty) {
                        // Assuming you want to pass the data of the first row in _tableRows
                        final data = _tableRows[0];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => basicDetails(
                              type: data['type'],
                              date: data['date'],
                              endTime: data['endTime'],
                              startTime: data['startTime'],
                              summary: data['summary'],
                              property: data['property'],
                              manager: data['manager'],
                              tenant: data['tenant'],
                              owner: data['owner'],
                              createdAt: data['createdAt'],
                              status: data['status'],
                              duration: data['duration'],
                            ),
                          ),
                        );
                      } else {
                        // Handle the case where _tableRows is empty
                        print('No data available to pass to basicDetails');
                      }
                    },
                    child: Text(
                      "Basic Details",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await active(); // Make sure data is loaded
                      final data = _tableRows[0];
                      String inspectionId = data['_id']; //! id is inspection id
                      await detailsOfInspection(inspectionId);
                      printTableRows(_tableRows); // Then print data
                    },
                    child: Text(
                      "print and detailofInspection   Button",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final data = _tableRows[0];
                      String inspectionId = data['_id'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Copy(
                                  inspectionid: inspectionId,
                                  accessToken: widget.accessToken,
                                )),
                      );
                    },
                    child: Text(
                      "TESTING Button",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("other calling"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleData(
                                  accessToken: widget.accessToken,
                                )),
                      );
                    },
                    child: Text(
                      "SCHEDULE Button",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActiveScreen(
                                  accessToken: widget.accessToken,
                                )),
                      );
                    },
                    child: Text(
                      "ACTIVE Button",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InspectionScreen(
                                  accessToken: widget.accessToken,
                                )),
                      );
                    },
                    child: Text(
                      "MAINSCREEN Button",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(127, 117, 240, 1),
        splashColor: Color.fromRGBO(162, 154, 255, 1),
        child: Icon(Icons.add),
        onPressed: () {
          // _addTask();
          //active();
        },
      ),
    );
  }
}
