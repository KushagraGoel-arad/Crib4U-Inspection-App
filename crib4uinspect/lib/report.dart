import 'dart:convert';
import 'dart:ui';
import 'package:crib4uinspect/areaadd.dart';
import 'package:crib4uinspect/popupAddarea.dart';
import 'package:http/http.dart' as http;
import 'package:crib4uinspect/compliance.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/edit.dart';
import 'package:crib4uinspect/inspection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'areaaddScreen.dart';
import 'compliance.dart';
import 'package:universal_html/html.dart' as html;

class report extends StatefulWidget {
  final String? accessToken;
  final String? refreshToken;
  final String followupActions;
  final String inspId;
  final String reportId;
  bool isSharedWithOwner;
  bool isSharedWithTenant;
  final String notes;
  final String rentReview;
  bool signs_moulds_dampness;
  bool pests_vermin;
  bool rubbish_bin_left_premises;
  bool telephone_line_premises;
  bool internet_line_premises;
  bool shower_wtr_rate_ltr_minute;
  bool internal_basins_wtr_rate_ltr_minute;
  bool no_licking_taps;
  final String water_meter_reading;
  final String cleaning_repair_notes;
  final String instalation_wtr_measures_on;
  final String paint_premises_external_on;
  final String paint_premises_internal_on;
  final String landlord_aggred_work_on;
  final String flooring_clean_replaced_on;
  final String? jwtToken;
  final String? propertyId;
  Map<String, dynamic> reportdetails;
  List<Areas> areaList;
  report({
    super.key,
    this.accessToken,
    this.refreshToken,
    required this.followupActions,
    required this.isSharedWithOwner,
    required this.isSharedWithTenant,
    required this.notes,
    required this.rentReview,
    required this.signs_moulds_dampness,
    required this.pests_vermin,
    required this.rubbish_bin_left_premises,
    required this.telephone_line_premises,
    required this.internet_line_premises,
    required this.shower_wtr_rate_ltr_minute,
    required this.internal_basins_wtr_rate_ltr_minute,
    required this.no_licking_taps,
    required this.water_meter_reading,
    required this.cleaning_repair_notes,
    required this.instalation_wtr_measures_on,
    required this.paint_premises_external_on,
    required this.paint_premises_internal_on,
    required this.landlord_aggred_work_on,
    required this.flooring_clean_replaced_on,
    required this.inspId,
    required this.reportId,
    required this.jwtToken,
    required this.propertyId,
    required this.reportdetails,
    required this.areaList,
  });

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  List<bool> _isExpandedList = [false, false, false, false, false, false];
  List<Areas> areasadd = [];
  int selectedAreaIndex = 0;

  final List<String> items = [
    'Shared with User',
  ];
  List<String> item1 = [
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
  // final List<String> itemU = [
  //   'Compliance/Utilities',
  // ];
  final List<String> item5 = [
    'Kitchen',
  ];
  final List<String> item6 = [
    'Dining Room',
  ];

  void addNewArea(String inspectionId, String reportId, String areaName) async {
    final String url =
        'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/addNewArea/$inspectionId/$reportId';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accessToken': '${html.window.sessionStorage['accessToken']}',
    };

    final Map<String, dynamic> requestBody = {
      "areaName": areaName,
    };

    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: requestBodyJson,
      );

      if (response.statusCode == 200 && response.statusCode < 300) {
        final responseBodyJson = jsonDecode(response.body);
        // Process the response data if needed
        print(responseBodyJson);
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error making POST request: $e');
    }
  }

  void copy(
    String inspectionId,
    String reportId,
  ) async {
    final Headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    final Body = jsonEncode({
      "propertyId": {
        "_id": widget.propertyId,
        "property_basic_details": {
          "_id": "",
          "reference": "",
          "address": {"line_two": "", "line_one": "", "zip_code": ""}
        }
      },
      "copyReportId": ""
    });
    print(Body);

    final response = await http.post(
        Uri.parse(
            'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/copyReport/$inspectionId/$reportId'),
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
  void initState() {
    super.initState();
    // You can initialize the 'areasadd' list from the 'areaList' provided in the widget
    areasadd = widget.areaList
        .map((area) => Areas(
              name: area.name,
              isDeleted: area.isDeleted ?? false,
              notes: area.notes ?? '', // Initialize notes from widget.areaList
              photosNotes: area.photosNotes ??
                  '', // Initialize photonotes from widget.areaList
              items: area.items ?? [],
              photos: area.photos ?? [],
              tenantComment: area.tenantComment ?? '',
            ))
        .toList();
  }

  // void updateSelectedArea(int index) {
  //   nameController.text = widget.areaList[index].notes;
  //   descriptionController.text = widget.areaList[index].photosNotes;
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
                copy(widget.inspId, widget.reportId);
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
                      child: SwitchListTile(
                        title: Text(
                          items[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(''),
                        value: widget.isSharedWithOwner ?? false,
                        onChanged: (value) {
                          // Handle the switch value change here
                          // For example, you can update the 'isSharedWithOwner' value
                          setState(() {
                            widget.isSharedWithOwner = value;
                          });
                        },
                        // secondary: Icon(
                        //   CupertinoIcons.sidebar_left,
                        //   color: Color.fromRGBO(162, 154, 255, 1),
                        // ),
                        // onTap: () {
                        //   // Handle tap if needed
                        // },
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
                    final listItem = items[index];

                    return Card(
                      child: SwitchListTile(
                        title: Text(
                          'Shared with Tenant',
                          style: TextStyle(fontSize: 18.0),
                        ),

                        value: widget.isSharedWithTenant ?? false,
                        onChanged: (value) {
                          setState(() {
                            widget.isSharedWithTenant = value;
                          });
                        },
                        // secondary: Icon(
                        //   CupertinoIcons.sidebar_left,
                        //   color: Color.fromRGBO(162, 154, 255, 1),
                        // ),
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
                        subtitle: Text(
                          widget.rentReview,
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
                              // subtitle: Text(
                              //   widget.notes,
                              // ),
                            );
                          },
                          body: ListTile(
                            title: TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: widget.notes,
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
                        subtitle: Text(
                          widget.followupActions,
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
              // SizedBox(
              //   height: 60,
              //   width: double.infinity,
              //   child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: items.length,
              //     scrollDirection: Axis.vertical,
              //     itemBuilder: (context, index) {
              //       final listItem = item5[index];

              //       return Card(
              //         child: ListTile(
              //           title: Text(
              //             item5[index],
              //             style: TextStyle(fontSize: 18.0),
              //           ),
              //           trailing: Icon(
              //             Icons.arrow_forward,
              //             color: Color.fromRGBO(162, 154, 255, 1),
              //           ),
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => areasEntryExit(
              //                   title: 'Kitchen',
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 60,
              //   width: double.infinity,
              //   child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: items.length,
              //     scrollDirection: Axis.vertical,
              //     itemBuilder: (context, index) {
              //       final listItem = item6[index];

              //       return Card(
              //         child: ListTile(
              //           title: Text(
              //             item6[index],
              //             style: TextStyle(fontSize: 18.0),
              //           ),
              //           trailing: Icon(
              //             Icons.arrow_forward,
              //             color: Color.fromRGBO(162, 154, 255, 1),
              //           ),
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => areasEntryExit(
              //                   title: 'Dining Room',
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),

              SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  itemCount: areasadd.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final area = areasadd[index];
                    return Card(
                      child: ListTile(
                        title: Text(area.name),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          setState(() {
                            // Check if selectedAreaIndex is valid
                            if (selectedAreaIndex < areasadd.length) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddAreaScreen(
                                    reportDetails: widget.reportdetails,
                                    propId: widget.propertyId,
                                    jwttoken: widget.jwtToken,
                                    areaName: area.name,
                                    inspID: widget.inspId,
                                    reportID: widget.reportId,
                                    areaList: widget.areaList,
                                    notes: widget
                                        .areaList[selectedAreaIndex].notes,
                                    photonotes: widget
                                        .areaList[selectedAreaIndex]
                                        .photosNotes,
                                  ),
                                ),
                              );
                            } else {
                              // Handle the case where selectedAreaIndex is out of range
                              // You may want to display a snackbar or dialog to inform the user.
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(
              //   height: null, // or remove the 'height' property
              //   width: double.infinity,
              //   child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: areasadd.length, // Display all areas from the list
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       final area = areasadd[index];
              //       return Card(
              //         child: ListTile(
              //           title: Text(area.name),
              //           trailing: Icon(
              //             Icons.arrow_forward,
              //             color: Color.fromRGBO(162, 154, 255, 1),
              //           ),
              //           onTap: () {
              //             setState(() {
              //               selectedAreaIndex = index;
              //             });
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => AddAreaScreen(
              //                   reportDetails: widget.reportdetails,
              //                   propId: widget.propertyId,
              //                   areaName: area.name,
              //                   inspID: widget.inspId,
              //                   reportID: widget.reportId,
              //                   areaList: widget.areaList,
              //                   notes: area
              //                       .notes, // Pass notes for the selected area
              //                   photonotes: area.photosNotes,
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: null,
              //   width: double.infinity,
              //   child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: areasadd.length, // Display all areas from the list
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       final area = areasadd[index];
              //       return Card(
              //         child: ListTile(
              //           title: Text(area.name),
              //           trailing: Icon(
              //             Icons.arrow_forward,
              //             color: Color.fromRGBO(162, 154, 255, 1),
              //           ),
              //           onTap: () {
              //             setState(() {
              //               selectedAreaIndex = index;
              //             });
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => AddAreaScreen(
              //                   reportDetails: widget.reportdetails,
              //                   propId: widget.propertyId,
              //                   areaName: area.name,
              //                   inspID: widget.inspId,
              //                   reportID: widget.reportId,
              //                   jwttoken: widget.jwtToken,
              //                   areaList: widget.areaList,
              //                   notes: area
              //                       .notes, // Pass notes for the selected area
              //                   photonotes: area.photosNotes,
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
              FloatingActionButton(
                backgroundColor: Color.fromRGBO(127, 117, 240, 1),
                splashColor: Color.fromRGBO(162, 154, 255, 1),
                onPressed: () {
                  // Show the dialog to add a new area
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: SizedBox(
                          width: 800,
                          height: 700,
                          child: AddAreaDialog(
                            existingAreaNames:
                                areasadd.map((area) => area.name).toList(),
                            onAreaAdded: (newAreaName) {
                              // Check for duplicates before adding a new area
                              if (!areasadd
                                  .any((area) => area.name == newAreaName)) {
                                final newArea = Areas(
                                    name: newAreaName,
                                    isDeleted: false,
                                    items: [],
                                    notes: '',
                                    photos: [],
                                    photosNotes: '',
                                    tenantComment: '');
                                setState(() {
                                  areasadd.add(newArea);
                                });
                                // Call the addNewArea function here with the areaName
                                addNewArea(widget.inspId, widget.reportId,
                                    newAreaName);
                              } else {
                                // Handle the case where the area name is a duplicate (show an error, etc.)
                                // You may want to display a snackbar or dialog to inform the user.
                              }
                            },
                            onAreaDeleted: (areaName) {
                              // Handle deleting existing area here
                              setState(() {
                                areasadd.removeWhere(
                                    (area) => area.name == areaName);
                                // Implement the logic for deleting an area from the server
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.add),
              ),
            ],
          )),
        ));
  }
}

// class Area {
//   final String name;
//   final String

//   Area({
//     required this.name,
//   });
// }
