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

class reportEntryExit extends StatefulWidget {
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
  List<Map<String, dynamic>> areadata;
  reportEntryExit({
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
    required this.areadata,
  });

  @override
  State<reportEntryExit> createState() => _reportEntryExitState();
}

class _reportEntryExitState extends State<reportEntryExit> {
  List<bool> _isExpandedList = [false, false, false, false, false, false];
  List<Areas> areasadd = [];
  List<dynamic> areasData = [];
  List<Areas> takeareaData = [];
  // String accessType = '';
  // String status = '';
  // String inspectionDate = '';
  String reportID = '';
  String inspectionID = '';
  List<dynamic> details1 = [];

  List<Areas> createAreasList(List<dynamic> areasData) {
    // print("areasData: $areasData");
    List<Areas> areasList = areasData.map((areaData) {
      final items1 = extractItems(areaData);
      final conditions = extractConditions(areaData);

      List<Area> item2 = items1.map((itemData) {
        return Area(
          name: itemData?['name'] ?? '',
          agentComment: itemData?['agentComment'] ?? '',
          otherComment: itemData?['otherComment'] ?? '',
          isDeleted: itemData?['isDeleted'] as bool,
          conditions: conditions,
        );
      }).toList();

      return Areas(
        name: areaData['name'] ?? '',
        notes: areaData['notes'] ?? '',
        photosNotes: areaData['photosNotes'] ?? '',
        tenantComment: areaData['tenantComment'] ?? '',
        isDeleted: areaData['isDeleted'] as bool,
        items: item2,
        photos: areaData['photos'] ?? '',
      );
    }).toList();

    // print(areasList);

    return areasList;
  }

  // List<Areas> createAreasList(List<dynamic> areasData) {
  //   List<Areas> areasList = areasData.map((areaData) {
  //     final items1 = extractItems(areaData);
  //     final conditions = extractConditions(areaData);

  //     List<Area> item2 = items1.map((itemData) {
  //       return Area(
  //         name: itemData['name'],
  //         agentComment: itemData['agentComment'],
  //         otherComment: itemData['otherComment'],
  //         isDeleted: itemData['isDeleted'],
  //         conditions: conditions,
  //       );
  //     }).toList();

  //     return Areas(
  //       name: areaData['name'],
  //       notes: areaData['notes'],
  //       photosNotes: areaData['photosNotes'],
  //       tenantComment: areaData['tenantComment'],
  //       isDeleted: areaData['isDeleted'],
  //       items: item2,
  //       photos: areaData['photos'],
  //     );
  //   }).toList();

  //   print(areasList);

  //   return areasList;
  // }

  List<dynamic> extractItems(Map<String, dynamic> areaData) {
    // Implement the logic to extract 'items' from areaData
    if (areaData['items'] != null) {
      return (areaData['items'] as List<dynamic>);
    } else {
      return [];
    }
  }

  List<Condition> extractConditions(Map<String, dynamic> areaData) {
    if (areaData['conditions'] != null) {
      return (areaData['conditions'] as List<dynamic>).map((conditionData) {
        return Condition(
          name: conditionData['name'],
          value: conditionData['value'],
        );
      }).toList();
    } else {
      return [];
    }
  }

  // Inspection parseResponse(Map<String, dynamic> data) {
  //   return Inspection(
  //     name: data['name'] ,
  //     notes: data['notes'],
  //     photosNotes: data['photosNotes'],
  //     tenantComment: data['tenantComment'],
  //     isDeleted: data['isDeleted'],
  //     items: (data['items'] as List<dynamic>).map((item) {
  //       return Area(
  //         name: item['name'],
  //         agentComment: item['agentComment'],
  //         otherComment: item['otherComment'],
  //         isDeleted: item['isDeleted'],
  //         conditions: (item['conditions'] as List<dynamic>).map((condition) {
  //           return Condition(
  //             name: condition['name'],
  //             value: condition['value'],
  //           );
  //         }).toList(),
  //       );
  //     }).toList(),
  //   );
  // }

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
  final List<String> itemU = [
    'Compliance/Utilities',
  ];
  final List<String> item5 = [
    'Kitchen',
  ];
  final List<String> item6 = [
    'Dining Room',
  ];

  void addNewArea(String inspectionId, String reportId, String areaName) async {
    // if (areasadd.any((area) => area.name == areaName)) {
    //   // Handle the case where the area name is a duplicate (show an error, etc.)
    //   // You may want to display a snackbar or dialog to inform the user.
    //   return SnackBar(
    //     content: Text("Area name already exists."),
    //   );
    // }
    // print("Inspection ID:$inspectionId");
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
        // print(responseBodyJson);
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error making POST request: $e');
    }
  }

  Future<void> deleteArea(
      String inspectionId, String reportId, String areaName) async {
    final Uri uri = Uri.https(
      'crib4u.axiomprotect.com:9497',
      '/api/prop_gateway/inspect/deleteArea/$inspectionId/$reportId',
    );

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accessToken': '${html.window.sessionStorage['accessToken']}',
    };

    final Map<String, String> body = {
      'areaName': areaName,
    };

    final String jsonBody = jsonEncode(body);

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      // Request was successful, you can handle the response here
      print('Area deleted successfully');
      // If there's a response body, you can also parse it
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
      }
    } else {
      // Request failed, handle the error here
      print('Failed to delete area. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> getReportList(String? propertyTraceId) async {
    final Uri uri = Uri.https(
      'crib4u.axiomprotect.com:9497',
      '/api/prop_gateway/inspect/getReportList/$propertyTraceId',
    );

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accessToken': '${html.window.sessionStorage['accessToken']}',
    };

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      // Request was successful, you can handle the response here
      print('Report list retrieved successfully');

      // If there's a response body, you can also parse it
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        if (responseData['resultCode'] == 1) {
          details1 = responseData['details'];

          //Extract and print the details for each inspection
          for (var inspection in details1) {
            // accessType = inspection['type'];
            // status = inspection['status'];
            inspectionID = inspection['inspectionId'];
            reportID = inspection['reportId'];
          }
          showSuccessDialog(details1);
        }
      }
    } else {
      // Request failed, handle the error here
      print(
        'Failed to retrieve report list. Status code: ${response.statusCode}',
      );
      print('Response body: ${response.body}');
    }
  }

  void copy(
    String inspectionId,
    String reportId,
  ) async {
    final Headers = {
      'Content-Type': 'application/json',
      'accessToken': '${html.window.sessionStorage['accessToken']}',
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
      "copyReportId": reportId
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

      //final responseData = responseBodyJson['data'];
      //

    } else {
      print('API request failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  void showSuccessDialog(List details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: AlertDialog(
            title: Text("Report List"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details.map((detail) {
                final accessType = detail['type'];
                final status = detail['status'];
                final inspectionDate = detail['inspectionDate'];

                return ListTile(
                  title: Text("($accessType)"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status: $status"),
                      Text("Inspection Date: $inspectionDate"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      copy(inspectionID, reportID);
                    },
                  ),
                );
              }).toList(),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the success dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.areadata != null && widget.areadata.isNotEmpty) {
      takeareaData = createAreasList(widget.areadata);
      // print(takeareaData);
    } else {
      print("takeareaData is null");
    }
  }

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
                // showSuccessDialog(details1);
                getReportList(widget.propertyId);
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
                              builder: (context) => CompliancePage(
                                //checklistItems: [widget.signs_moulds_dampness, widget.pests_vermin, widget.rubbish_bin_left_premises, widget.telephone_line_premises, widget.internet_line_premises, widget.shower_wtr_rate_ltr_minute, widget.internal_basins_wtr_rate_ltr_minute, widget.no_licking_taps],
                                signs_moulds_dampness:
                                    widget.signs_moulds_dampness,
                                pests_vermin: widget.pests_vermin,
                                rubbish_bin_left_premises:
                                    widget.rubbish_bin_left_premises,
                                telephone_line_premises:
                                    widget.telephone_line_premises,
                                internet_line_premises:
                                    widget.internet_line_premises,
                                shower_wtr_rate_ltr_minute:
                                    widget.shower_wtr_rate_ltr_minute,
                                internal_basins_wtr_rate_ltr_minute:
                                    widget.internal_basins_wtr_rate_ltr_minute,
                                no_licking_taps: widget.no_licking_taps,

                                water_meter_reading: widget.water_meter_reading,
                                cleaning_repair_notes:
                                    widget.cleaning_repair_notes,
                                instalation_wtr_measures_on:
                                    widget.instalation_wtr_measures_on,
                                paint_premises_external_on:
                                    widget.paint_premises_external_on,
                                paint_premises_internal_on:
                                    widget.paint_premises_internal_on,
                                landlord_aggred_work_on:
                                    widget.landlord_aggred_work_on,
                                flooring_clean_replaced_on:
                                    widget.flooring_clean_replaced_on,
                              ),
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
                height: null, // or remove the 'height' property
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      takeareaData.length, // Display all areas from the list
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final area = takeareaData[index];
                    return Card(
                      child: ListTile(
                        title: Text(area.name),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => areasEntryExit(
                                title: area.name,
                                areaDetails: widget.areadata,
                                jwtToken: widget.jwtToken,
                                reportDetails: widget.reportdetails,
                                inspectId: widget.inspId,
                                reportId: widget.reportId,
                                propId: widget.propertyId,
                                //     parseResponse(widget.reportdetails),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

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
                                takeareaData.map((area) => area.name).toList(),
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
                                  tenantComment: '',
                                );
                                setState(() {
                                  takeareaData.add(newArea);
                                });
                                addNewArea(widget.inspId, widget.reportId,
                                    newAreaName); // Call the addNewArea function here with the areaName
                              } else {
                                // Handle the case where the area name is a duplicate (show an error, etc.)
                                // You may want to display a snackbar or dialog to inform the user.
                              }
                            },
                            onAreaDeleted: (NewareaName) {
                              // Handle deleting an existing area here
                              setState(() {
                                deleteArea(widget.inspId, widget.reportId,
                                    NewareaName);
                                takeareaData.removeWhere(
                                    (area) => area.name == NewareaName);
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

              // FloatingActionButton(
              //   backgroundColor: Color.fromRGBO(127, 117, 240, 1),
              //   splashColor: Color.fromRGBO(162, 154, 255, 1),
              //   onPressed: () {
              //     // Show the dialog to add a new area
              //     showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           backgroundColor: Colors.transparent,
              //           content: SizedBox(
              //             width: 800,
              //             height: 700,
              //             child: AddAreaDialog(
              //               existingAreaNames:
              //                   areasadd.map((area) => area.name).toList(),
              //               onAreaAdded: (newAreaName) {
              //                 final newArea = Area(name: newAreaName);
              //                 setState(() {
              //                   areasadd.add(newArea);
              //                 });
              //                 // Call the addNewArea function here with the areaName
              //                 addNewArea(
              //                     widget.inspId, widget.reportId, newAreaName);
              //               },
              //               onAreaDeleted: (areaName) {
              //                 // Handle deleting existing area here
              //                 setState(() {
              //                   areasadd.removeWhere(
              //                       (area) => area.name == areaName);
              //                   // Implement the logic for deleting an area from the server
              //                 });
              //               },
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              //   child: Icon(Icons.add),
              // ),
            ],
          )),
        ));
  }
}
