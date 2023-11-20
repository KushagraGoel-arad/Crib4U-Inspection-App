import 'dart:async';

import 'package:universal_html/html.dart' as html;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http_parser/http_parser.dart';
import 'areaadd.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html' as html;
import 'dart:html' as html;
import 'dart:typed_data';

class Area51 {
  final String name;
  final String description;
  final List<dynamic> imagePath;

  Area51({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

class AddAreaScreen extends StatefulWidget {
  final String areaName;
  String inspID;
  String reportID;
  String? jwttoken;
  final String? propId;
  Map<String, dynamic> reportDetails;
  List<Areas> areaList;
  String? photonotes;
  String? notes;

  AddAreaScreen({
    required this.areaName,
    required this.inspID,
    required this.reportID,
    this.jwttoken,
    required this.propId,
    required this.reportDetails,
    required this.areaList,
    required this.photonotes,
    required this.notes,
  });

  @override
  _AddAreaScreenState createState() => _AddAreaScreenState();
}

class _AddAreaScreenState extends State<AddAreaScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Uint8List> imageFiles = []; // To store the selected image files
  List<dynamic> imagePath = [];

  @override
  void initState() {
    super.initState();
    updateSelectedArea(0);
  }

  void updateSelectedArea(int index) {
    nameController.text = widget.areaList[index].notes ?? '';
    descriptionController.text = widget.areaList[index].photosNotes ?? '';
  }

  Future<void> postImages(http.Client client, String inspID, String reportID,
      String? propId, String? name1,
      {required List<Uint8List> images}) async {
    try {
      final url = Uri.parse(
        'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propId/$inspID/$reportID',
      );

      final request = http.MultipartRequest('POST', url);

      if (images.isNotEmpty) {
        for (var i = 0; i < images.length; i++) {
          final fileName = 'image_$i.jpeg';
          final imageBytes = images[i];

          final multipartFile = http.MultipartFile.fromBytes(
            'images',
            imageBytes,
            filename: fileName,
            contentType: MediaType('image', 'jpeg'),
          );
          request.files.add(multipartFile);
        }
      } else {
        throw Exception('No images provided');
      }

      request.fields['areaName'] = name1 ?? '';
      request.headers['accesstoken'] =
          html.window.sessionStorage['accessToken'] ?? '';
      request.headers['Content-Type'] = 'multipart/form-data';

      print("Request URL: ${request.url}");
      print("Request Headers: ${request.headers}");
      print("Request Fields: ${request.fields}");

      final response = await client.send(request);

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        imagePath = json.decode(responseBody)['details'];
        print("Image path: $imagePath");
      } else {
        throw Exception(
          'Failed to upload images. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error in postImages: $e');
      throw e;
    }
  }

  Future<void> saveReportData(String inspID, String reportID) async {
    final url = Uri.parse(
      'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspID/$reportID',
    );

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accessToken': '${html.window.sessionStorage['accessToken']}',
        },
        body: jsonEncode({
          'ReportDetails': widget.reportDetails,
        }),
      );

      if (response.statusCode == 200) {
        // Report data saved successfully
      } else {
        // Failed to save report data
      }
    } catch (e) {
      // Handle exceptions
    }
  }

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
              widget.areaName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 37.0,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: widget.areaList[0].notes ?? '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _selectImages,
                child: Text('Select Images'),
              ),
            ),
            if (imageFiles.isNotEmpty)
              Column(
                children: imageFiles
                    .map(
                      (imageFile) => Container(
                        width: 300,
                        height: 200,
                        margin: EdgeInsets.all(10),
                        child: Image.memory(
                          imageFile,
                          width: 300,
                          height: 200,
                        ),
                      ),
                    )
                    .toList(),
              ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: widget.areaList[0].photosNotes ?? '',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () => _updateAreaData(context, 0),
                child: Text('Save Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectImages() async {
    final input = html.FileUploadInputElement()..multiple = true;
    input.click();

    input.onChange.listen((e) async {
      final fileList = input.files;
      if (fileList != null && fileList.isNotEmpty) {
        final List<Uint8List> selectedImages = [];
        for (final file in fileList) {
          final completer = Completer<Uint8List>();
          final reader = html.FileReader();

          reader.onLoadEnd.listen((e) {
            completer.complete(Uint8List.fromList(reader.result as List<int>));
          });

          reader.readAsArrayBuffer(file);
          selectedImages.add(await completer.future);
        }

        setState(() {
          imageFiles = selectedImages;
        });

        _saveArea(context);
      }
    });
  }

  void _updateAreaData(BuildContext context, int index) async {
    if (nameController.text.isNotEmpty) {
      if (widget.reportDetails.containsKey('areas') &&
          widget.reportDetails['areas'] is List) {
        var areasList = widget.reportDetails['areas'] as List;
        var areaIndex =
            areasList.indexWhere((area) => area['name'] == widget.areaName);

        if (areaIndex != -1) {
          var areaToUpdate = areasList[areaIndex];
          areaToUpdate['notes'] = nameController.text;
          areaToUpdate['photonotes'] = descriptionController.text;
          //areaToUpdate['tenantComment'] = "";
          //areaToUpdate['items'] = [];
          areaToUpdate['photos'] = imagePath;
        }

        try {
          await saveReportData(widget.inspID, widget.reportID);
          Navigator.pop(context);
        } catch (e) {
          print('Error updating area data: $e');
        }
      }
    }
  }

  void _saveArea(BuildContext context) async {
    if (nameController.text.isNotEmpty) {
      final client = http.Client();
      try {
        final imagePath1 = await postImages(
          client,
          widget.inspID,
          widget.reportID,
          widget.propId,
          widget.areaName,
          images: imageFiles,
        );
        if (imagePath != null) {
          print("Image Pathhhhudhwuh: $imagePath");

          if (widget.reportDetails.containsKey('areas') &&
              widget.reportDetails['areas'] is List) {
            var areasList = widget.reportDetails['areas'] as List;
            var areaIndex =
                areasList.indexWhere((area) => area['name'] == widget.areaName);

            if (areaIndex != -1) {
              var areaToUpdate = areasList[areaIndex];
              areaToUpdate['photos'] = imagePath;
            }
            // print("Upload Images: $uploadedImages");
          }
        } else {
          print("Failed to upload image.");
        }
        // await saveReportData(widget.inspID, widget.reportID);
        // Navigator.pop(
        //   context,
        //   Area51(
        //     name: nameController.text,
        //     description: descriptionController.text,
        //     imagePath: imagePath,
        //   ),
        // );
      } catch (e) {
        print('Error saving area: $e');
        // You can handle the error or display an error message here.
      } finally {
        client.close(); // Close the client to release resources
      }
    } else {
      // Show an error message or handle the case when the name is empty.
    }
  }
}
