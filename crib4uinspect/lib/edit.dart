import 'package:crib4uinspect/inspection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class edit extends StatefulWidget {
  const edit({super.key});

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  final List<String> items = [
    'Shared with User',
  ];
  final List<String> item1 = [
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
  final List<String> item5 = [
    'Kitchen',
  ];
  final List<String> item6 = [
    'Dining Room',
  ];
  final List<String> item7 = [
    'Lounge Room',
  ];
  final List<String> item8 = [
    'Laundry',
  ];
  final List<String> item9 = [
    'Bedroom 2',
  ];
  final List<String> item10 = [
    'Bedroom 1',
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
              Navigator.pop(context);
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
          actions: [Text("Done", style: TextStyle(color: Colors.white))],
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
                      child: ListTile(
                        // leading: IconButton(
                        //   icon: Icon(CupertinoIcons.minus_circle_fill,
                        //       color: Colors.red),
                        //   onPressed: () {},
                        // ),
                        title: Text(
                          items[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item1[index];

                    return Card(
                      child: ListTile(
                        // leading: IconButton(
                        //   icon: Icon(CupertinoIcons.minus_circle_fill,
                        //       color: Colors.red),
                        //   onPressed: () {},
                        // ),
                        title: Text(
                          item1[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item2[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.minus_circle_fill,
                              color: Colors.red),
                          onPressed: () {},
                        ),
                        title: Text(
                          item2[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item3[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.minus_circle_fill,
                              color: Colors.red),
                          onPressed: () {},
                        ),
                        title: Text(
                          item3[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item4[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(
                            CupertinoIcons.minus_circle_fill,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                        title: Text(
                          item4[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 400,
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
                height: 60,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final listItem = item5[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.minus_circle_fill,
                              color: Colors.red),
                          onPressed: () {},
                        ),
                        title: Text(
                          item5[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item6[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.minus_circle_fill,
                              color: Colors.red),
                          onPressed: () {},
                        ),
                        title: Text(
                          item6[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item7[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.minus_circle_fill,
                              color: Colors.red),
                          onPressed: () {},
                        ),
                        title: Text(
                          item7[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item8[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.minus_circle_fill,
                              color: Colors.red),
                          onPressed: () {},
                        ),
                        title: Text(
                          item8[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item9[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.minus_circle_fill,
                              color: Colors.red),
                          onPressed: () {},
                        ),
                        title: Text(
                          item9[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
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
                    final listItem = item10[index];

                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.minus_circle_fill,
                              color: Colors.red),
                          onPressed: () {},
                        ),
                        title: Text(
                          item10[index],
                          style: TextStyle(fontSize: 18.0),
                        ),
                        trailing: Icon(
                          CupertinoIcons.line_horizontal_3,
                          color: Color.fromRGBO(162, 154, 255, 1),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
        ));
  }
}
