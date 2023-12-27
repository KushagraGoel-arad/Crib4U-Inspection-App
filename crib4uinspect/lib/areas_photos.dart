import 'dart:convert';
import 'dart:io';
import 'package:crib4uinspect/areas_notes.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/report.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:http/http.dart' as http;

class photos extends StatefulWidget {
  const photos(
      {super.key,
      required this.title,
      this.accessToken,
      this.reportId,
      this.propertyId,
      this.inspectionid});
  final String? accessToken;
  final String? reportId;
  final String? propertyId;
  final String? inspectionid;
  final String title;
  @override
  State<photos> createState() => implementations();
}

class implementations extends State<photos> {
  List<File> uploadedImages = [];
//! earlier implemetation

  // Future<void> _selectAndUploadImage() async {
  //   final pickedImage = await ImagePickerWeb.getImageInfo;

  //   if (pickedImage != null) {
  //     final imageData = pickedImage.data;
  //     final fileName = pickedImage.fileName;

  //     final file = File(fileName!);

  //     setState(() {
  //       uploadedImages.add(file);
  //     });

  //     // Save the image to the server using API
  //     // final response = await http.post(
  //     //   Uri.parse('YOUR_API_URL'),
  //     //   body: {
  //     //     'image': base64Encode(imageBytes),
  //     //   },
  //     // );

  //     // if (response.statusCode == 200) {
  //     //   // Image uploaded successfully, handle the API response
  //     //   final apiResponse = jsonDecode(response.body);
  //     //   // ...
  //     // } else {
  //     //   // Error occurred while uploading the image
  //     //   // Handle the error
  //     // }
  //   }
  // }

  //! new implemention
  Future<void> _selectAndUploadImage() async {
    final pickedImage = await ImagePickerWeb.getImageInfo;

    if (pickedImage != null) {
      final imageData = pickedImage.data;
      final fileName = pickedImage.fileName;
      final file = File(fileName!);

      setState(() {
        uploadedImages.add(file);
      });

      print(
          "Image selected: $fileName"); // Print the file name for confirmation

      // Call the upload function with the file and its name
      print("Calling _uploadImage() with file: $file");
      await _uploadImage(file, fileName);
    } else {
      print("No image was selected"); // If no image is picked
    }
  }

  Future<void> _uploadImage(File imageFile, String fileName) async {
    try {
      final headers = {
        'Content-Type': 'multipart/form-data',
        'accessToken': '${widget.accessToken}', // Use actual access token
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/${widget.propertyId}/${widget.inspectionid}/${widget.reportId}'),
      );

      request.headers.addAll(headers);

      // Read the image file as a list of bytes
      final imageBytes = await imageFile.readAsBytes();

      request.files.add(http.MultipartFile.fromBytes(
        'images',
        imageBytes,
        filename: fileName, // Use the fileName from the image picker
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        print("Image uploaded successfully");
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => report()),
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
            icon: Icon(Icons.copy),
            onPressed: () {
              _selectAndUploadImage(); //! change
            },
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
                        builder: (context) => areas(
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
