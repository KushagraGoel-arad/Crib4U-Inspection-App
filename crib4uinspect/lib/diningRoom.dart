import 'dart:convert';

import 'package:crib4uinspect/areaadd.dart';
import 'package:crib4uinspect/areas_notes.dart';
import 'package:crib4uinspect/areas_photos.dart';
import 'package:crib4uinspect/report.dart';
import 'package:crib4uinspect/reportEntryExit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:universal_html/html.dart' as html;

class areasEntryExit extends StatefulWidget {
  // final Inspection inspectionData;
  final String title;
  String? jwtToken;
  Map<String, dynamic>? reportDetails;
  String inspectId;
  List<Map<String, dynamic>>? areaDetails;
  String? reportId;
  String? propId;
  final String? accessToken;
  final String? refreshToken;
  final String? followupActions;
  bool? isSharedWithOwner;
  bool? isSharedWithTenant;
  final String? notes;
  final String? rentReview;

  areasEntryExit({
    super.key,
    required this.title,
    required this.areaDetails,
    this.jwtToken,
    required this.reportDetails,
    required this.inspectId,
    required this.reportId,
    this.propId,
    this.accessToken,
    this.refreshToken,
    this.followupActions,
    this.notes,
    this.rentReview,

    //required this.inspectionData
  });

  @override
  State<areasEntryExit> createState() => _areasEntryExitState();
}

enum Selection {
  Yes,
  No,
  None,
}

class _areasEntryExitState extends State<areasEntryExit> {
  // final List<String> items = [
  //   '                  ',
  //   'Door/Walls/Ceiling',
  //   'Windows/Screens',
  //   'Blinds/Curtains',
  //   'Fans/Light Fittings',
  //   'Floor/Floor coverings',
  //   'Power points',
  //   'other'
  // ];

  List<Map<String, dynamic>> itemsForArea = [];
  Selection selectedOption = Selection.None;
  List<Map<String, dynamic>> conditionsForItem = [];
  String itemName = "";
  String areaName = "";
  String? cleanValue = "";
  int selectedAreaIndex = 0;
  String? undamagedValue = '';
  var cleanValue1;
  var workingValue1;
  var undamagedValue1;
  String? workingValue = '';
  String? agentCommentValue = '';
  String? _agentComment;
  List<TextEditingController> agentCommentControllers = [];

  // var a;
  // var b;
  // var c;
  late final String title = widget.title;
  late Map<String, Selection> itemSelections;

  List<Map<String, dynamic>> getItemsForAreaName(areaName) {
    final area = widget.areaDetails!.firstWhere(
      (area) => area['name'] == areaName,
      orElse: () => <String, dynamic>{},
    );
    // print("area : $area");
    // print("areaName : $areaName");
    return area['items'] ?? [];
  }

  void updateAgentCommentForItem(int index, String comment) {
    Map<String, dynamic> _obj = itemsForArea[index];
    print("_obj: $_obj");
    //print("_obj: $_obj");

    if (_obj != null) {
      setState(() {
        print("Comment: $comment");
        itemsForArea[index]['agentComment'] = comment;
      });

      // print("Comment: $comment");

      // setState(() {
      //   cleanValue = getConditionValueForName(_cList, 'Clean');
      //   undamagedValue = getConditionValueForName(_cList, 'Undamaged');
      //   workingValue = getConditionValueForName(_cList, 'Working');
      // });
      //print("_cList 2: $_cList");
    }
    // return true;
    // Map<String, dynamic> item = itemsForArea[index];

    // if (item != null) {
    //   item['agentComment'] = comment;
    //   // Update the agentCommentControllers text
    //   agentCommentControllers[index].text = comment;
    // }
    // // Map<String, dynamic> _obj1 = itemsForArea[index];

    // // if (_obj1 != null) {
    // //   var agentComment = _obj1['agentComment'] as Map<String, dynamic>? ?? {};
    // //   agentComment['value'] = comment;
    // //   itemsForArea[index]['agentComment'] = agentCommentControllers[index];
    // // }
    // print("AGENT COMMENT: ${agentCommentControllers[index]}");
  }

  bool updateItemCondition(
      int index, String conditionName, String currentValue) {
    Map<String, dynamic> _obj = itemsForArea[index];

    //print("_obj: $_obj");

    if (_obj != null) {
      var _cList = _obj['conditions'] ?? [];
      //print("_cList: $_cList");
      for (int i = 0; i < _cList.hashCode; i++) {
        //print("_cList of i: ${_cList[i]}");

        if (_cList[i]['name'] == conditionName) {
          if (currentValue == 'Y') {
            _cList[i]['value'] = 'N';
          } else if (currentValue == 'N') {
            _cList[i]['value'] = "";
          } else {
            _cList[i]['value'] = "Y";
          }
          if (conditionName == 'Clean') {
            cleanValue = _cList[i]['value'];
          } else if (conditionName == 'Undamaged') {
            undamagedValue = _cList[i]['value'];
          } else if (conditionName == 'Working') {
            workingValue = _cList[i]['value'];
          }
          break;
        }
      }
      if (_cList != null && _cList.length > 0) {
        itemsForArea[index]['conditions'] = _cList;
      }
    }
    return true;
  }

  List<Map<String, dynamic>> getConditionsForItemName(
    List<Map<String, dynamic>> items,
    String itemName,
  ) {
    final item = items.firstWhere(
      (item) => item['name'] == itemName,
      // orElse: () => <String, dynamic>{},
    ) as Map<String, dynamic>;

    return item['conditions'] ?? [];
  }

  Map<String, String> getAgentCommentForItemName(
    List<Map<String, dynamic>> items,
    String itemName,
  ) {
    final item = items.firstWhere(
      (item) => item['name'] == itemName,
      // orElse: () => <String, dynamic>{},
    ) as Map<String, dynamic>;

    return {
      'agentComment': item['agentComment'] ?? 'uts',
    };
  }

  String getConditionValueForName(
    List<Map<String, dynamic>> conditions,
    String conditionName,
  ) {
    final condition = conditions.firstWhere(
      (cond) => cond['name'] == conditionName,
      orElse: () => <String, dynamic>{},
    ) as Map<String, dynamic>;
    return (condition['value'] ?? '').toString();
  }

  Map<String, String> getNameValueForCondition(
    List<Map<String, dynamic>> conditions,
    String conditionName,
  ) {
    for (final condition in conditions) {
      if (condition['name'] == conditionName) {
        return {
          'name': condition['name'],
          'value': condition['value'] ?? '',
        };
      }
      //print("Condition:$condition and name:$conditionName");
    }
    return {
      'name': conditionName,
      'value': '', // If the condition is not found, return an empty value
    };
  }

  Future<void> saveReportData(String inspectId, String reportId) async {
    final url = Uri.parse(
      'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspectId/$reportId',
    );
    //print("report details:${widget.reportDetails}");
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accessToken': '${html.window.sessionStorage['accessToken']}',
        },
        body: jsonEncode({
          'ReportDetails': widget.reportDetails
        }), // Convert the map directly to a JSON string
      );

      if (response.statusCode == 200) {
        // Report data saved successfully
      } else {
        // Failed to save report data
      }
    } catch (e) {
      print('API Request Error: $e');
      // Handle exceptions
    }
  }

  @override
  void initState() {
    super.initState();
    itemSelections = {};
    // updateSelectedArea(selectedAreaIndex);
    // Initialize agentCommentControllers based on the number of items
    agentCommentControllers = List.generate(
      widget.areaDetails!.length,
      (index) => TextEditingController(
          text: widget.areaDetails![index]['agentComment']),
    );
  }

  // void updateSelectedArea(int index) {
  //   // agentCommentController.text = widget.areaDetails[index].agentComments ??
  //   //     ''; // Use null check operator and provide a default value
  //   //descriptionController.text = widget.areaList[index].photosNotes ?? '';
  // }

  @override
  Widget build(BuildContext context) {
    itemsForArea = getItemsForAreaName(widget.title);
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
                  builder: (context) => reportEntryExit(
                      followupActions: '',
                      isSharedWithOwner: false,
                      isSharedWithTenant: false,
                      notes: '',
                      rentReview: '',
                      signs_moulds_dampness: false,
                      pests_vermin: false,
                      rubbish_bin_left_premises: false,
                      telephone_line_premises: false,
                      internet_line_premises: false,
                      shower_wtr_rate_ltr_minute: false,
                      internal_basins_wtr_rate_ltr_minute: false,
                      no_licking_taps: false,
                      water_meter_reading: '',
                      cleaning_repair_notes: '',
                      instalation_wtr_measures_on: '',
                      paint_premises_external_on: 'paint_premises_external_on',
                      paint_premises_internal_on: 'paint_premises_internal_on',
                      landlord_aggred_work_on: 'landlord_aggred_work_on',
                      flooring_clean_replaced_on: 'flooring_clean_replaced_on',
                      inspId: widget.inspectId,
                      reportId: widget.reportId!,
                      jwtToken: widget.jwtToken,
                      propertyId: widget.propId,
                      reportdetails: widget.reportDetails!,
                      areaList: [],
                      areadata: widget.areaDetails!)),
            );
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
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
                            passPhotos: widget.areaDetails!,
                            jwt: widget.jwtToken,
                            repdetail1: widget.reportDetails!,
                            inspectID1: widget.inspectId,
                            reportID1: widget.reportId!,
                            propertID: widget.propId,
                            areaDet:widget.areaDetails
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
                      // _saveData(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => notes(
                            title: widget.title,
                            passNotes: widget.areaDetails!,
                            jwt1: widget.jwtToken,
                            repdetail: widget.reportDetails!,
                            inspectID: widget.inspectId,
                            reportID: widget.reportId!,
                            areaData:widget.areaDetails
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
            SizedBox(height: 50.0),
            Center(
              child: Container(
                width: 406.0,
                height: 566.0,
                child: ListView.builder(
                  itemCount: itemsForArea.length,
                  itemBuilder: (context, index) {
                    // final item = items[index];
                    // final selectedOption = itemSelections[item];
                    final areaDetail = itemsForArea[index];
                    //print("areaItems: $areaDetail");
                    itemName = areaDetail['name'];
                    _agentComment = areaDetail['agentComment'] ?? "";
                    //print("Itemname: $itemName");
                    // final selectedOption = itemSelections[itemName];
                    //print("itemSelections: $itemSelections");
                    final conditionsForItem =
                        getConditionsForItemName(itemsForArea, itemName);
                    cleanValue = getNameValueForCondition(
                        conditionsForItem, 'Clean')['value'];

                    undamagedValue = getNameValueForCondition(
                        conditionsForItem, 'Undamaged')['value'];

                    workingValue = getNameValueForCondition(
                        conditionsForItem, 'Working')['value'];

                    // print("cleanValue: $cleanValue");
                    // print("Undamaged Value: $undamagedValue");
                    // print("Working Value: $workingValue");
                    // TextEditingController controller =
                    //     agentCommentControllers[index];
                    // Map<String, String> agentComment =
                    //     getAgentCommentForItemName(itemsForArea, itemName);
                    // String? agentCommentValue = agentComment['agentComment'];

                    return Card(
                      child: Container(
                        child: ExpansionTile(
                          title: Text(
                            itemName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(102, 88, 252, 1),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Color.fromRGBO(162, 154, 255, 1),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            updateItemCondition(
                                                index, 'Clean', cleanValue!);
                                            // if (selectedOption == Selection.Yes) {
                                            //   itemSelections[itemName] =
                                            //       Selection.No;
                                            // } else if (selectedOption ==
                                            //     Selection.No) {
                                            //   itemSelections[itemName] =
                                            //       Selection.None;
                                            // } else {
                                            //   itemSelections[itemName] =
                                            //       Selection.Yes;
                                            // }
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          child: Column(
                                            children: [
                                              Text("Clean"),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Color.fromRGBO(
                                                        162, 154, 255, 1),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    cleanValue!,
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            updateItemCondition(index,
                                                'Undamaged', undamagedValue!);
                                            // if (selectedOption == Selection.Yes) {
                                            //   itemSelections[itemName] =
                                            //       Selection.No;
                                            // } else if (selectedOption ==
                                            //     Selection.No) {
                                            //   itemSelections[itemName] =
                                            //       Selection.None;
                                            // } else {
                                            //   itemSelections[itemName] =
                                            //       Selection.Yes;
                                            // }
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          child: Column(
                                            children: [
                                              Text("Undamaged"),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Color.fromRGBO(
                                                        162, 154, 255, 1),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    undamagedValue!,
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            final updatedWorkingValue =
                                                workingValue ?? "";
                                            updateItemCondition(index,
                                                'Working', updatedWorkingValue);
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          child: Column(
                                            children: [
                                              Text("Working"),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Color.fromRGBO(
                                                        162, 154, 255, 1),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    workingValue ?? "",
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return TextField(
                                        controller: (index <
                                                agentCommentControllers.length)
                                            ? agentCommentControllers[index]
                                            : TextEditingController(),
                                        onChanged: (value) {
                                          if (index <
                                              agentCommentControllers.length) {
                                            setState(() {
                                              updateAgentCommentForItem(
                                                  index, value);
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                            labelText: _agentComment),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  _saveData(context);
                },
                child: Text('Save Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // void updateSelectedArea(int index) {
  //   agentCommentController.text = widget.areaList[index]. ??
  //       ''; // Use null check operator and provide a default value

  // }

  void _saveData(BuildContext context) async {
    //String agentComment = agentCommentController.text;
//     setState(() {
// // Update this value
//     });

    try {
      final areas = widget.reportDetails!['areas'] as List;

      if (widget.reportDetails!.containsKey('areas') &&
          widget.reportDetails!['areas'] is List) {
        // Cast the 'areas' to a List
        var areasList = widget.reportDetails!['areas'] as List;

        // Find the index of the area with the matching 'name'
        var areaIndex =
            areasList.indexWhere((area) => area['name'] == widget.title);
        print('area index : $areaIndex');
        if (areaIndex != -1) {
          var areaToUpdate = areasList[areaIndex];
          areaToUpdate['notes'] = "";
          areaToUpdate['photosNotes'] = '';
          areaToUpdate['tenantComment'] = "";
          areaToUpdate['isDeleted'] = false;
          // print("area to update: ${areaToUpdate['items']}");

          areaToUpdate['items'] = itemsForArea;
          //print('Before For : $itemsForArea');
          // for (int index = 0; index < itemsForArea.length; index++) {
          //   print('after For : $index');
          //   updateAgentCommentForItem(
          //       index, agentCommentControllers[index].text);

          // }
          //print("Item comment : ${agentCommentControllers[areaIndex].text}");

          areaToUpdate['photos'] = []; // Clear the 'photos' list
        }
      }

      await saveReportData(
        widget.inspectId,
        widget.reportId!,
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
