import 'package:crib4uinspect/areas_notes.dart';
import 'package:crib4uinspect/areas_photos.dart';
import 'package:crib4uinspect/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class areas extends StatefulWidget {
  const areas({super.key, required this.title});
  final String title;
  @override
  State<areas> createState() => _areasState();
}

enum Selection {
  Yes,
  No,
  None,
}

class _areasState extends State<areas> {
  final List<String> items = [
    '                  ',
    'Door/Walls/Ceiling',
    'Windows/Screens',
    'Blinds/Curtains',
    'Fans/Light Fittings',
    'Floor/Floor coverings',
    'Power points',
    'other'
  ];
  Selection selectedOption = Selection.None;

  late final String title = widget.title;

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
              height: 555.0,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      style: ListTileStyle.list,
                      title: Text(
                        items[index],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(102, 88, 252, 1),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedOption == Selection.Yes) {
                                  selectedOption = Selection.No;
                                } else if (selectedOption == Selection.No) {
                                  selectedOption = Selection.None;
                                } else {
                                  selectedOption = Selection.Yes;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(162, 154, 255, 1),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  selectedOption == Selection.Yes
                                      ? 'Y'
                                      : selectedOption == Selection.No
                                          ? 'N'
                                          : '',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedOption == Selection.Yes) {
                                  selectedOption = Selection.No;
                                } else if (selectedOption == Selection.No) {
                                  selectedOption = Selection.None;
                                } else {
                                  selectedOption = Selection.Yes;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(162, 154, 255, 1),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  selectedOption == Selection.Yes
                                      ? 'Y'
                                      : selectedOption == Selection.No
                                          ? 'N'
                                          : '',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedOption == Selection.Yes) {
                                  selectedOption = Selection.No;
                                } else if (selectedOption == Selection.No) {
                                  selectedOption = Selection.None;
                                } else {
                                  selectedOption = Selection.Yes;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(162, 154, 255, 1),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  selectedOption == Selection.Yes
                                      ? 'Y'
                                      : selectedOption == Selection.No
                                          ? 'N'
                                          : '',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Color.fromRGBO(162, 154, 255, 1),
                            ),
                          )
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
}
