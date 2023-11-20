import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crib4uinspect/areas_notes.dart';
import 'package:crib4uinspect/diningRoom.dart';
import 'package:crib4uinspect/report.dart';
import 'package:crib4uinspect/reportEntryExit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class photos extends StatefulWidget {
  final String title;
  String? jwt = '';
  String inspectID1 = '';
  String reportID1 = '';

  List<Map<String, dynamic>> passPhotos;
  Map<String, dynamic> repdetail1 = {};
  String? propertID;
  List<Map<String, dynamic>>? areaDet;
  photos(
      {super.key,
      required this.title,
      required this.passPhotos,
      this.jwt,
      required this.repdetail1,
      required this.inspectID1,
      required this.reportID1,
      this.propertID,
      this.areaDet});

  @override
  State<photos> createState() => _photosState();
}

class _photosState extends State<photos> {
  List<String> uploadedImages = [];
  TextEditingController photosNotesController = TextEditingController();
  String areaName = '';
  String? imagePath;

  // void uploadImage(html.File file) {
  //   // Handle the uploaded image here (you can upload it to a server or display it).
  //   final imageUrl = html.Url.createObjectUrlFromBlob(file);
  //   setState(() {
  //     uploadedImages.add(imageUrl);
  //   });
  //   _saveArea(context);
  // }

  // void _selectAndUploadImages() async {
  //   final input = html.FileUploadInputElement()..multiple = true;
  //   input.click();

  //   input.onChange.listen((e) async {
  //     final fileList = input.files;
  //     if (fileList != null && fileList.isNotEmpty) {
  //       final List<String> selectedImages = [];
  //       for (final file in fileList) {
  //         final completer = Completer<String>();
  //         final reader = html.FileReader();

  //         reader.onLoadEnd.listen((e) {
  //           completer.complete(reader.result as String);
  //         });

  //         reader.readAsDataUrl(file);
  //         selectedImages.add(await completer.future);
  //       }

  //       // Save the selected images to your state or perform any other actions
  //       setState(() {
  //         uploadedImages.addAll(selectedImages);
  //       });

  //       // Now you can call your _saveArea method to upload images to the server
  //       _saveArea(context);
  //     }
  //   });
  // }
  // Future<String> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propertID,
  //   String? name1,
  //   List<String> imageBytes, // Base64-encoded image data
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propertID/$inspID/$reportID');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (imageBytes.isNotEmpty) {
  //       final filename = 'image.jpg';

  //       for (int i = 0; i < imageBytes.length; i++) {
  //         final imageBytesAsUint8List = Uint8List.fromList(
  //           base64.decode(imageBytes[i]),
  //         );
  //         final multipartFile = http.MultipartFile.fromBytes(
  //           'images',
  //           imageBytesAsUint8List,
  //           filename: '$filename$i',
  //         );
  //         request.files.add(multipartFile);
  //       }
  //     } else {
  //       throw Exception('No images provided');
  //     }

  //     request.fields['areaName'] = name1 ?? '';
  //     request.headers['accesstoken'] =
  //         html.window.sessionStorage['accessToken'] ?? '';
  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       final imagePath = json.decode(responseBody)['imagePath'];
  //       return imagePath;
  //     } else {
  //       throw Exception('Failed to upload images');
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<String?> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propertID,
  //   String? name1,
  //   List<String> imageBytes,
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propertID/$inspID/$reportID');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (imageBytes.isNotEmpty) {
  //       final filename = 'image.jpg';

  //       for (int i = 0; i < imageBytes.length; i++) {
  //         final imageBytesAsUint8List = Uint8List.fromList(
  //           base64.decode(imageBytes[i]),
  //         );
  //         final multipartFile = http.MultipartFile.fromBytes(
  //           'images',
  //           imageBytesAsUint8List,
  //           filename: '$filename$i',
  //         );
  //         request.files.add(multipartFile);
  //       }
  //     } else {
  //       throw Exception('No images provided');
  //     }

  //     request.fields['areaName'] = name1 ?? '';
  //     request.headers['accesstoken'] =
  //         html.window.sessionStorage['accessToken'] ?? '';

  //     final response = await request.send();
  //     final responseBody = await response.stream.bytesToString();

  //     if (response.statusCode == 200) {
  //       final imagePath = json.decode(responseBody)['imagePath'];
  //       return imagePath;
  //     } else {
  //       print('Failed to upload images. Status code: ${response.statusCode}');
  //       print('Response body: $responseBody');
  //       return null; // Return null or throw an exception based on your needs
  //     }
  //   } catch (e) {
  //     print('Error in postImages: $e');
  //     return null; // Return null or throw an exception based on your needs
  //   }
  // }
  // Future<String?> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propertID,
  //   String? name1,
  //   List<String> imageBytes,
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propertID/$inspID/$reportID');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (imageBytes.isNotEmpty) {
  //       final filename = 'image.jpg';

  //       for (int i = 0; i < imageBytes.length; i++) {
  //         final imageBytesAsUint8List = Uint8List.fromList(
  //           base64.decode(imageBytes[i]),
  //         );
  //         final multipartFile = http.MultipartFile.fromBytes(
  //           'images',
  //           imageBytesAsUint8List,
  //           filename: '$filename$i',
  //         );
  //         request.files.add(multipartFile);
  //       }
  //     } else {
  //       throw Exception('No images provided');
  //     }

  //     request.fields['areaName'] = name1 ?? '';
  //     request.headers['accesstoken'] =
  //         html.window.sessionStorage['accessToken'] ?? '';

  //     final response = await request.send();
  //     final responseBody = await response.stream.bytesToString();

  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: $responseBody');

  //     if (response.statusCode == 200) {
  //       final imagePath = json.decode(responseBody)['imagePath'];
  //       print('Image path: $imagePath');
  //       return imagePath;
  //     } else {
  //       print('Failed to upload images. Status code: ${response.statusCode}');
  //       print('Response body: $responseBody');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error in postImages: $e');
  //     return null;
  //   }
  // }

  ////

  // Future<String?> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propertID,
  //   String? name1,
  //   List<String> imageBytes,
  // ) async {
  //   try {
  //     // Construct the URL
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propertID/$inspID/$reportID');

  //     // Create a MultipartRequest
  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     // Check if images are provided
  //     if (imageBytes.isNotEmpty) {
  //       final filename = 'image.jpg';

  //       // Add each image to the request
  //       for (int i = 0; i < imageBytes.length; i++) {
  //         final cleanedBase64 =
  //             imageBytes[i].replaceAll(RegExp('[^a-zA-Z0-9+/]'), '');
  //         final imageBytesAsUint8List =
  //             Uint8List.fromList(base64.decode(cleanedBase64));
  //         final multipartFile = http.MultipartFile.fromBytes(
  //           'images',
  //           imageBytesAsUint8List,
  //           filename: '$filename$i',
  //         );
  //         request.files.add(multipartFile);
  //       }
  //     } else {
  //       // Throw an exception if no images are provided
  //       throw Exception('No images provided');
  //     }

  //     // Add additional fields and headers
  //     request.fields['areaName'] = name1 ?? '';
  //     request.headers['accesstoken'] =
  //         html.window.sessionStorage['accessToken'] ?? '';

  //     // Send the request and get the response
  //     final response = await request.send();

  //     // Read and decode the response body
  //     final responseBody = await response.stream.bytesToString();

  //     // Log response details
  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: $responseBody');

  //     // Check if the response status code is 200 (OK)
  //     if (response.statusCode == 200) {
  //       // Parse and return the imagePath
  //       final imagePath = json.decode(responseBody)['imagePath'];
  //       print('Image path: $imagePath');
  //       return imagePath;
  //     } else {
  //       // Log and return null if the request fails
  //       print('Failed to upload images. Status code: ${response.statusCode}');
  //       print('Response body: $responseBody');
  //       return null;
  //     }
  //   } catch (e) {
  //     // Log and return null in case of an error
  //     print('Error in postImages: $e');
  //     return null;
  //   }
  // }

  Future<void> saveReportData(String inspectID1, String reportID1) async {
    final url = Uri.parse(
      'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspectID1/$reportID1',
    );

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accessToken': '${html.window.sessionStorage['accessToken']}',
        },
        body: jsonEncode({
          'ReportDetails': widget.repdetail1
        }), // Convert the map directly to a JSON string
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

  void uploadImage(html.File file) {
    final imageUrl = html.Url.createObjectUrlFromBlob(file);
    setState(() {
      uploadedImages.add(imageUrl);
    });
    _saveArea(context);
  }

  void _selectAndUploadImages() async {
    final input = html.FileUploadInputElement()..multiple = true;
    input.click();

    input.onChange.listen((e) async {
      final fileList = input.files;
      if (fileList != null && fileList.isNotEmpty) {
        final List<String> selectedImages = [];
        for (final file in fileList) {
          final completer = Completer<String>();
          final reader = html.FileReader();

          reader.onLoadEnd.listen((e) {
            completer.complete(reader.result as String);
          });

          reader.readAsDataUrl(file);
          selectedImages.add(await completer.future);
        }

        setState(() {
          uploadedImages.addAll(selectedImages);
        });

        _saveArea(context);
      }
    });
  }

  Future<String?> postImages(
    String inspID,
    String reportID,
    String? propertID,
    String? name1,
    List<String> imageBytes,
  ) async {
    try {
      final url = Uri.parse(
          'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propertID/$inspID/$reportID');

      final request = http.MultipartRequest('POST', url);

      if (imageBytes.isNotEmpty) {
        final filename = 'image.jpg';

        for (int i = 0; i < imageBytes.length; i++) {
          final imageBytesAsUint8List = Uint8List.fromList(
            base64.decode(imageBytes[i].split(',').last),
          );
          final multipartFile = http.MultipartFile.fromBytes(
            'images',
            imageBytesAsUint8List,
            filename: '$filename$i',
          );
          request.files.add(multipartFile);
        }
      } else {
        throw Exception('No images provided');
      }

      request.fields['areaName'] = name1 ?? '';
      request.headers['accesstoken'] =
          html.window.sessionStorage['accessToken'] ?? '';

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('Response status code: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        final imagePath = json.decode(responseBody)['imagePath'];
        print('Image path: $imagePath');
        return imagePath;
      } else {
        print('Failed to upload images. Status code: ${response.statusCode}');
        print('Response body: $responseBody');
        return null;
      }
    } catch (e) {
      print('Error in postImages: $e');
      return null;
    }
  }

  void _saveArea(BuildContext context) async {
    try {
      final areaName = widget.title;

      final imagePath = await postImages(
        widget.inspectID1,
        widget.reportID1,
        widget.propertID,
        areaName,
        uploadedImages,
      );

      if (imagePath != null) {
        print("Image Path: $imagePath");

        if (widget.repdetail1.containsKey('areas') &&
            widget.repdetail1['areas'] is List) {
          var areasList = widget.repdetail1['areas'] as List;
          var areaIndex =
              areasList.indexWhere((area) => area['name'] == areaName);

          if (areaIndex != -1) {
            var areaToUpdate = areasList[areaIndex];
            areaToUpdate['photos'] = [
              {'url': imagePath, 'name': "", 'notes': ""}
            ];
          }
        }
      } else {
        print("Failed to upload image.");
      }
    } catch (e) {
      print('Error in _saveArea: $e');
    }
  }

  void _saveData(BuildContext context) async {
    try {
      if (widget.repdetail1.containsKey('areas') &&
          widget.repdetail1['areas'] is List) {
        var areasList = widget.repdetail1['areas'] as List;
        var areaIndex =
            areasList.indexWhere((area) => area['name'] == widget.title);

        if (areaIndex != -1) {
          var areaToUpdate = areasList[areaIndex];
          areaToUpdate['notes'] = '';
          areaToUpdate['photosNotes'] = photosNotesController.text;
          areaToUpdate['tenantComment'] = '';
          areaToUpdate['items'] = [
            // ... existing code ...
          ];
          areaToUpdate['photos'] = [
            {'url': imagePath, 'name': "", 'notes': ""}
          ];
        }
      }

      await saveReportData(
        widget.inspectID1,
        widget.reportID1,
      );
    } catch (e) {
      print('Error in _saveData: $e');
    }
  }

  Map<String, dynamic> getAreaDetails(String areaName) {
    final area = widget.passPhotos.firstWhere(
      (area) => area['name'] == areaName,
      orElse: () => <String, dynamic>{},
    );
    return area;
  }

  List<dynamic> getPhotosForArea(String areaName) {
    final areaDetails = getAreaDetails(areaName);
    return areaDetails['photos'] ?? [] as List<dynamic>;
  }

  String getPhotosNotesForArea(String areaName) {
    final areaDetails = getAreaDetails(areaName);
    return areaDetails['photosNotes'] ?? '';
  }

  late final String title = widget.title;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> area = getAreaDetails(areaName);
    List<dynamic> Photos = getPhotosForArea(areaName);
    String photosNotes = getPhotosNotesForArea(areaName);
    photosNotesController.text = photosNotes;
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
                  builder: (context) => reportEntryExit(
                      followupActions: '',
                      isSharedWithOwner: false,
                      isSharedWithTenant: false,
                      notes: '',
                      rentReview: '',
                      signs_moulds_dampness: false,
                      pests_vermin: false,
                      rubbish_bin_left_premises: false,
                      telephone_line_premises: false,
                      internet_line_premises: false,
                      shower_wtr_rate_ltr_minute: false,
                      internal_basins_wtr_rate_ltr_minute: false,
                      no_licking_taps: false,
                      water_meter_reading: '',
                      cleaning_repair_notes: '',
                      instalation_wtr_measures_on: '',
                      paint_premises_external_on: 'paint_premises_external_on',
                      paint_premises_internal_on: 'paint_premises_internal_on',
                      landlord_aggred_work_on: 'landlord_aggred_work_on',
                      flooring_clean_replaced_on: 'flooring_clean_replaced_on',
                      inspId: widget.inspectID1,
                      reportId: widget.reportID1,
                      jwtToken: widget.jwt,
                      propertyId: widget.propertID,
                      reportdetails: widget.repdetail1,
                      areaList: [],
                      areadata: widget.areaDet!)),
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
          // IconButton(
          //   icon: Icon(Icons.copy),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: Icon(CupertinoIcons.create),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                            areaDetails: widget.passPhotos,
                            inspectId: widget.inspectID1,
                            reportDetails: widget.repdetail1,
                            reportId: widget.reportID1,
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
                      //_saveData(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => photos(
                            title: widget.title,
                            passPhotos: widget.passPhotos,
                            repdetail1: widget.repdetail1,
                            inspectID1: widget.inspectID1,
                            reportID1: widget.reportID1,
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
                      //_saveData(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => notes(
                            title: widget.title,
                            passNotes: widget.passPhotos,
                            inspectID: widget.inspectID1,
                            repdetail: widget.repdetail1,
                            reportID: widget.reportID1,
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
                          onTap: () {
                            // final input = html.FileUploadInputElement()
                            //   ..accept = 'image/*';
                            // input.click();

                            // input.onChange.listen((e) {
                            //   final file = input.files!.first;
                            //   uploadImage(file);
                            // });
                            // _selectAndUploadImage();
                            _selectAndUploadImages();
                          },
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
                                  // final input = html.FileUploadInputElement()
                                  //   ..accept = 'image/*';
                                  // input.click();

                                  // input.onChange.listen((e) {
                                  //   final file = input.files!.first;
                                  //   uploadImage(file);
                                  // });
                                  // _selectAndUploadImage();
                                  _selectAndUploadImages();
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
                        itemCount: uploadedImages.length + Photos.length,
                        itemBuilder: (context, index) {
                          if (index < uploadedImages.length) {
                            // Display local uploaded images
                            final imagePath = uploadedImages[index];

                            return ListTile(
                              leading: Image.network(
                                imagePath, // Load the local image
                                width: 100,
                                height: 100,
                              ),
                              // title: Text(uploadedImage.name),
                            );
                          } else {
                            // Display remote photos from the response
                            final remoteImageIndex =
                                index - uploadedImages.length;
                            final remoteImagePath = Photos[remoteImageIndex];

                            return ListTile(
                              leading: Image.network(
                                remoteImagePath, // Load the remote image
                                width: 100,
                                height: 100,
                              ),
                              // You can add a title or other information here if needed.
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 80.0, right: 80, bottom: 20),
                      child: Stack(children: [
                        Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextField(
                                controller: photosNotesController,
                                decoration: InputDecoration(
                                    hintText: 'PhotosNotes', // Placeholder text
                                    // labelText:
                                    //     'PhotosNotes', // Label for the text field
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () => _saveData(context),
                child: Text('Save Data'),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: ElevatedButton(
            //     onPressed: () => _saveArea(context),
            //     child: Text('Save photo'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
// Future<void> _saveArea(BuildContext context) async {

//     try {
//       String base64Image = base64.encode(!);

//       imagePath = await postImages(
//         widget.inspectID1,
//         widget.reportID1,
//         widget.propertID,
//         widget.title,
//         [base64Image],
//       );

//     } catch (e) {
//       // Handle the error or display an error message here.
//       print('Error: $e');
//     }

// }

  // void _saveArea(BuildContext context) async {
  //   imagePath = await postImages(widget.inspectID1, widget.reportID1,
  //       widget.propertID, widget.title, uploadedImages // Binary image data
  //       );
  //   print("Image PathL $imagePath");
  //   // Only navigate if the image upload is successful
  // }

  // void _saveArea(BuildContext context) async {
  //   try {
  //     final areaName = widget.title;

  //     final imagePath = await postImages(
  //       widget.inspectID1,
  //       widget.reportID1,
  //       widget.propertID,
  //       areaName,
  //       uploadedImages, // Binary image data
  //     );

  //     if (imagePath != null) {
  //       print("Image Path: $imagePath");

  //       // Update the UI or perform any other actions based on the successful image upload

  //       // Save the image path to the corresponding area in the report detail
  //       if (widget.repdetail1.containsKey('areas') &&
  //           widget.repdetail1['areas'] is List) {
  //         var areasList = widget.repdetail1['areas'] as List;
  //         var areaIndex =
  //             areasList.indexWhere((area) => area['name'] == areaName);

  //         if (areaIndex != -1) {
  //           var areaToUpdate = areasList[areaIndex];
  //           areaToUpdate['photos'] = [
  //             {'url': imagePath, 'name': "", 'notes': ""}
  //           ];
  //         }
  //       }
  //     } else {
  //       print("Failed to upload image.");
  //       // Handle the case where image upload failed
  //     }
  //   } catch (e) {
  //     print('Error in _saveArea: $e');
  //     // Handle any other exceptions that might occur during the process
  //   }
  // }

//   void _saveData(BuildContext context) async {
//     //String agentComment = agentCommentController.text;
// //     setState(() {
// // // Update this value
// //     });

//     try {
//       final areas = widget.repdetail1['areas'] as List;

//       if (widget.repdetail1.containsKey('areas') &&
//           widget.repdetail1['areas'] is List) {
//         // Cast the 'areas' to a List
//         var areasList = widget.repdetail1['areas'] as List;

//         // Find the index of the area with the matching 'name'
//         var areaIndex =
//             areasList.indexWhere((area) => area['name'] == widget.title);

//         if (areaIndex != -1) {
//           // Update the area data at the found index
//           var areaToUpdate = areasList[areaIndex];
//           areaToUpdate['notes'] = '';
//           areaToUpdate['photosNotes'] = photosNotesController.text;
//           areaToUpdate['tenantComment'] = '';
//           //areaToUpdate['isDeleted'] = true;

//           // Update 'items' based on the provided response
//           areaToUpdate['items'] = [
//             {
//               "name": "Windows/screens",
//               "agentComment": '',
//               "otherComment": "",
//               "conditions": [
//                 {"name": "Clean", "value": ''},
//                 {"name": "Undamaged", "value": ''},
//                 {"name": "Working", "value": ''},
//               ],
//             },
//             {
//               "name": "Blinds/curtains",
//               "agentComment": '',
//               "otherComment": "",
//               "conditions": [
//                 {"name": "Clean", "value": ''},
//                 {"name": "Undamaged", "value": ''},
//                 {"name": "Working", "value": ''},
//               ],
//             },
//             {
//               "name": "Fans/light fittings",
//               "agentComment": '',
//               "otherComment": "",
//               "conditions": [
//                 {"name": "Clean", "value": ''},
//                 {"name": "Undamaged", "value": ''},
//                 {"name": "Working", "value": ''},
//               ],
//             },
//             {
//               "name": "Floor/floor coverings",
//               "agentComment": '',
//               "otherComment": "",
//               "conditions": [
//                 {"name": "Clean", "value": ''},
//                 {"name": "Undamaged", "value": ''},
//                 {"name": "Working", "value": ''},
//               ],
//             },
//             {
//               "name": "Wardrobe/drawers/shelves",
//               "agentComment": '',
//               "otherComment": "",
//               "conditions": [
//                 {"name": "Clean", "value": ''},
//                 {"name": "Undamaged", "value": ''},
//                 {"name": "Working", "value": ''},
//               ],
//             },
//             {
//               "name": "Air conditioner",
//               "agentComment": '',
//               "otherComment": "",
//               "conditions": [
//                 {"name": "Clean", "value": ''},
//                 {"name": "Undamaged", "value": ''},
//                 {"name": "Working", "value": ''},
//               ],
//             },
//             {
//               "name": "Power points",
//               "agentComment": '',
//               "otherComment": "",
//               "conditions": [
//                 {"name": "Clean", "value": ''},
//                 {"name": "Undamaged", "value": ''},
//                 {"name": "Working", "value": ''},
//               ],
//             },
//             {
//               "name": "Other",
//               "agentComment": '',
//               "otherComment": "",
//               "conditions": [
//                 {"name": "Clean", "value": ''},
//                 {"name": "Undamaged", "value": ''},
//                 {"name": "Working", "value": ''},
//               ],
//             },
//           ];

//           //print("Clean: : $cleanValue");
//           areaToUpdate['photos'] = [
//             {'url': imagePath, 'name': "", 'notes': ""}
//           ]; // Clear the 'photos' list
//         }
//       }

//       await saveReportData(
//         widget.inspectID1,
//         widget.reportID1,
//       );

//       //agentCommentController.clear();
//       // cleanValue = "";
//       // undamagedValue = "";
//       // workingValue = "";
//       //Navigator.pop(context);
//     } catch (e) {
//       // Handle any errors that occur during the API call.
//     }
//   }
}
