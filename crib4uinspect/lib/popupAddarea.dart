import 'package:flutter/material.dart';

class AddAreaDialog extends StatefulWidget {
  final List<String> existingAreaNames;
  final Function(String) onAreaAdded;
  // final Function(String) onAreaDeleted;

  AddAreaDialog({
    required this.existingAreaNames,
    required this.onAreaAdded,
    // required this.onAreaDeleted,
  });

  @override
  _AddAreaDialogState createState() => _AddAreaDialogState();
}

class _AddAreaDialogState extends State<AddAreaDialog> {
  TextEditingController _areaNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Add New Area'),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _areaNameController,
            decoration: InputDecoration(
              labelText: 'Area Name',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final areaName = _areaNameController.text;
            if (areaName.isNotEmpty) {
              widget.onAreaAdded(areaName);
              _areaNameController.clear();
            }
            Navigator.pop(context);
          },
          child: Text('Add Area'),
        ),
        if (widget.existingAreaNames.isNotEmpty) ...[
          SizedBox(height: 16.0),
          Text('Existing Areas:'),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: widget.existingAreaNames.length,
              itemBuilder: (context, index) {
                final areaName = widget.existingAreaNames[index];
                return ListTile(
                  title: Text(areaName),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () {
                  //    // widget.onAreaDeleted(areaName);

                  //   },
                  // ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
