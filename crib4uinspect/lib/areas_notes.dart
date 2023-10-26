import 'package:crib4uinspect/areas_photos.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/report.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notes extends StatefulWidget {
  final String title;
  List<Map<String, dynamic>> passNotes;
  notes({super.key, required this.title, required this.passNotes});

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
    notesController.text = notess!; // Set the value for Notes
    tenantCommentController.text = tenantComment!;
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => photos(
                          title: widget.title,
                          passPhotos: [],
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
        ],
      ),
    );
  }
}
