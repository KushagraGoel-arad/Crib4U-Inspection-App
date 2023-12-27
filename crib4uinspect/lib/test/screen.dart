import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ScreenTest extends StatefulWidget {
  final String? accessToken;
  final String? refreshToken;
  const ScreenTest({Key? key, this.accessToken, this.refreshToken})
      : super(key: key);

  @override
  State<ScreenTest> createState() => _ScreenTestState();
}

class _ScreenTestState extends State<ScreenTest> {
  List<Map<String, dynamic>> _tableRows = [];

  Future<void> activestate() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Inspections'),
      ),
      body: ListView.builder(
        itemCount: _tableRows.length,
        itemBuilder: (context, index) {
          final item = _tableRows[index];
          return Card(
            child: ExpansionTile(
              title: Text(item['property'] ?? 'No Property'),
              subtitle: Text(item['summary'] ?? 'No Summary'),
              leading: Text(item['inspectionOn'] ?? 'No Date'),
              children: <Widget>[
                ListTile(
                  title: const Text('Manager'),
                  subtitle: Text(item['manager'] ?? 'No Manager'),
                ),
                ListTile(
                  title: const Text('Tenant'),
                  subtitle: Text(item['tenant'] ?? 'No Tenant'),
                ),
                ListTile(
                  title: const Text('Owner'),
                  subtitle: Text(item['owner'] ?? 'No Owner'),
                ),
                ListTile(
                  title: const Text('Created At'),
                  subtitle: Text(item['createdAt'] ?? 'No Creation Date'),
                ),
                ListTile(
                  title: const Text('Status'),
                  subtitle: Text(item['status'] ?? 'No Status'),
                ),
                ListTile(
                  title: const Text('Duration'),
                  subtitle: Text(item['duration'] ?? 'No Duration'),
                ),
                // Add more ListTiles here for additional parameters
              ],
            ),
          );
        },
      ),
      // This is where the Scaffold widget ends
    ); 
  }
}
