// // // import 'package:crib4uinspect/reportEntryExit.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:image_picker_web/image_picker_web.dart';
// // // //import 'dart:typeddata';
// // // import 'dart:convert'; // For base64 encoding
// // /rt 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;

// // // import 'areaadd.dart';

// // // class Area51 {
// // //   final String name;
// // //   final String description;
// // //   final String imagePath;

// // //   Area51({
// // //     required this.name,
// // //     required this.description,
// // //     required this.imagePath,
// // //   });
// // // }

// // // class AddAreaScreen extends StatefulWidget {
// // //   final String areaName;
// // //   String inspID;
// // //   String reportID;
// // //   String? jwttoken;
// // //   final String? propId;
// // //   Map<String, dynamic> reportDetails;
// // //   List<Areas> areaList;

// // //   AddAreaScreen(
// // //       {required this.areaName,
// // //       required this.inspID,
// // //       required this.reportID,
// // //       this.jwttoken,
// // //       required this.propId,
// // //       required this.reportDetails,
// // //       required this.areaList});

// // //   @override
// // //   _AddAreaScreenState createState() => _AddAreaScreenState();
// // // }

// // // class _AddAreaScreenState extends State<AddAreaScreen> {
// // //   TextEditingController nameController = TextEditingController();
// // //   TextEditingController descriptionController = TextEditingController();
// // //   Uint8List? imageFile; // To store the selected image file
// // //   List<Areas> addName = [];
// // //   int selectedAreaIndex = 0; // Variable to track the selected area
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     updateSelectedArea(selectedAreaIndex);

// // //     // addName = widget.areaList;
// // //     // // Set the initial values of the TextFields
// // //     // nameController.text = addName[selectedAreaIndex].notes;
// // //     // descriptionController.text = addName[selectedAreaIndex].photosNotes;
// // //     // You can initialize the 'areasadd' list from the 'areaList' provided in the widget
// // //     // addName = widget.areaList
// // //     //     .map((area) => Areas(
// // //     //           name: area.name,
// // //     //           isDeleted: false,
// // //     //           items: [],
// // //     //           notes: area.notes, // Use the 'notes' field from the 'area' object
// // //     //           photos:
// // //     //               area.photos, // Use the 'photos' field from the 'area' object
// // //     //           photosNotes: area
// // //     //               .photosNotes, // Use the 'photosNotes' field from the 'area' object
// // //     //           tenantComment: area
// // //     //               .tenantComment, // Use the 'tenantComment' field from the 'area' object
// // //     //         ))
// // //     //     .toList();

// // //     // // Set the initial values of the TextFields
// // //     // nameController.text = addName[0].notes;
// // //     // descriptionController.text =
// // //     //     addName[0].photosNotes; // Use the 'photosNotes' field
// // //   }

// // //   void updateSelectedArea(int index) {
// // //     nameController.text = widget.areaList[index].notes;
// // //     descriptionController.text = widget.areaList[index].photosNotes;
// // //   }

// // //   Future<String> postImages(
// // //       String inspID, String reportID, String? propId, String? name) async {
// // //     try {
// // //       final url = Uri.parse(
// // //           'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$inspID/$reportID/$propId');

// // //       final request = http.MultipartRequest(
// // //         'POST',
// // //         url,
// // //       );

// // //       if (imageFile != null) {
// // //         final multipartFile = http.MultipartFile.fromBytes(
// // //           'images',
// // //           imageFile!,
// // //           filename: 'image.jpg',
// // //         );
// // //         request.files.add(multipartFile);
// // //       } else {
// // //         // Handle the case when no image is selected.
// // //         throw Exception('No image selected');
// // //       }

// // //       // Add other fields if needed
// // //       request.fields['areaName'] = name!;

// // //       final response = await request.send();
// // //       if (response.statusCode == 200) {
// // //         final responseBody = await response.stream.bytesToString();
// // //         final imagePath = json.decode(responseBody)['imagePath'];
// // //         return imagePath;
// // //       } else {
// // //         throw Exception('Failed to upload images');
// // //       }
// // //     } catch (e) {
// // //       throw e;
// // //     }
// // //   }

// // //   // Future<void> saveReportData(
// // //   //   String inspID,
// // //   //   String reportID,
// // //   // ) async {
// // //   //   final url = Uri.parse(
// // //   //       'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspID/$reportID');

// // //   //   final List<Map<String, dynamic>> reportDataJson =
// // //   //       widget.reportDetails.map((data) => data.toJson()).toList();

// // //   //   try {
// // //   //     final response = await http.post(
// // //   //       url,
// // //   //       headers: <String, String>{
// // //   //         'Content-Type': 'application/json',
// // //   //       },
// // //   //       body: jsonEncode(reportDataJson),
// // //   //     );

// // //   //     if (response.statusCode == 200) {
// // //   //       // Report data saved successfully
// // //   //       print('Report data saved successfully');
// // //   //     } else {
// // //   //       // Failed to save report data
// // //   //       print(
// // //   //           'Failed to save report data. Status code: ${response.statusCode}');
// // //   //     }
// // //   //   } catch (e) {
// // //   //     // Handle exceptions
// // //   //     print('Error: $e');
// // //   //   }
// // //   // }

// // //   Future<void> saveReportData(String inspID, String reportID) async {
// // //     final url = Uri.parse(
// // //       'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspID/$reportID',
// // //     );

// // //     try {
// // //       final response = await http.post(
// // //         url,
// // //         headers: <String, String>{
// // //           'Content-Type': 'application/json',
// // //           'accessToken': '${widget.jwttoken}',
// // //         },
// // //         body: jsonEncode({
// // //           'ReportDetails': widget.reportDetails
// // //         }), // Convert the map directly to a JSON string
// // //       );

// // //       if (response.statusCode == 200) {
// // //         // Report data saved successfully
// // //       } else {
// // //         // Failed to save report data
// // //       }
// // //     } catch (e) {
// // //       // Handle exceptions
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: ListView(
// // //         padding: EdgeInsets.all(16.0),
// // //         children: <Widget>[
// // //           Padding(
// // //             padding: const EdgeInsets.all(20.0),
// // //             child: Text(
// // //               widget.areaName,
// // //               style: TextStyle(fontSize: 50),
// // //             ),
// // //           ),
// // //           Expanded(
// // //             child: ListView.builder(
// // //               itemCount: widget.areaList.length,
// // //               itemBuilder: (context, index) {
// // //                 final area = widget.areaList[index];
// // //                 return ListTile(
// // //                   title: Text(area.name),
// // //                   onTap: () {
// // //                     setState(() {
// // //                       selectedAreaIndex = index;
// // //                       updateSelectedArea(selectedAreaIndex);
// // //                     });
// // //                   },
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(20.0),
// // //             child: Container(
// // //               width: 300, // Set the desired width
// // //               height: 200,
// // //               decoration: BoxDecoration(
// // //                 border: Border.all(
// // //                   color: Colors.grey, // Set the border color
// // //                   width: 1.0, // Set the border width
// // //                 ),
// // //               ),

// // //               child: TextField(
// // //                 controller: nameController,
// // //                 decoration: InputDecoration(
// // //                   labelText: widget.areaList[selectedAreaIndex].notes,
// // //                   border: InputBorder.none, // Remove the underline
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(20.0),
// // //             child: ElevatedButton(
// // //               onPressed: _selectImage,
// // //               child: Text('Select Image'),
// // //             ),
// // //           ),
// // //           if (imageFile != null)
// // //             Container(
// // //               width: 300, // Set the desired width
// // //               height: 200, // Set the desired height
// // //               child: Image.memory(
// // //                 imageFile!,
// // //                 width: 300,
// // //                 height: 200,
// // //               ),
// // //             ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(20.0),
// // //             child: Container(
// // //               width: 150, // Set the desired width
// // //               height: 50,
// // //               decoration: BoxDecoration(
// // //                 border: Border.all(
// // //                   color: Colors.grey, // Set the border color
// // //                   width: 1.0, // Set the border width
// // //                 ),
// // //               ),
// // //               child: TextField(
// // //                 controller: descriptionController,
// // //                 decoration: InputDecoration(
// // //                     labelText: widget.areaList[selectedAreaIndex].photosNotes),
// // //               ),
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(20.0),
// // //             child: ElevatedButton(
// // //               onPressed: () => _saveArea(context),
// // //               child: Text('Save Image'),
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(20.0),
// // //             child: ElevatedButton(
// // //               onPressed: () => _saveData(context),
// // //               child: Text('Save Data'),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   void _selectImage() async {
// // //     final imageInfo = await ImagePickerWeb.getImageInfo;

// // //     if (imageInfo != null) {
// // //       setState(() {
// // //         imageFile = imageInfo.data;
// // //       });
// // //     }
// // //   }

// // //   void _saveData(BuildContext context) async {
// // //     if (nameController.text.isNotEmpty) {
// // //       // Create a new reportData with the data from nameController and descriptionController
// // //       Map<String, dynamic> reportData = {
// // //         'name': widget.areaName,
// // //         'notes': nameController.text,

// // //         'photonotes': descriptionController.text,
// // //         'tenantComment': "",
// // //         'isDeleted': true,
// // //         'items': [],
// // //         'photos': [],
// // //         // Add more fields if needed
// // //       };

// // //       if (widget.reportDetails.containsKey('areas')) {
// // //         // Append the new reportData to the existing list
// // //         (widget.reportDetails['areas'] as List).add(reportData);
// // //       } else {
// // //         widget.reportDetails['areas'] = [reportData];
// // //       }

// // //       try {
// // //         await saveReportData(widget.inspID, widget.reportID);

// // //         Navigator.pop(context);
// // //       } catch (e) {}
// // //     } else {}
// // //   }

// // //   void _saveArea(BuildContext context) async {
// // //     if (nameController.text.isNotEmpty) {
// // //       try {
// // //         final imagePath = await postImages(
// // //           widget.inspID,
// // //           widget.reportID,
// // //           widget.propId,
// // //           nameController.text,
// // //         );
// // //         // Only navigate if the image upload is successful
// // //         Navigator.pop(
// // //           context,
// // //           Area51(
// // //             name: nameController.text,
// // //             description: descriptionController.text,
// // //             imagePath: imagePath,
// // //             //reportData: [],
// // //           ),
// // //         );
// // //       } catch (e) {
// // //         // You can handle the error or display an error message here.
// // //       }
// // //     } else {
// // //       // Show an error message or handle the case when the name is empty.
// // //     }
// // //   }
// // // }

// // import 'dart:typed_data';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:image_picker_web/image_picker_web.dart';
// // import 'package:crib4uinspect/reportEntryExit.dart';

// // import 'areaadd.dart';

// // class Area51 {
// //   final String name;
// //   final String description;
// //   final String imagePath;

// //   Area51({
// //     required this.name,
// //     required this.description,
// //     required this.imagePath,
// //   });
// // }

// // class AddAreaScreen extends StatefulWidget {
// //   final String areaName;
// //   String inspID;
// //   String reportID;
// //   String? jwttoken;
// //   final String? propId;
// //   Map<String, dynamic> reportDetails;
// //   List<Areas> areaList;
// //   String? photonotes;
// //   String? notes;

// //   AddAreaScreen({
// //     required this.areaName,
// //     required this.inspID,
// //     required this.reportID,
// //     this.jwttoken,
// //     required this.propId,
// //     required this.reportDetails,
// //     required this.areaList,
// //     required this.photonotes,
// //     required this.notes,
// //   });

// //   @override
// //   _AddAreaScreenState createState() => _AddAreaScreenState();
// // }

// // class _AddAreaScreenState extends State<AddAreaScreen> {
// //   TextEditingController nameController = TextEditingController();
// //   TextEditingController descriptionController = TextEditingController();
// //   Uint8List? imageFile; // To store the selected image file
// //   int selectedAreaIndex = 0; // Variable to track the selected area

// //   @override
// //   void initState() {
// //     super.initState();
// //     updateSelectedArea(selectedAreaIndex);
// //   }

// //   void updateSelectedArea(int index) {
// //     nameController.text = widget.areaList[index].notes ??
// //         ''; // Use null check operator and provide a default value
// //     descriptionController.text = widget.areaList[index].photosNotes ?? '';
// //   }

// //   Future<String> postImages(
// //     String inspID,
// //     String reportID,
// //     String? propId,
// //     String? name1,
// //   ) async {
// //     try {
// //       final url = Uri.parse(
// //           'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$inspID/$reportID/$propId');

// //       final request = http.MultipartRequest(
// //         'POST',
// //         url,
// //       );

// //       if (imageFile != null) {
// //         final multipartFile = http.MultipartFile.fromBytes(
// //           'images',
// //           imageFile!,
// //           filename: 'image.jpg',
// //         );
// //         request.files.add(multipartFile);
// //       } else {
// //         // Handle the case when no image is selected.
// //         throw Exception('No image selected');
// //       }

// //       // Add other fields if needed
// //       request.fields['areaName'] = name1!;

// //       final response = await request.send();
// //       if (response.statusCode == 200) {
// //         final responseBody = await response.stream.bytesToString();
// //         final imagePath = json.decode(responseBody)['imagePath'];
// //         return imagePath;
// //       } else {
// //         throw Exception('Failed to upload images');
// //       }
// //     } catch (e) {
// //       throw e;
// //     }
// //   }

// //   Future<void> saveReportData(String inspID, String reportID) async {
// //     final url = Uri.parse(
// //       'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspID/$reportID',
// //     );

// //     try {
// //       final response = await http.post(
// //         url,
// //         headers: <String, String>{
// //           'Content-Type': 'application/json',
// //           'accessToken': '${widget.jwttoken}',
// //         },
// //         body: jsonEncode({
// //           'ReportDetails': widget.reportDetails
// //         }), // Convert the map directly to a JSON string
// //       );

// //       if (response.statusCode == 200) {
// //         // Report data saved successfully
// //       } else {
// //         // Failed to save report data
// //       }
// //     } catch (e) {
// //       // Handle exceptions
// //     }
// //   }

// //   // Future<void> saveReportData(String inspID, String reportID) async {
// //   //   final url = Uri.parse(
// //   //     'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspID/$reportID',
// //   //   );

// //   //   try {
// //   //     final response = await http.post(
// //   //       url,
// //   //       headers: <String, String>{
// //   //         'Content-Type': 'application/json',
// //   //         'accessToken': '${widget.jwttoken}',
// //   //       },
// //   //       body: jsonEncode({
// //   //         'ReportDetails': widget.reportDetails,
// //   //       }), // Convert the map directly to a JSON string
// //   //     );

// //   //     if (response.statusCode == 200) {
// //   //       // Report data saved successfully
// //   //     } else {
// //   //       // Failed to save report data
// //   //     }
// //   //   } catch (e) {
// //   //     // Handle exceptions
// //   //   }
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     int index = 0;
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Text(
// //               widget.areaName,
// //               style: TextStyle(fontSize: 50),
// //             ),
// //           ),
// //           // Expanded(
// //           //   child: ListView.builder(
// //           //     itemCount: widget.areaList.length,
// //           //     itemBuilder: (context, index) {
// //           //       final area = widget.areaList[index];
// //           //       return ListTile(
// //           //         title: Text(area.name),
// //           //         onTap: () {
// //           //           setState(() {
// //           //             selectedAreaIndex = index;
// //           //             updateSelectedArea(selectedAreaIndex);
// //           //           });
// //           //         },
// //           //       );
// //           //     },
// //           //   ),
// //           // ),
// //           Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Container(
// //               width: 300,
// //               height: 200,
// //               decoration: BoxDecoration(
// //                 border: Border.all(
// //                   color: Colors.grey,
// //                   width: 1.0,
// //                 ),
// //               ),
// //               child: TextField(
// //                 controller: nameController,
// //                 decoration: InputDecoration(
// //                   labelText: widget.notes,
// //                   border: InputBorder.none,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: ElevatedButton(
// //               onPressed: _selectImage,
// //               child: Text('Select Image'),
// //             ),
// //           ),
// //           if (imageFile != null)
// //             Container(
// //               width: 300,
// //               height: 200,
// //               child: Image.memory(
// //                 imageFile!,
// //                 width: 300,
// //                 height: 200,
// //               ),
// //             ),
// //           Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Container(
// //               width: 150,
// //               height: 50,
// //               decoration: BoxDecoration(
// //                 border: Border.all(
// //                   color: Colors.grey,
// //                   width: 1.0,
// //                 ),
// //               ),
// //               child: TextField(
// //                 controller: descriptionController,
// //                 decoration: InputDecoration(
// //                   labelText: widget.photonotes,
// //                 ),
// //                 //initialValue: widget.notes ?? '',
// //               ),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: ElevatedButton(
// //               onPressed: () => _saveArea(context),
// //               child: Text('Save Image'),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: ElevatedButton(
// //               onPressed: () => _updateAreaData(context, index),
// //               child: Text('Save Data'),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _selectImage() async {
// //     final imageInfo = await ImagePickerWeb.getImageInfo;

// //     if (imageInfo != null) {
// //       setState(() {
// //         imageFile = imageInfo.data;
// //       });
// //     }
// //   }

// //   // void _saveData(BuildContext context) async {
// //   //   if (nameController.text.isNotEmpty) {
// //   //     // Create a new reportData with the data from nameController and descriptionController
// //   //     Map<String, dynamic> reportData = {
// //   //       'name': widget.areaName,
// //   //       'notes': nameController.text,
// //   //       'photonotes': descriptionController.text,
// //   //       'tenantComment': "",
// //   //       'isDeleted': true,
// //   //       'items': [],
// //   //       'photos': [],
// //   //     };

// //   //     if (widget.reportDetails.containsKey('areas')) {
// //   //       (widget.reportDetails['areas'] as List).add(reportData);
// //   //     } else {
// //   //       widget.reportDetails['areas'] = [reportData];
// //   //     }

// //   //     try {
// //   //       await saveReportData(widget.inspID, widget.reportID);
// //   //       Navigator.pop(context);
// //   //     } catch (e) {}
// //   //   }
// //   // }
// //   void _updateAreaData(BuildContext context, int index) async {
// //     if (nameController.text.isNotEmpty) {
// //       if (widget.reportDetails.containsKey('areas') &&
// //           widget.reportDetails['areas'] is List) {
// //         var areasList = widget.reportDetails['areas'] as List;
// //         if (index >= 0 && index < areasList.length) {
// //           var areaToUpdate = areasList[index];
// //           areaToUpdate['name'] = widget.areaName;
// //           areaToUpdate['notes'] = nameController.text;
// //           areaToUpdate['photonotes'] = descriptionController.text;
// //           areaToUpdate['tenantComment'] = "";
// //           areaToUpdate['isDeleted'] = true;
// //           areaToUpdate['items'] = [];
// //           areaToUpdate['photos'] = [];
// //         }
// //       }

// //       try {
// //         await saveReportData(widget.inspID, widget.reportID);
// //         Navigator.pop(context);
// //       } catch (e) {}
// //     }
// //   }

// //   void _saveArea(BuildContext context) async {
// //     if (nameController.text.isNotEmpty) {
// //       try {
// //         final imagePath = await postImages(
// //           widget.inspID,
// //           widget.reportID,
// //           widget.propId,
// //           widget.areaName,
// //         );
// //         // Only navigate if the image upload is successful
// //         Navigator.pop(
// //           context,
// //           Area51(
// //             name: nameController.text,
// //             description: descriptionController.text,
// //             imagePath: imagePath,
// //             //reportData: [],
// //           ),
// //         );
// //       } catch (e) {
// //         // You can handle the error or display an error message here.
// //       }
// //     } else {
// //       // Show an error message or handle the case when the name is empty.
// //     }
// //   }
// // }

import 'dart:typed_data';
import 'dart:convert';
import 'package:crib4uinspect/edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:crib4uinspect/reportEntryExit.dart';

import 'areaadd.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:universal_html/html.dart' as html;
import 'package:http_parser/http_parser.dart'; // Import MediaType

class Area51 {
  final String name;
  final String description;
  final String imagePath;

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
  Uint8List? imageFile; // To store the selected image file
  int selectedAreaIndex = 0;
  int index = 0; // Variable to track the selected area
  String? imagePath;
  @override
  void initState() {
    super.initState();
    updateSelectedArea(selectedAreaIndex);
  }

  void updateSelectedArea(int index) {
    nameController.text = widget.areaList[index].notes ??
        ''; // Use null check operator and provide a default value
    descriptionController.text = widget.areaList[index].photosNotes ?? '';
  }

  // Future<String> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propId,
  //   String? name1,
  //   List<int> imageBytes, // Binary image data
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$inspID/$reportID/$propId');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (imageBytes.isNotEmpty) {
  //       final multipartFile = http.MultipartFile.fromBytes(
  //         'images',
  //         imageBytes,
  //         filename: 'image.jpg',
  //       );
  //       print("Multipart file $multipartFile");
  //       request.files.add(multipartFile);
  //     } else {
  //       // Handle the case when no image is provided.
  //       throw Exception('No image provided');
  //     }

  //     // Add the 'areaName' field
  //     request.fields['areaName'] =
  //         name1 ?? ''; // Use an empty string if name1 is null

  //     // Add the JWT token to the request headers
  //     request.headers['accesstoken'] =
  //         widget.jwttoken ?? ''; // Use an empty string if jwttoken is null

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

  // Future<String> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propId,
  //   String? name1,
  //   List<int> imageBytes, // Binary image data
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propId/$inspID/$reportID');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (imageBytes.isNotEmpty) {
  //       final allowedExtensions = [".png", ".jpg", ".jpeg"];
  //       final filename = 'image.jpg';
  //       final ext = filename.split('.').last;

  //       if (allowedExtensions.contains(".$ext")) {
  //         final multipartFile = http.MultipartFile.fromBytes(
  //           'images',
  //           imageBytes,
  //           filename: filename,
  //         );
  //         print("Multipart file: $multipartFile");
  //         request.files.add(multipartFile);
  //       } else {
  //         throw Exception('Invalid image file extension: $ext');
  //       }
  //     } else {
  //       throw Exception('No image provided');
  //     }

  //     request.fields['areaName'] = name1 ?? '';
  //     request.headers['accesstoken'] =
  //         html.window.sessionStorage['accessToken'] ?? '';
  //     request.headers['Content-Type'] = 'multipart/form-data';

  //     print("Request URL: ${request.url}");
  //     print("Request Headers: ${request.headers}");
  //     print("Request Fields: ${request.fields}");

  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       final imagePath = json.decode(responseBody)['imagePath'];
  //       print("Image path: $imagePath");
  //       return imagePath;
  //     } else {
  //       throw Exception(
  //           'Failed to upload images. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error in postImages: $e');
  //     throw e;
  //   }
  // }

  // Future<String> postImages(
  //   http.Client client,
  //   String inspID,
  //   String reportID,
  //   String? propId,
  //   String? name1,
  //   List<Map<String, String>>
  //       images, // List of objects with fileName and base64
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propId/$inspID/$reportID');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (images.isNotEmpty) {
  //       for (var image in images) {
  //         final fileName = image['fileName'];
  //         final base64String = image['base64'];

  //         // Add each image as a multipart form field
  //         if (fileName != null && base64String != null) {
  //           final multipartFile = http.MultipartFile.fromString(
  //             'images',
  //             base64String,
  //             filename: fileName,
  //             contentType:
  //                 MediaType('image', 'jpeg'), // Specify the content type
  //           );
  //           request.files.add(multipartFile);
  //         } else {
  //           throw Exception('Invalid image data');
  //         }
  //       }
  //     } else {
  //       throw Exception('No images provided');
  //     }

  //     request.fields['areaName'] = name1 ?? '';
  //     request.headers['accesstoken'] =
  //         html.window.sessionStorage['accessToken'] ?? '';
  //     request.headers['Content-Type'] = 'multipart/form-data';

  //     print("Request URL: ${request.url}");
  //     print("Request Headers: ${request.headers}");
  //     print("Request Fields: ${request.fields}");

  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       final imagePath = json.decode(responseBody)['imagePath'];
  //       print("Image path: $imagePath");
  //       return imagePath;
  //     } else {
  //       throw Exception(
  //           'Failed to upload images. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error in postImages: $e');
  //     throw e;
  //   }
  // }

  Future<String> postImages(
    http.Client client,
    String inspID,
    String reportID,
    String? propId,
    String? name1,
    List<Map<String, String>>
        images, // List of objects with fileName and base64
  ) async {
    try {
      final url = Uri.parse(
        'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propId/$inspID/$reportID',
      );

      final request = http.MultipartRequest(
        'POST',
        url,
      );

      if (images.isNotEmpty) {
        for (var image in images) {
          final fileName = image['fileName'];
          final base64String = image['base64'];

          // Add each image as a multipart form field
          if (fileName != null && base64String != null) {
            // Decode the base64 string to Uint8List
            final imageBytes = base64Decode(base64String);

            final multipartFile = http.MultipartFile.fromBytes(
              'images',
              imageBytes,
              filename: fileName,
              contentType:
                  MediaType('image', 'jpeg'), // Specify the content type
            );
            request.files.add(multipartFile);
          } else {
            throw Exception('Invalid image data');
          }
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
        final imagePath = json.decode(responseBody)['imagePath'];
        print("Image path: $imagePath");
        return imagePath;
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

  // Future<String> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propId,
  //   String? name1,
  //   List<int> imageBytes, // Binary image data
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$propId/$inspID/$reportID');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (imageBytes.isNotEmpty) {
  //       // Check if the file has a valid image extension
  //       // You can add more extensions if needed
  //       final allowedExtensions = [".png", ".jpg", ".jpeg"];
  //       final filename = 'image.jpg'; // Change the filename as needed
  //       final ext = filename.split('.').last;
  //       if (allowedExtensions.contains(".$ext")) {
  //         final multipartFile = http.MultipartFile.fromBytes(
  //           'images',
  //           imageBytes,
  //           filename: filename,
  //         );
  //         print("Multipart file $multipartFile");
  //         request.files.add(multipartFile);
  //       } else {
  //         // Handle the case when an invalid image extension is provided.
  //         throw Exception('Invalid image file extension');
  //       }
  //     } else {
  //       // Handle the case when no image is provided.
  //       throw Exception('No image provided');
  //     }

  //     // Add the 'areaName' field
  //     request.fields['areaName'] = name1 ?? '';
  //     // request.fields['images'] =
  //     //     imageBytes as String ;

  //     // Add the JWT token to the request headers
  //     request.headers['accesstoken'] =
  //         html.window.sessionStorage['accessToken'] ??
  //             ''; // Use an empty string if jwttoken is null

  //     // Set the Content-Type header to "multipart/form-data"
  //     request.headers['Content-Type'] = 'multipart/form-data';

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
//////
  ///
  // Future<String> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propId,
  //   String? name1,
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$inspID/$reportID/$propId');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (imageFile != null) {
  //       final multipartFile = http.MultipartFile.fromBytes(
  //         'images',
  //         imageFile!,
  //         filename: 'image.jpg',
  //       );
  //       request.files.add(multipartFile);
  //     } else {
  //       // Handle the case when no image is selected.
  //       throw Exception('No image selected');
  //     }

  //     // Add other fields if needed
  //     request.fields['areaName'] = name1!;
  //     request.fields['images'] = imageFile as String;
  //     // Add the JWT token to the request headers
  //     request.headers['accessToken'] = widget.jwttoken!;

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

  // Future<String> postImages(
  //   String inspID,
  //   String reportID,
  //   String? propId,
  //   String? name1,
  // ) async {
  //   try {
  //     final url = Uri.parse(
  //         'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$inspID/$reportID/$propId');

  //     final request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );

  //     if (imageFile != null) {
  //       final multipartFile = http.MultipartFile.fromBytes(
  //         'images',
  //         imageFile!,
  //         filename: 'image.jpg',
  //       );
  //       request.files.add(multipartFile);
  //     } else {
  //       // Handle the case when no image is selected.
  //       throw Exception('No image selected');
  //     }

  //     // Add other fields if needed
  //     request.fields['areaName'] = name1!;
  //     request.fields['images'] = imageFile as String;
  //     // Add the JWT token to the request headers
  //     request.headers['accessToken'] = widget.jwttoken!;

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
          'ReportDetails': widget.reportDetails
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
                    labelText: widget.areaList[index].notes ?? '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _selectImage,
                child: Text('Select Image'),
              ),
            ),
            if (imageFile != null)
              Container(
                width: 300,
                height: 200,
                child: Image.memory(
                  imageFile!,
                  width: 300,
                  height: 200,
                ),
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
                    labelText: widget.areaList[index].photosNotes ?? '',
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: ElevatedButton(
            //     onPressed: () => _saveArea(context),
            //     child: Text('Save Image'),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () => _updateAreaData(context, selectedAreaIndex),
                child: Text('Save Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectImage() async {
    final imageInfo = await ImagePickerWeb.getImageInfo;

    if (imageInfo != null) {
      setState(() {
        imageFile = imageInfo.data;
      });
      _saveArea(context);
    }
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
          areaToUpdate['tenantComment'] = "";
          areaToUpdate['items'] = [];
          areaToUpdate['photos'] = [
            {'url': imagePath, 'name': "", 'notes': ""}
          ];
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

// void _saveArea(BuildContext context) async {
//   if (nameController.text.isNotEmpty) {
//     try {
//       imagePath = await postImages(
//         widget.inspID,
//         widget.reportID,
//         widget.propId,
//         widget.areaName,
//         [
//           {
//             'fileName': 'image.jpg',
//             'base64': base64Encode(imageFile!),
//           }
//         ],
//       );

//       // Ensure that accessToken is not null before using it
//       final accessToken = html.window.sessionStorage['accessToken'];
//       if (accessToken != null) {
//         // Set the accessToken in the headers
//         http.headers['accesstoken'] = accessToken;
//       } else {
//         print('Error: accessToken is null');
//         // Handle the case when accessToken is null
//       }

//       // Only navigate if the image upload is successful
//       Navigator.pop(
//         context,
//         Area51(
//           name: nameController.text,
//           description: descriptionController.text,
//           imagePath: imagePath!,
//         ),
//       );
//     } catch (e) {
//       print('Error saving area: $e');
//       // You can handle the error or display an error message here.
//     }
//   } else {
//     // Show an error message or handle the case when the name is empty.
//   }
// }

  // void _saveArea(BuildContext context) async {
  //   if (nameController.text.isNotEmpty) {
  //     final client = http.Client();
  //     try {
  //       imagePath = await postImages(
  //         client,
  //         widget.inspID,
  //         widget.reportID,
  //         widget.propId,
  //         widget.areaName,
  //         [
  //           {
  //             'fileName': 'image.jpg',
  //             'base64': base64Encode(imageFile!),
  //           }
  //         ],
  //       );

  //       // Only navigate if the image upload is successful
  //       await saveReportData(widget.inspID, widget.reportID);
  //       Navigator.pop(
  //         context,
  //         Area51(
  //           name: nameController.text,
  //           description: descriptionController.text,
  //           imagePath: imagePath!,
  //         ),
  //       );
  //     } catch (e) {
  //       print('Error saving area: $e');
  //       // You can handle the error or display an error message here.
  //     } finally {
  //       client.close(); // Close the client to release resources
  //     }
  //   } else {
  //     // Show an error message or handle the case when the name is empty.
  //   }
  // }

  void _saveArea(BuildContext context) async {
    if (nameController.text.isNotEmpty) {
      final client = http.Client();
      try {
        // Convert Uint8List to base64
        final base64Image = base64Encode(imageFile!);

        imagePath = await postImages(
          client,
          widget.inspID,
          widget.reportID,
          widget.propId,
          widget.areaName,
          [
            {
              'fileName': 'image.jpg',
              'base64': base64Image,
            }
          ],
        );

        // Only navigate if the image upload is successful
        await saveReportData(widget.inspID, widget.reportID);
        Navigator.pop(
          context,
          Area51(
            name: nameController.text,
            description: descriptionController.text,
            imagePath: imagePath!,
          ),
        );
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

  // void _updateAreaData(BuildContext context, int index) async {
  //   // if (nameController.text.isNotEmpty) {
  //   //   updateAreaByName(
  //   //       widget.areaName, nameController.text, descriptionController.text);
  //   //   try {
  //   //     saveReportData(widget.inspID, widget.reportID);
  //   //     Navigator.pop(context);
  //   //   } catch (e) {}
  //   // }
  //   if (nameController.text.isNotEmpty) {
  //     if (widget.reportDetails.containsKey('areas') &&
  //         widget.reportDetails['areas'] is List) {
  //       var areasList = widget.reportDetails['areas'] as List;
  //       var areaIndex =
  //           areasList.indexWhere((area) => area['name'] == widget.areaName);

  //       if (areaIndex != -1) {
  //         var areaToUpdate = areasList[areaIndex];
  //         areaToUpdate['notes'] = nameController.text;
  //         areaToUpdate['photonotes'] = descriptionController.text;
  //         areaToUpdate['tenantComment'] = "";
  //         // areaToUpdate['isDeleted'] = true;
  //         areaToUpdate['items'] = [];
  //         areaToUpdate['photos'] = [
  //           {'url': imagePath, 'name': "", 'notes': ""}
  //         ];
  //       }

  //       try {
  //         await saveReportData(widget.inspID, widget.reportID);
  //         Navigator.pop(context);
  //       } catch (e) {}
  //     }
  //   }
  // }

  // void _saveArea(BuildContext context) async {
  //   if (nameController.text.isNotEmpty) {
  //     try {
  //       imagePath = await postImages(
  //         widget.inspID,
  //         widget.reportID,
  //         widget.propId,
  //         widget.areaName,
  //         [
  //           {
  //             'fileName': 'image.jpg',
  //             'base64': base64Encode(imageFile!),
  //           }
  //         ],
  //       );
  //       // Only navigate if the image upload is successful
  //       Navigator.pop(
  //         context,
  //         Area51(
  //           name: nameController.text,
  //           description: descriptionController.text,
  //           imagePath: imagePath!,
  //         ),
  //       );
  //     } catch (e) {
  //       // You can handle the error or display an error message here.
  //     }
  //   } else {
  //     // Show an error message or handle the case when the name is empty.
  //   }
  // }
}

// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:crib4uinspect/reportEntryExit.dart';
// import 'areaadd.dart';

// class Area51 {
//   final String name;
//   final String description;
//   final String imagePath;

//   Area51({
//     required this.name,
//     required this.description,
//     required this.imagePath,
//   });
// }

// class AddAreaScreen extends StatefulWidget {
//   final String areaName;
//   String inspID;
//   String reportID;
//   String? jwttoken;
//   final String? propId;
//   Map<String, dynamic> reportDetails;
//   List<Areas> areaList;
//   String? photonotes;
//   String? notes;

//   AddAreaScreen({
//     required this.areaName,
//     required this.inspID,
//     required this.reportID,
//     this.jwttoken,
//     required this.propId,
//     required this.reportDetails,
//     required this.areaList,
//     required this.photonotes,
//     required this.notes,
//   });

//   @override
//   _AddAreaScreenState createState() => _AddAreaScreenState();
// }

// class _AddAreaScreenState extends State<AddAreaScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   Uint8List? imageFile; // To store the selected image file

//   @override
//   void initState() {
//     super.initState();
//     updateSelectedArea(0);
//   }

//   void updateSelectedArea(int index) {
//     nameController.text = widget.areaList[index].notes ?? '';
//     descriptionController.text = widget.areaList[index].photosNotes ?? '';
//   }

//   Future<String> postImages(
//     String inspID,
//     String reportID,
//     String? propId,
//     String? name1,
//   ) async {
//     try {
//       final url = Uri.parse(
//           'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$inspID/$reportID/$propId');

//       final request = http.MultipartRequest(
//         'POST',
//         url,
//       );

//       if (imageFile != null) {
//         final multipartFile = http.MultipartFile.fromBytes(
//           'images',
//           imageFile!,
//           filename: 'image.jpg',
//         );
//         request.files.add(multipartFile);
//       } else {
//         throw Exception('No image selected');
//       }

//       request.fields['areaName'] = name1!;

//       final response = await request.send();
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final imagePath = json.decode(responseBody)['imagePath'];
//         return imagePath;
//       } else {
//         throw Exception('Failed to upload images');
//       }
//     } catch (e) {
//       throw e;
//     }
//   }

//   Future<void> saveReportData(String inspID, String reportID) async {
//     final url = Uri.parse(
//       'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspID/$reportID',
//     );

//     try {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'accessToken': '${widget.jwttoken}',
//         },
//         body: jsonEncode({
//           'ReportDetails': widget.reportDetails,
//         }),
//       );

//       if (response.statusCode == 200) {
//         // Report data saved successfully
//       } else {
//         // Failed to save report data
//       }
//     } catch (e) {
//       // Handle exceptions
//     }
//   }

//   void updateAreaByName(String name, String notes, String photonotes) {
//     int areaIndex = widget.areaList.indexWhere((area) => area.name == name);

//     if (areaIndex != -1) {
//       setState(() {
//         widget.areaList[areaIndex].notes = notes;
//         widget.areaList[areaIndex].photosNotes = photonotes;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Text(
//               widget.areaName,
//               style: TextStyle(fontSize: 50),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               width: 300,
//               height: 200,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 1.0,
//                 ),
//               ),
//               child: TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: widget.notes,
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: ElevatedButton(
//               onPressed: _selectImage,
//               child: Text('Select Image'),
//             ),
//           ),
//           if (imageFile != null)
//             Container(
//               width: 300,
//               height: 200,
//               child: Image.memory(
//                 imageFile!,
//                 width: 300,
//                 height: 200,
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               width: 150,
//               height: 50,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 1.0,
//                 ),
//               ),
//               child: TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(
//                   labelText: widget.photonotes,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: ElevatedButton(
//               onPressed: () => _saveArea(context),
//               child: Text('Save Image'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: ElevatedButton(
//               onPressed: () => _updateAreaData(context),
//               child: Text('Save Data'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _selectImage() async {
//     final imageInfo = await ImagePickerWeb.getImageInfo;

//     if (imageInfo != null) {
//       setState(() {
//         imageFile = imageInfo.data;
//       });
//     }
//   }

//   void _updateAreaData(BuildContext context) {
//     if (nameController.text.isNotEmpty) {
//       updateAreaByName(
//           widget.areaName, nameController.text, descriptionController.text);
//       try {
//         saveReportData(widget.inspID, widget.reportID);
//         Navigator.pop(context);
//       } catch (e) {}
//     }
//   }

//   void _saveArea(BuildContext context) async {
//     if (nameController.text.isNotEmpty) {
//       try {
//         final imagePath = await postImages(
//           widget.inspID,
//           widget.reportID,
//           widget.propId,
//           widget.areaName,
//         );
//         Navigator.pop(
//           context,
//           Area51(
//             name: nameController.text,
//             description: descriptionController.text,
//             imagePath: imagePath,
//           ),
//         );
//       } catch (e) {
//         // Handle error
//       }
//     }
//   }
// }
