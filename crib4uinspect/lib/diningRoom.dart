import 'dart:convert';

import 'package:crib4uinspect/areaadd.dart';
import 'package:crib4uinspect/areas_notes.dart';
import 'package:crib4uinspect/areas_photos.dart';
import 'package:crib4uinspect/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class areasEntryExit extends StatefulWidget {
  // final Inspection inspectionData;
  final String title;
  String? jwtToken;
  Map<String, dynamic> reportDetails;
  String inspectId;
  List<Map<String, dynamic>> areaDetails;
  String reportId;
  areasEntryExit({
    super.key,
    required this.title,
    required this.areaDetails,
    this.jwtToken,
    required this.reportDetails,
    required this.inspectId,
    required this.reportId,
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

  late final String title = widget.title;
  late Map<String, Selection> itemSelections;

  List<Map<String, dynamic>> getItemsForAreaName(String areaName) {
    final area = widget.areaDetails.firstWhere(
      (area) => area['name'] == areaName,
      orElse: () => <String, dynamic>{},
    );
    // print("area : $area");
    return area['items'] ?? [];
  }

  bool updateItemCondition(
      int index, String conditionName, String currentValue) {
    Map<String, dynamic> _obj = itemsForArea[index];

    //print("_obj: $_obj");

    if (_obj != null) {
      var _cList = _obj['conditions'] ?? [];
      //print("_cList: $_cList");
      for (int i = 0; i < _cList.length; i++) {
        //print("_cList of i: ${_cList[i]}");

        if (_cList[i]['name'] == conditionName) {
          if (currentValue == 'Y') {
            _cList[i]['value'] = 'N';
          } else if (currentValue == 'N') {
            _cList[i]['value'] = "";
          } else {
            _cList[i]['value'] = "Y";
          }
          break;
        }
      }
      if (_cList != null && _cList.length > 0) {
        itemsForArea[index]['conditions'] = _cList;
      }
      //print("_cList 2: $_cList");
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
      'agentComment': item['agentComment'] ?? '',
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
    return condition['value'] ?? '';
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

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accessToken': '${widget.jwtToken}',
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
      // Handle exceptions
    }
  }

  @override
  void initState() {
    super.initState();
    itemSelections = {};
  }

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
            Navigator.pop(context);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => photos(
                            title: widget.title,
                            passPhotos: widget.areaDetails),
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
                            title: widget.title, passNotes: widget.areaDetails),
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
                  final itemName = areaDetail['name'];
                  //print("Itemname: $itemName");
                  final selectedOption = itemSelections[itemName];
                  //print("itemSelections: $itemSelections");
                  final conditionsForItem =
                      getConditionsForItemName(itemsForArea, itemName);
                  final cleanValue = getNameValueForCondition(
                      conditionsForItem, 'Clean')['value'];

                  final undamagedValue = getNameValueForCondition(
                      conditionsForItem, 'Undamaged')['value'];

                  final workingValue = getNameValueForCondition(
                      conditionsForItem, 'Working')['value'];

                  Map<String, String> agentComment =
                      getAgentCommentForItemName(itemsForArea, itemName);
                  String? agentCommentValue = agentComment['agentComment'];

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
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  cleanValue!,
                                                  style:
                                                      TextStyle(fontSize: 18.0),
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
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  undamagedValue!,
                                                  style:
                                                      TextStyle(fontSize: 18.0),
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
                                          updateItemCondition(
                                              index, 'Working', workingValue!);
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
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  workingValue!,
                                                  style:
                                                      TextStyle(fontSize: 18.0),
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
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: agentCommentValue,
                                  ),
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
        ],
      ),
    );
  }

  void _saveData(BuildContext context) async {
    // if (nameController.text.isNotEmpty) {
    // Create a new reportData with the data from nameController and descriptionController
    final response = {
      "name": "kitchen",
      "notes": "",
      "photosNotes": "",
      "tenantComment": "",
      "isDeleted": false,
      "items": [
        {
          "name": "Doors/walls/ceiling",
          "agentComment": "",
          "otherComment": "",
          "isDeleted": false,
          "conditions": [
            {"name": "Clean", "value": "Y"},
            {"name": "Undamaged", "value": ""},
            {"name": "Working", "value": ""}
          ]
        },
        // Add more items as needed
      ]
    };

    final areaName = response["name"];
    final isDeleted = response["isDeleted"];
    final items = response["items"] as List<Map<String, dynamic>>;

    for (final item in items) {
      final itemName = item["name"];
      final agentComment = item["agentComment"];
      final isItemDeleted = item["isDeleted"];
      final conditions = item["conditions"] as List<Map<String, dynamic>>;

      print("Area Name: $areaName");
      print("Is Deleted: $isDeleted");
      print("Item Name: $itemName");
      print("Agent Comment: $agentComment");
      print("Is Item Deleted: $isItemDeleted");

      for (final condition in conditions) {
        final conditionName = condition["name"];
        final conditionValue = condition["value"];

        print("Condition Name: $conditionName");
        print("Condition Value: $conditionValue");
      }
    }
    try {
      await saveReportData(widget.inspectId, widget.reportId);
      Navigator.pop(context);
    } catch (e) {}
  }
}
