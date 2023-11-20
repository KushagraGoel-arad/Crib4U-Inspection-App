import 'dart:convert';
import 'package:crib4uinspect/basic_details.dart';
import 'package:crib4uinspect/tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'areaadd.dart';
import 'package:universal_html/html.dart' as html;

class inspect extends StatefulWidget {
  final String? accessToken;
  final String? refreshToken;

  const inspect({Key? key, this.accessToken, this.refreshToken})
      : super(key: key);

  @override
  State<inspect> createState() => _inspectState();
}

class _inspectState extends State<inspect> {
  List<String> items = ["Active", "Schedule", "Inspected"];
  int current = 0;
  List<Task> tasks = [];
  List<Map<String, dynamic>> _tableRows = [];
  Map<String, dynamic> _inspectDetailObj = {};
  Map<String, dynamic> _inspectReportObj = {};
  Map<String, dynamic> _complainceOrUtilities = {};
  Map<String, dynamic> inspection = {};
  List<Map<String, dynamic>>? activeData;
  // String? accessToken = _login_pageState().getAccessToken();
  //   String? refreshToken = _login_pageState().getRefreshToken();
  DateTime? parseDateTime(dynamic value) {
    if (value == null) {
      return null;
    }
    return DateTime.parse(value);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   active();
  // }

  Future<List<Map<String, dynamic>>> active() async {
    final headers = {
      'Content-Type': 'application/json',
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      'Pragma': 'no-cache',
      'accessToken': '${html.window.sessionStorage['accessToken']}',
    };

    var response = await http.get(
      Uri.https(
        'crib4u.axiomprotect.com:9497',
        '/api/prop_gateway/inspect/list/active',
      ),
      headers: headers,
    );

    //print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      _tableRows.clear(); // Clear the previous data

      List<dynamic> jData = jsonData['details'];
      if (jData.length > 0) {
        for (int i = 0; i < jData.length; i++) {
          dynamic _obj = jData[i];
          String inspectionId = _obj['_id'];

          String propertyName =
              '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
          String tenantName =
              '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
          String managerName =
              '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';

          DateTime date = DateTime.parse(_obj['date']);
          DateTime startTime = DateTime.parse(_obj['date']);
          DateTime createAt = DateTime.parse(_obj['createdAt']);

          _tableRows.add({
            '_id': inspectionId,
            'inspectionOn':
                '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm a').format(startTime)}',
            'type': _obj['type'],
            'summary': _obj['summary'],
            'property': propertyName,
            'manager': managerName,
            'tenant': tenantName,
            'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
          });
        }
      }

      return _tableRows;
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> schedule() async {
    final headers = {
      'Content-Type': 'application/json',
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      'Pragma': 'no-cache',
      'accessToken': '${html.window.sessionStorage['accessToken']}',
    };

    var response = await http.get(
      Uri.https(
        'crib4u.axiomprotect.com:9497',
        '/api/prop_gateway/inspect/list/schedule',
      ),
      headers: headers,
    );

    //print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      _tableRows.clear(); // Clear the previous data

      List<dynamic> jData = jsonData['details'];
      if (jData.length > 0) {
        for (int i = 0; i < jData.length; i++) {
          dynamic _obj = jData[i];
          String inspectionId = _obj['_id'];

          String propertyName =
              '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
          String tenantName =
              '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
          String managerName =
              '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';

          DateTime date = DateTime.parse(_obj['date']);
          DateTime startTime = DateTime.parse(_obj['date']);
          DateTime createAt = DateTime.parse(_obj['createdAt']);

          _tableRows.add({
            '_id': inspectionId,
            'inspectionOn':
                '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm a').format(startTime)}',
            'type': _obj['type'],
            'summary': _obj['summary'],
            'property': propertyName,
            'manager': managerName,
            'tenant': tenantName,
            'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
          });
        }
      }

      return _tableRows;
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> inspected() async {
    final headers = {
      'Content-Type': 'application/json',
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      'Pragma': 'no-cache',
      'accessToken': '${html.window.sessionStorage['accessToken']}'
    };

    var response = await http.get(
      Uri.https(
        'crib4u.axiomprotect.com:9497',
        '/api/prop_gateway/inspect/list/inspected',
      ),
      headers: headers,
    );

    //print(response.body);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      _tableRows.clear(); // Clear the previous data

      List<dynamic> jData = jsonData['details'];
      if (jData.length > 0) {
        for (int i = 0; i < jData.length; i++) {
          dynamic _obj = jData[i];
          String inspectionId = _obj['_id'];

          String propertyName =
              '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
          String tenantName =
              '${_obj['tenant']['users'][0]['name']['firstName'] ?? ''} ${_obj['tenant']['users'][0]['name']['lastName'] ?? ''}';
          String managerName =
              '${_obj['manager']['name']['firstName'] ?? ''} ${_obj['manager']['name']['lastName'] ?? ''}';

          DateTime date = DateTime.parse(_obj['date']);
          DateTime startTime = DateTime.parse(_obj['date']);
          DateTime createAt = DateTime.parse(_obj['createdAt']);

          _tableRows.add({
            '_id': inspectionId,
            'inspectionOn':
                '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm a').format(startTime)}',
            'type': _obj['type'],
            'summary': _obj['summary'],
            'property': propertyName,
            'manager': managerName,
            'tenant': tenantName,
            'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
          });
        }
      }
      return _tableRows;
    }
    return [];
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the error dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> detailsOfInspection(String inspectionId) async {
    final headers = {
      'Content-Type': 'application/json',
      'accessToken': '${html.window.sessionStorage['accessToken']}',
      'refreshToken': '${widget.refreshToken}' // Use accessToken from widget
    };
    var response = await http.get(
      Uri.https(
        'crib4u.axiomprotect.com:9497',
        '/api/prop_gateway/inspect/getInspectReportDetails/$inspectionId',
      ),
      headers: headers,
    );

    //print(response.body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['resultCode'] == 1) {
        final basicDetails = jsonData['details']['BasicDetails'];
        final reportDetails = jsonData['details']['ReportDetails'];

        final _obj = basicDetails;
        final _objReport = reportDetails;

        List<Areas> areasList = [];
        final areasData = reportDetails['areas'];

        if (areasData is List<dynamic>) {
          areasList = areasData.map((areaData) {
            final items1 = extractItems(areaData);
            print("ITEMS DATAAAAA: $items1");
            // final conditions = extractConditions(areaData);

            List<Area> item2 = items1.map((itemData) {
              final conditions = extractConditions(itemData);
              return Area(
                name: itemData?['name'] ?? '',
                agentComment: itemData?['agentComment'] ?? '',
                otherComment: itemData?['otherComment'] ?? '',
                isDeleted: itemData?['isDeleted'] as bool ?? false,
                conditions: conditions,
              );
            }).toList();

            return Areas(
              name: areaData['name'] ?? '',
              notes: areaData['notes'] ?? '',
              photosNotes: areaData['photosNotes'] ?? '',
              tenantComment: areaData['tenantComment'] ?? '',
              isDeleted: areaData['isDeleted'] as bool ?? false,
              items: item2,
              photos: areaData['photos'] ?? '',
            );
          }).toList();

          // Rest of your code
        } else {
          // Handle the case where areasData is not of the expected type.
          // You can throw an error or return a default value.
        }

        String inspectionId = _obj['_id'];
        String inspectionId1 = _objReport['_id'];

        bool signs_moulds_dampness =
            _objReport['complianceOrUtility']['signs_moulds_dampness'];
        bool pests_vermin = _objReport['complianceOrUtility']['pests_vermin'];
        bool rubbish_bin_left_premises =
            _objReport['complianceOrUtility']['rubbish_bin_left_premises'];
        bool telephone_line_premises =
            _objReport['complianceOrUtility']['telephone_line_premises'];
        bool internet_line_premises =
            _objReport['complianceOrUtility']['internet_line_premises'];
        bool shower_wtr_rate_ltr_minute =
            _objReport['complianceOrUtility']['shower_wtr_rate_ltr_minute'];
        bool internal_basins_wtr_rate_ltr_minute =
            _objReport['complianceOrUtility']
                ['internal_basins_wtr_rate_ltr_minute'];
        bool no_licking_taps =
            _objReport['complianceOrUtility']['no_licking_taps'];
        String water_meter_reading =
            '${_objReport['complianceOrUtility']['water_meter_reading']}';
        String cleaning_repair_notes =
            '${_objReport['complianceOrUtility']['cleaning_repair_notes']}';

        DateTime? instalation_wtr_measures_on = parseDateTime(
            _objReport['complianceOrUtility']['instalation_wtr_measures_on']);
        DateTime? paint_premises_external_on = parseDateTime(
            _objReport['complianceOrUtility']['paint_premises_external_on']);
        DateTime? paint_premises_internal_on = parseDateTime(
            _objReport['complianceOrUtility']['paint_premises_internal_on']);
        DateTime? landlord_aggred_work_on = parseDateTime(
            _objReport['complianceOrUtility']['landlord_aggred_work_on']);
        DateTime? flooring_clean_replaced_on = parseDateTime(
            _objReport['complianceOrUtility']['flooring_clean_replaced_on']);

        bool sharedWithOwner =
            _objReport['overviewDetails']['isSharedWithOwner'];
        bool sharedWithTenant =
            _objReport['overviewDetails']['isSharedWithTenant'];
        String rentReview = '${_objReport['overviewDetails']['rentReview']}';
        String followUp = '${_objReport['followupActions']}';
        String notes = '${_objReport['notes']}';

        String propertyName =
            '${_obj['property']['property_basic_details']['address']['line_one']} ${_obj['property']['property_basic_details']['address']['line_two']}';
        String propertyId = '${_obj['property']['_id']}';
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
          _complainceOrUtilities = {
            '_id': inspectionId,
            // 'date':
            //     '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm').format(startTime)}',

            'signs_moulds_dampness': signs_moulds_dampness,
            'pests_vermin': pests_vermin,
            'rubbish_bin_left_premises': rubbish_bin_left_premises,
            'telephone_line_premises': telephone_line_premises,
            'internet_line_premises': internet_line_premises,
            'shower_wtr_rate_ltr_minute': shower_wtr_rate_ltr_minute,
            'internal_basins_wtr_rate_ltr_minute':
                internal_basins_wtr_rate_ltr_minute,
            'no_licking_taps': no_licking_taps,
            'water_meter_reading': water_meter_reading,
            'cleaning_repair_notes': cleaning_repair_notes,
            'instalation_wtr_measures_on': instalation_wtr_measures_on != null
                ? DateFormat('dd-MM-yyyy').format(instalation_wtr_measures_on)
                : null,
            'paint_premises_external_on': paint_premises_external_on != null
                ? DateFormat('dd-MM-yyyy').format(paint_premises_external_on)
                : null,
            'paint_premises_internal_on': paint_premises_internal_on != null
                ? DateFormat('dd-MM-yyyy').format(paint_premises_internal_on)
                : null,
            'landlord_aggred_work_on': landlord_aggred_work_on != null
                ? DateFormat('dd-MM-yyyy').format(landlord_aggred_work_on)
                : null,
            'flooring_clean_replaced_on': flooring_clean_replaced_on != null
                ? DateFormat('dd-MM-yyyy').format(flooring_clean_replaced_on)
                : null,
            // 'owner': ownerName,
            // 'status': _obj['status'],
            // 'duration': _obj['duration'],
            // 'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
          };

          _inspectReportObj = {
            'areas': areasList,
            '_id': inspectionId,
            // 'date':
            //     '${DateFormat('dd-MM-yyyy').format(date)} ${DateFormat('hh:mm').format(startTime)}',
            'ReportDetails': reportDetails,

            'rentReview': rentReview,
            'followupActions': followUp,
            'notes': notes,
            'isSharedWithTenant': sharedWithTenant,
            'isSharedWithOwner': sharedWithOwner,
            // 'owner': ownerName,
            // 'status': _obj['status'],
            // 'duration': _obj['duration'],
            // 'createdAt': DateFormat('dd-MM-yyyy hh:mm a').format(createAt),
          };

          _inspectDetailObj = {
            '_id': inspectionId1,
            '_id1': propertyId,
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
          };
          inspection = {'areadata': areasList};

          // Now you have the Inspection object for further use
          //print("ABCRESGGG:$inspection");
        });
      } else {
        showErrorDialog('${response.statusCode}');
      }
    }
  }

  List<Condition> extractConditions(Map<String, dynamic> itemData) {
    //final itemsData = areaData['items'] as List<dynamic>;
    final List<Condition> allConditions = [];

    //for (var itemData in itemsData) {
    final conditionsData = itemData['conditions'] as List<dynamic>;
    final conditions = conditionsData.map((conditionData) {
      return Condition(
        name: conditionData['name'],
        value: conditionData['value'],
      );
    }).toList();
    allConditions.addAll(conditions);
    // }

    return allConditions;
  }

  List<dynamic> extractItems(Map<String, dynamic> areaData) {
    final itemsData = areaData['items'] as List<dynamic>;
    
    return itemsData;
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
            icon: Icon(Icons.logout_rounded),
            onPressed: () {
              html.window.sessionStorage.clear();
              Navigator.pop(context);
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
                        if (index == 0) {
                          active().then((data) {
                            setState(() {
                              current = index;
                              _tableRows = data;
                            });
                            //print("Data active: $data");
                          });
                        } else if (index == 1) {
                          schedule().then((data) {
                            setState(() {
                              current = index;
                              _tableRows = data;
                            });
                            // print("Data inspected: $data");
                          });
                        } else if (index == 2) {
                          inspected().then((data) {
                            setState(() {
                              current = index;
                              _tableRows = data;
                            });
                            //print("Data inspected: $data");
                          });
                        }
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
                        onTap: () async {
                          String inspectionId = data['_id'];
                          await detailsOfInspection(
                              inspectionId); // Call your API or any other action
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => basicDetails(
                                areasList: _inspectReportObj['areas'],
                                repDetails: _inspectReportObj['ReportDetails'],
                                jwt: html.window.sessionStorage['accessToken'],
                                inspectionId1: _inspectDetailObj['_id'],
                                inspectionId: _inspectReportObj['_id'],
                                propertyId: _inspectDetailObj['_id1'],
                                rentReview: _inspectReportObj['rentReview'],
                                followupActions:
                                    _inspectReportObj['followupActions'],
                                notes: _inspectReportObj['notes'],
                                isSharedWithOwner:
                                    _inspectReportObj['isSharedWithOwner'],
                                isSharedWithTenant:
                                    _inspectReportObj['isSharedWithTenant'],
                                type: _inspectDetailObj['type'] ?? '',
                                startTime: _inspectDetailObj['startTime'] ?? '',
                                endTime: _inspectDetailObj['endTime'] ?? '',
                                date: _inspectDetailObj['date'] ?? '',
                                summary: _inspectDetailObj['summary'] ?? '',
                                property: _inspectDetailObj['property'] ?? '',
                                manager: _inspectDetailObj['manager'] ?? '',
                                tenant: _inspectDetailObj['tenant'] ?? '',
                                createdAt: _inspectDetailObj['createdAt'] ?? '',
                                owner: _inspectDetailObj['owner'] ?? '',
                                status: _inspectDetailObj['status'] ?? '',
                                duration: _inspectDetailObj['duration'] ?? '',
                                signs_moulds_dampness: _complainceOrUtilities[
                                    'signs_moulds_dampness'],
                                pests_vermin:
                                    _complainceOrUtilities['pests_vermin'],
                                rubbish_bin_left_premises:
                                    _complainceOrUtilities[
                                        'rubbish_bin_left_premises'],
                                telephone_line_premises: _complainceOrUtilities[
                                    'telephone_line_premises'],
                                internet_line_premises: _complainceOrUtilities[
                                    'internet_line_premises'],
                                shower_wtr_rate_ltr_minute:
                                    _complainceOrUtilities[
                                        'shower_wtr_rate_ltr_minute'],
                                internal_basins_wtr_rate_ltr_minute:
                                    _complainceOrUtilities[
                                        'internal_basins_wtr_rate_ltr_minute'],
                                no_licking_taps:
                                    _complainceOrUtilities['no_licking_taps'],
                                water_meter_reading: _complainceOrUtilities[
                                    'water_meter_reading'],
                                cleaning_repair_notes: _complainceOrUtilities[
                                    'cleaning_repair_notes'],
                                instalation_wtr_measures_on:
                                    _complainceOrUtilities[
                                        'instalation_wtr_measures_on'],
                                paint_premises_external_on:
                                    _complainceOrUtilities[
                                        'paint_premises_external_on'],
                                paint_premises_internal_on:
                                    _complainceOrUtilities[
                                        'paint_premises_internal_on'],
                                landlord_aggred_work_on: _complainceOrUtilities[
                                    'landlord_aggred_work_on'],
                                flooring_clean_replaced_on:
                                    _complainceOrUtilities[
                                        'flooring_clean_replaced_on'],
                                areaData: inspection['areadata'],
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromRGBO(127, 117, 240, 1),
      //   splashColor: Color.fromRGBO(162, 154, 255, 1),
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     // _addTask();
      //   },
      // ),
    );
  }
}
