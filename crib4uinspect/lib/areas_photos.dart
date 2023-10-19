import 'dart:convert';
import 'dart:io';
import 'package:crib4uinspect/areas_notes.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/report.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http/http.dart' as http;

class photos extends StatefulWidget {
  const photos({super.key, required this.title});
  final String title;
  @override
  State<photos> createState() => _photosState();
}

class _photosState extends State<photos> {
  List<File> uploadedImages = [];

  Future<void> _selectAndUploadImage() async {
    final pickedImage = await ImagePickerWeb.getImageInfo;

    if (pickedImage != null) {
      final imageData = pickedImage.data;
      final fileName = pickedImage.fileName;

      final file = File(fileName!);

      setState(() {
        uploadedImages.add(file);
      });

      // Save the image to the server using API
      // final response = await http.post(
      //   Uri.parse('YOUR_API_URL'),
      //   body: {
      //     'image': base64Encode(imageBytes),
      //   },
      // );

      // if (response.statusCode == 200) {
      //   // Image uploaded successfully, handle the API response
      //   final apiResponse = jsonDecode(response.body);
      //   // ...
      // } else {
      //   // Error occurred while uploading the image
      //   // Handle the error
      // }
    }
  }

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
            // Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => report()
            //           ),
            //         );
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
            icon: Icon(Icons.copy),
            onPressed: () {},
          ),
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
          SizedBox(height: 80.0),
          Center(
            child: Container(
              width: 406.0,
              height: 555.0,
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
                  Stack(children: [
                    DottedBorder(
                      borderType: BorderType.Rect,
                      radius: Radius.circular(12),
                      padding: EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                        child: Container(
                          height: 180,
                          width: 384,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => _selectAndUploadImage(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Text("Drop Files here",
                                style: TextStyle(
                                  color: Color.fromRGBO(116, 105, 245, 1),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text("or",
                                style: TextStyle(
                                  color: Color.fromRGBO(187, 182, 245, 0.973),
                                )),
                            ElevatedButton(
                              onPressed: () {
                                //_selectAndUploadImage();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                backgroundColor:
                                    Color.fromRGBO(162, 154, 255, 1),
                                textStyle: TextStyle(fontSize: 18.0),
                              ),
                              child: Text('Select Files'),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: uploadedImages.length,
                      itemBuilder: (context, index) {
                        final uploadedImage = uploadedImages[index];

                        return ListTile(
                          leading: Image.network(
                            uploadedImage.path,
                            width: 50,
                            height: 50,
                          ),
                          // title: Text(uploadedImage.name),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'images/image 132.png',
                    ),
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
