// import 'package:crib4uinspect/reportEntryExit.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker_web/image_picker_web.dart';
// //import 'dart:typeddata';
// import 'dart:convert'; // For base64 encoding
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

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

//   AddAreaScreen(
//       {required this.areaName,
//       required this.inspID,
//       required this.reportID,
//       this.jwttoken,
//       required this.propId,
//       required this.reportDetails,
//       required this.areaList});

//   @override
//   _AddAreaScreenState createState() => _AddAreaScreenState();
// }

// class _AddAreaScreenState extends State<AddAreaScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   Uint8List? imageFile; // To store the selected image file
//   List<Areas> addName = [];
//   int selectedAreaIndex = 0; // Variable to track the selected area
//   @override
//   void initState() {
//     super.initState();
//     updateSelectedArea(selectedAreaIndex);

//     // addName = widget.areaList;
//     // // Set the initial values of the TextFields
//     // nameController.text = addName[selectedAreaIndex].notes;
//     // descriptionController.text = addName[selectedAreaIndex].photosNotes;
//     // You can initialize the 'areasadd' list from the 'areaList' provided in the widget
//     // addName = widget.areaList
//     //     .map((area) => Areas(
//     //           name: area.name,
//     //           isDeleted: false,
//     //           items: [],
//     //           notes: area.notes, // Use the 'notes' field from the 'area' object
//     //           photos:
//     //               area.photos, // Use the 'photos' field from the 'area' object
//     //           photosNotes: area
//     //               .photosNotes, // Use the 'photosNotes' field from the 'area' object
//     //           tenantComment: area
//     //               .tenantComment, // Use the 'tenantComment' field from the 'area' object
//     //         ))
//     //     .toList();

//     // // Set the initial values of the TextFields
//     // nameController.text = addName[0].notes;
//     // descriptionController.text =
//     //     addName[0].photosNotes; // Use the 'photosNotes' field
//   }

//   void updateSelectedArea(int index) {
//     nameController.text = widget.areaList[index].notes;
//     descriptionController.text = widget.areaList[index].photosNotes;
//   }

//   Future<String> postImages(
//       String inspID, String reportID, String? propId, String? name) async {
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
//         // Handle the case when no image is selected.
//         throw Exception('No image selected');
//       }

//       // Add other fields if needed
//       request.fields['areaName'] = name!;

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

//   // Future<void> saveReportData(
//   //   String inspID,
//   //   String reportID,
//   // ) async {
//   //   final url = Uri.parse(
//   //       'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspID/$reportID');

//   //   final List<Map<String, dynamic>> reportDataJson =
//   //       widget.reportDetails.map((data) => data.toJson()).toList();

//   //   try {
//   //     final response = await http.post(
//   //       url,
//   //       headers: <String, String>{
//   //         'Content-Type': 'application/json',
//   //       },
//   //       body: jsonEncode(reportDataJson),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       // Report data saved successfully
//   //       print('Report data saved successfully');
//   //     } else {
//   //       // Failed to save report data
//   //       print(
//   //           'Failed to save report data. Status code: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     // Handle exceptions
//   //     print('Error: $e');
//   //   }
//   // }

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
//           'ReportDetails': widget.reportDetails
//         }), // Convert the map directly to a JSON string
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Text(
//               widget.areaName,
//               style: TextStyle(fontSize: 50),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.areaList.length,
//               itemBuilder: (context, index) {
//                 final area = widget.areaList[index];
//                 return ListTile(
//                   title: Text(area.name),
//                   onTap: () {
//                     setState(() {
//                       selectedAreaIndex = index;
//                       updateSelectedArea(selectedAreaIndex);
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               width: 300, // Set the desired width
//               height: 200,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey, // Set the border color
//                   width: 1.0, // Set the border width
//                 ),
//               ),

//               child: TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: widget.areaList[selectedAreaIndex].notes,
//                   border: InputBorder.none, // Remove the underline
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
//               width: 300, // Set the desired width
//               height: 200, // Set the desired height
//               child: Image.memory(
//                 imageFile!,
//                 width: 300,
//                 height: 200,
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Container(
//               width: 150, // Set the desired width
//               height: 50,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey, // Set the border color
//                   width: 1.0, // Set the border width
//                 ),
//               ),
//               child: TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(
//                     labelText: widget.areaList[selectedAreaIndex].photosNotes),
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
//               onPressed: () => _saveData(context),
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

//   void _saveData(BuildContext context) async {
//     if (nameController.text.isNotEmpty) {
//       // Create a new reportData with the data from nameController and descriptionController
//       Map<String, dynamic> reportData = {
//         'name': widget.areaName,
//         'notes': nameController.text,

//         'photonotes': descriptionController.text,
//         'tenantComment': "",
//         'isDeleted': true,
//         'items': [],
//         'photos': [],
//         // Add more fields if needed
//       };

//       if (widget.reportDetails.containsKey('areas')) {
//         // Append the new reportData to the existing list
//         (widget.reportDetails['areas'] as List).add(reportData);
//       } else {
//         widget.reportDetails['areas'] = [reportData];
//       }

//       try {
//         await saveReportData(widget.inspID, widget.reportID);

//         Navigator.pop(context);
//       } catch (e) {}
//     } else {}
//   }

//   void _saveArea(BuildContext context) async {
//     if (nameController.text.isNotEmpty) {
//       try {
//         final imagePath = await postImages(
//           widget.inspID,
//           widget.reportID,
//           widget.propId,
//           nameController.text,
//         );
//         // Only navigate if the image upload is successful
//         Navigator.pop(
//           context,
//           Area51(
//             name: nameController.text,
//             description: descriptionController.text,
//             imagePath: imagePath,
//             //reportData: [],
//           ),
//         );
//       } catch (e) {
//         // You can handle the error or display an error message here.
//       }
//     } else {
//       // Show an error message or handle the case when the name is empty.
//     }
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:crib4uinspect/reportEntryExit.dart';

import 'areaadd.dart';

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
  int selectedAreaIndex = 0; // Variable to track the selected area

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

  Future<String> postImages(
    String inspID,
    String reportID,
    String? propId,
    String? name,
  ) async {
    try {
      final url = Uri.parse(
          'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/$inspID/$reportID/$propId');

      final request = http.MultipartRequest(
        'POST',
        url,
      );

      if (imageFile != null) {
        final multipartFile = http.MultipartFile.fromBytes(
          'images',
          imageFile!,
          filename: 'image.jpg',
        );
        request.files.add(multipartFile);
      } else {
        // Handle the case when no image is selected.
        throw Exception('No image selected');
      }

      // Add other fields if needed
      request.fields['areaName'] = name!;

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final imagePath = json.decode(responseBody)['imagePath'];
        return imagePath;
      } else {
        throw Exception('Failed to upload images');
      }
    } catch (e) {
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
          'accessToken': '${widget.jwttoken}',
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

  // Future<void> saveReportData(String inspID, String reportID) async {
  //   final url = Uri.parse(
  //     'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/saveInspctionReport/$inspID/$reportID',
  //   );

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'accessToken': '${widget.jwttoken}',
  //       },
  //       body: jsonEncode({
  //         'ReportDetails': widget.reportDetails,
  //       }), // Convert the map directly to a JSON string
  //     );

  //     if (response.statusCode == 200) {
  //       // Report data saved successfully
  //     } else {
  //       // Failed to save report data
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.areaName,
              style: TextStyle(fontSize: 50),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: widget.areaList.length,
          //     itemBuilder: (context, index) {
          //       final area = widget.areaList[index];
          //       return ListTile(
          //         title: Text(area.name),
          //         onTap: () {
          //           setState(() {
          //             selectedAreaIndex = index;
          //             updateSelectedArea(selectedAreaIndex);
          //           });
          //         },
          //       );
          //     },
          //   ),
          // ),
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
                  labelText: widget.notes,
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
                  labelText: widget.photonotes,
                ),
                //initialValue: widget.notes ?? '',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () => _saveArea(context),
              child: Text('Save Image'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () => _saveData(context),
              child: Text('Save Data'),
            ),
          ),
        ],
      ),
    );
  }

  void _selectImage() async {
    final imageInfo = await ImagePickerWeb.getImageInfo;

    if (imageInfo != null) {
      setState(() {
        imageFile = imageInfo.data;
      });
    }
  }

  void _saveData(BuildContext context) async {
    if (nameController.text.isNotEmpty) {
      // Create a new reportData with the data from nameController and descriptionController
      Map<String, dynamic> reportData = {
        'name': widget.areaName,
        'notes': nameController.text,
        'photonotes': descriptionController.text,
        'tenantComment': "",
        'isDeleted': true,
        'items': [],
        'photos': [],
      };

      if (widget.reportDetails.containsKey('areas')) {
        (widget.reportDetails['areas'] as List).add(reportData);
      } else {
        widget.reportDetails['areas'] = [reportData];
      }

      try {
        await saveReportData(widget.inspID, widget.reportID);
        Navigator.pop(context);
      } catch (e) {}
    }
  }

  void _saveArea(BuildContext context) async {
    if (nameController.text.isNotEmpty) {
      try {
        final imagePath = await postImages(
          widget.inspID,
          widget.reportID,
          widget.propId,
          nameController.text,
        );
        // Only navigate if the image upload is successful
        Navigator.pop(
          context,
          Area51(
            name: nameController.text,
            description: descriptionController.text,
            imagePath: imagePath,
            //reportData: [],
          ),
        );
      } catch (e) {
        // You can handle the error or display an error message here.
      }
    } else {
      // Show an error message or handle the case when the name is empty.
    }
  }
}
