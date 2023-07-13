import 'package:crib4uinspect/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class compliance extends StatefulWidget {
  const compliance({super.key});

  @override
  State<compliance> createState() => _complianceState();
}

class _complianceState extends State<compliance> {
  List<bool> _isExpandedList = [false, false, false, false, false, false];
  final List<String> items = [
    'Property Information',
    'Health Issues',
    'Communication Facilities',
    'Water Efficiency Device',
    'Work Last Done',
    'Landlord' 's promise to undertake work ',
  ];
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
                builder: (context) => report(),
              ),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Utilities",
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
              // Handle search button press
            },
          ),
          IconButton(
            icon: Icon(CupertinoIcons.create),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 6,
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
                    
                    title: Text(
                      items[index],
                    ),
                  );
                },
                body: ListTile(
                  title: Text('Comments'),
                ),
                isExpanded: _isExpandedList[index],
              ),
            ],
          );
        },
      ),
    );
  }
}
