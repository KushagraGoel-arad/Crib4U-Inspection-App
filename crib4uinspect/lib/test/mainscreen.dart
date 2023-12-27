import 'package:crib4uinspect/test/active.dart';
import 'package:crib4uinspect/test/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InspectionScreen extends StatefulWidget {
  final String? accessToken;
  final String? refreshToken;

  const InspectionScreen({super.key, this.accessToken, this.refreshToken});
  @override
  _InspectionScreenState createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          backgroundColor: Color.fromRGBO(162, 154, 255, 1),
          leading: IconButton(
            icon: Icon(CupertinoIcons.calendar_badge_plus),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Not implemented yet'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          title: Text(
            'Inspection',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 40.0,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.create),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Not implemented yet'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Scheduled'),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            ActiveScreen(
              accessToken: widget.accessToken,
            ),
            ScheduleData(
              accessToken: widget.accessToken,
            ),
          ],
        ),
      ),
    );
  }
}
