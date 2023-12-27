import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryReport extends StatefulWidget {
  final String? accessToken;
  final String? propertyId;

  const HistoryReport({Key? key, this.accessToken, this.propertyId})
      : super(key: key);

  @override
  State<HistoryReport> createState() => _HistoryReportState();
}

class _HistoryReportState extends State<HistoryReport> {
  List<Map<String, dynamic>> historyList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    historyReportDetailing();
  }

  Future<void> historyReportDetailing() async {
    final headers = {
      'Content-Type': 'application/json',
      'accessToken': '${widget.accessToken}', // Use accessToken from widget
    };
    var response = await http.get(
      Uri.https(
        'crib4u.axiomprotect.com:9497',
        '/api/prop_gateway/inspect/getReportList/${widget.propertyId}',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        historyList = List<Map<String, dynamic>>.from(jsonData['details']);
        isLoading = false;
      });
    } else {
      print("Failed to fetch data. Status Code: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Reports'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                var item = historyList[index];
                return Card(
                  child: ListTile(
                    title: Text('Type: ${item['type']}'),
                    subtitle: Text('Date: ${item['inspectionDate']}'),
                    trailing: Text('Status: ${item['status']}'),
                    onTap: () {
                      // You can add onTap functionality here
                    },
                  ),
                );
              },
            ),
    );
  }
}
