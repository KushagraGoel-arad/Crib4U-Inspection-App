import 'dart:convert';

import 'package:crib4uinspect/areas_photos.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/report.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class notes extends StatefulWidget {
  final String title;
  List<Map<String, dynamic>> passNotes;
  String? jwt1 = '';
  Map<String, dynamic> repdetail = {};
  String inspectID = '';
  String reportID = '';
  notes(
      {super.key,
      required this.title,
      required this.passNotes,
      this.jwt1,
      required this.repdetail,
      required this.inspectID,
      required this.reportID});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  late final String title = widget.title;
  String? notess = '';
  String? tenantComment = '';
  String? areaName = '';
  TextEditingController notesController = TextEditingController();
  TextEditingController tenantCommentController = TextEditingController();
  Map<String, dynamic> getAreaDetails(String areaName) {
    final area = widget.passNotes.firstWhere(
      (area) => area['name'] == areaName,
      orElse: () => <String, dynamic>{},
    );
    return area;
  }

  Future<void> saveReportData(String inspectID, String reportID) async {
    final url = Uri.parse(
      'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspectID/$reportID',
    );

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accessToken': '${html.window.sessionStorage['accessToken']}',
        },
        body: jsonEncode({
          'ReportDetails': widget.repdetail
        }), // Convert the map directly to a JSON string
      );

      if (response.statusCode == 200) {
        // Report data saved successfully
      } else {
        // Failed to save report data
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.passNotes);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> area = getAreaDetails(
        areaName!); // Replace 'kitchen' with the desired area name
    notess = area['notes'];
    tenantComment = area['tenantComment'];
    notesController.text = notess ?? ''; // Set the value for Notes
    tenantCommentController.text = tenantComment ?? '';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color.fromRGBO(162, 154, 255, 1),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => report()),
            // );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$title",
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
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // _saveData(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => areasEntryExit(
                          title: widget.title,
                          areaDetails: [],
                          inspectId: '',
                          reportDetails: {},
                          reportId: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50.0,
                    color: Color.fromRGBO(162, 154, 255, 1),
                    child: Center(
                      child: Text(
                        'Items',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    //_saveData(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => photos(
                          title: widget.title,
                          passPhotos: [],
                          repdetail1: {},
                          inspectID1: '',
                          reportID1: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50.0,
                    color: Color.fromRGBO(162, 154, 255, 1),
                    child: Center(
                      child: Text(
                        'Photos',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => notes(
                          title: widget.title,
                          passNotes: [],
                          repdetail: {},
                          inspectID: '',
                          reportID: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50.0,
                    color: Color.fromRGBO(162, 154, 255, 1),
                    child: Center(
                      child: Text(
                        'Notes',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 80.0),
          Center(
            child: Container(
              width: 406.0,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text("$title"),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Stack(children: [
                      Container(
                        width: 300,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextField(
                              controller: tenantCommentController,
                              decoration: InputDecoration(
                                  hintText:
                                      'Tenant Comment', // Placeholder text
                                  labelText:
                                      'Tenant Comment', // Label for the text field
                                  labelStyle:
                                      TextStyle(color: Colors.grey[500]),
                                  enabledBorder: InputBorder
                                      .none, // Remove the underline when not focused
                                  focusedBorder: InputBorder.none),
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ],
                      )
                    ]),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Stack(children: [
                      Container(
                        width: 300,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextField(
                              controller: notesController,
                              decoration: InputDecoration(
                                  hintText: 'Notes', // Placeholder text
                                  labelText:
                                      'Notes', // Label for the text field
                                  labelStyle:
                                      TextStyle(color: Colors.grey[500]),
                                  enabledBorder: InputBorder
                                      .none, // Remove the underline when not focused
                                  focusedBorder: InputBorder.none),
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () => _saveData(context),
              child: Text('Save Data'),
            ),
          ),
        ],
      ),
    );
  }

  void _saveData(BuildContext context) async {
    //String agentComment = agentCommentController.text;
//     setState(() {
// // Update this value
//     });

    try {
      final areas = widget.repdetail['areas'] as List;

      if (widget.repdetail.containsKey('areas') &&
          widget.repdetail['areas'] is List) {
        // Cast the 'areas' to a List
        var areasList = widget.repdetail['areas'] as List;

        // Find the index of the area with the matching 'name'
        var areaIndex =
            areasList.indexWhere((area) => area['name'] == widget.title);

        if (areaIndex != -1) {
          // Update the area data at the found index
          var areaToUpdate = areasList[areaIndex];
          areaToUpdate['notes'] = notesController.text;
          areaToUpdate['photosNotes'] = '';
          areaToUpdate['tenantComment'] = tenantCommentController.text;
          //areaToUpdate['isDeleted'] = true;

          // Update 'items' based on the provided response
          areaToUpdate['items'] = [
            // {
            //   "name": "Windows/screens",
            //   "agentComment": '',
            //   "otherComment": "",
            //   "conditions": [
            //     {"name": "Clean", "value": ''},
            //     {"name": "Undamaged", "value": ''},
            //     {"name": "Working", "value": ''},
            //   ],
            // },
            // {
            //   "name": "Blinds/curtains",
            //   "agentComment": '',
            //   "otherComment": "",
            //   "conditions": [
            //     {"name": "Clean", "value": ''},
            //     {"name": "Undamaged", "value": ''},
            //     {"name": "Working", "value": ''},
            //   ],
            // },
            // {
            //   "name": "Fans/light fittings",
            //   "agentComment": '',
            //   "otherComment": "",
            //   "conditions": [
            //     {"name": "Clean", "value": ''},
            //     {"name": "Undamaged", "value": ''},
            //     {"name": "Working", "value": ''},
            //   ],
            // },
            // {
            //   "name": "Floor/floor coverings",
            //   "agentComment": '',
            //   "otherComment": "",
            //   "conditions": [
            //     {"name": "Clean", "value": ''},
            //     {"name": "Undamaged", "value": ''},
            //     {"name": "Working", "value": ''},
            //   ],
            // },
            // {
            //   "name": "Wardrobe/drawers/shelves",
            //   "agentComment": '',
            //   "otherComment": "",
            //   "conditions": [
            //     {"name": "Clean", "value": ''},
            //     {"name": "Undamaged", "value": ''},
            //     {"name": "Working", "value": ''},
            //   ],
            // },
            // {
            //   "name": "Air conditioner",
            //   "agentComment": '',
            //   "otherComment": "",
            //   "conditions": [
            //     {"name": "Clean", "value": ''},
            //     {"name": "Undamaged", "value": ''},
            //     {"name": "Working", "value": ''},
            //   ],
            // },
            // {
            //   "name": "Power points",
            //   "agentComment": '',
            //   "otherComment": "",
            //   "conditions": [
            //     {"name": "Clean", "value": ''},
            //     {"name": "Undamaged", "value": ''},
            //     {"name": "Working", "value": ''},
            //   ],
            // },
            // {
            //   "name": "Other",
            //   "agentComment": '',
            //   "otherComment": "",
            //   "conditions": [
            //     {"name": "Clean", "value": ''},
            //     {"name": "Undamaged", "value": ''},
            //     {"name": "Working", "value": ''},
            //   ],
            // },
          ];

          //print("Clean: : $cleanValue");
          areaToUpdate['photos'] = []; // Clear the 'photos' list
        }
      }

      await saveReportData(
        widget.inspectID,
        widget.reportID,
      );
      //agentCommentController.clear();
      // cleanValue = "";
      // undamagedValue = "";
      // workingValue = "";
      //Navigator.pop(context);
    } catch (e) {
      // Handle any errors that occur during the API call.
    }
  }
}
