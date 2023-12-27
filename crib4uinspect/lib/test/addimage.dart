import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Photosview extends StatefulWidget {
  final String? accessToken;
  final String? reportId;
  final String? propertyId;
  final String? inspectionid;
  final String? areaName;
  final String title;

  const Photosview({
    Key? key,
    required this.title,
    this.accessToken,
    this.reportId,
    this.propertyId,
    this.inspectionid,
    this.areaName,
  }) : super(key: key);

  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photosview> {
//! adding area code

  Future<void> areaAdd() async {
    final headers = {
      'Content-Type': 'application/json',
      'accessToken': '${widget.accessToken}', // Use accessToken from widget
    };
    final body = jsonEncode({"areaName": "${widget.areaName}"});

    final response = await http.post(
      Uri.parse(
          'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/addNewArea/${widget.inspectionid}/${widget.reportId}'),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseBodyJson = jsonDecode(response.body);
      final responseData = responseBodyJson['data'];
      print(responseData); //!
      // Handle your response data here
    } else {
      print('API request failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  List<html.File> uploadedImages = [];

  Future<void> _selectAndUploadImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files.first;
        final reader = html.FileReader();

        print('File selected: ${file.name}');

        reader.readAsArrayBuffer(file);
        reader.onLoad.listen((event) {
          Uint8List fileBytes = reader.result as Uint8List;
          setState(() {
            uploadedImages.add(file);
          });
          print('File loaded: ${file.name}');
          _uploadImages(uploadedImages); // Call the upload function
        });
        reader.onError.listen((fileEvent) {
          print('Error reading file: ${fileEvent.toString()}');
        });
      } else {
        print('No file selected');
      }
    });
  }

  Future<void> _uploadImages(List<html.File> images) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://crib4u.axiomprotect.com:9497/api/prop_gateway/inspect/updateReportImages/${widget.propertyId}/${widget.inspectionid}/${widget.reportId}',
        ),
      );

      print('Creating request...');

      // Set the headers
      request.headers['accessToken'] = widget.accessToken ?? '';

      // Add each image as a MultipartFile to the request
      for (var image in images) {
        Uint8List fileBytes = await _readFileAsBytes(image);
        request.files.add(
          http.MultipartFile.fromBytes(
            'images',
            fileBytes,
            filename: image.name,
          ),
        );
        print('Adding file: ${image.name}');
      }

      // Optionally add other fields
      if (widget.areaName != null) {
        request.fields['areaName'] = widget.areaName!;
      }

      print('Sending request...');

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) {
        print('Response: $value');
      });

      if (response.statusCode == 200) {
        print("Images uploaded successfully");
      } else {
        print("Failed to upload images. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading images: $e");
    }
  }

  Future<Uint8List> _readFileAsBytes(html.File file) async {
    final reader = html.FileReader();
    final completer = Completer<Uint8List>();

    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((event) {
      completer.complete(reader.result as Uint8List);
    });
    reader.onError.listen((error) {
      print('Error reading file bytes: $error');
      completer.completeError(error);
    });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: _selectAndUploadImage,
          ),
          IconButton(
            onPressed: () {
              areaAdd();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: uploadedImages.length,
        itemBuilder: (context, index) {
          final file = uploadedImages[index];
          return ListTile(
            title: Text(file.name),
            // Display the image here
          );
        },
      ),
    );
  }
}
