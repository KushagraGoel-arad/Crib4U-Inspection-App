// import 'package:flutter/material.dart';

// class CompliancePage extends StatefulWidget {
//   bool? signs_moulds_dampness;
//   bool? pests_vermin;
//   bool? rubbish_bin_left_premises;
//   bool? telephone_line_premises;
//   bool? internet_line_premises;
//   bool? shower_wtr_rate_ltr_minute;
//   bool? internal_basins_wtr_rate_ltr_minute;
//   bool? no_licking_taps;
//   final String water_meter_reading;
//   final String cleaning_repair_notes;
//   final String instalation_wtr_measures_on;
//   final String paint_premises_external_on;
//   final String paint_premises_internal_on;
//   final String landlord_aggred_work_on;
//   final String flooring_clean_replaced_on;
//   CompliancePage({
//     super.key,
//     this.signs_moulds_dampness,
//     this.pests_vermin,
//     this.rubbish_bin_left_premises,
//     this.telephone_line_premises,
//     this.internet_line_premises,
//     this.shower_wtr_rate_ltr_minute,
//     this.internal_basins_wtr_rate_ltr_minute,
//     this.no_licking_taps,
//     required this.water_meter_reading,
//     required this.cleaning_repair_notes,
//     required this.instalation_wtr_measures_on,
//     required this.paint_premises_external_on,
//     required this.paint_premises_internal_on,
//     required this.landlord_aggred_work_on,
//     required this.flooring_clean_replaced_on,
//   });
//   @override
//   _CompliancePageState createState() => _CompliancePageState();
// }

// class _CompliancePageState extends State<CompliancePage> {
//   List<bool> _isExpandedList = List.generate(5, (index) => false);
//   List<List<bool>> _checklistItems = [
//     List<bool>.filled(3, false), // Index 0
//     List<bool>.filled(2, false), // Index 1
//     List<bool>.filled(3, false), // Index 2
//     List<bool>.filled(0, false), // Index 3
//     List<bool>.filled(0, false), // Index 4 (or as needed)
//   ];
//   List<DateTime?> _selectedDates = List.filled(5, null);
//   List<TextEditingController> _textControllers =
//       List.generate(5, (_) => TextEditingController());

//   final List<String> items = [
//     'Health Issues',
//     'Communication Facilities',
//     'Water Efficiency Device',
//     'Work Last Done',
//     "Landlord's promise to undertake work",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80.0,
//         backgroundColor: Color.fromRGBO(162, 154, 255, 1),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "Utilities",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//             fontSize: 37.0,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.copy),
//             onPressed: () {
//               // Handle copy button press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.create),
//             onPressed: () {
//               // Handle create button press
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: EdgeInsets.all(10.0),
//             child: ExpansionTile(
//               title: Text(items[index]),
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (int i = 0; i < _checklistItems[index].length; i++)
//                       CheckboxListTile(
//                         title: Text(getChecklistItemTitle(index, i)),
//                         value: _checklistItems[index][i],
//                         onChanged: (value) {
//                           setState(() {
//                             _checklistItems[index][i] = value ?? false;
//                           });
//                         },
//                       ),
//                     if (index == 2)
//                       Column(
//                         children: [
//                           Align(
//                               alignment: Alignment.topLeft,
//                               child: Text('Water meter reading')),
//                           TextField(
//                             controller: _textControllers[index],
//                             decoration: InputDecoration(
//                               labelText: '0',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 3)
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                     "Installation of water efficiency measures"),
//                                 Align(
//                                   alignment: Alignment.topRight,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       width: 165,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: TextField(
//                                               controller:
//                                                   _textControllers[index],
//                                               decoration: InputDecoration(
//                                                 hintText: 'mm / dd / yyyy',
//                                               ),
//                                             ),
//                                           ),
//                                           IconButton(
//                                             icon: Icon(Icons.calendar_today),
//                                             onPressed: () => _selectDate(index),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     if (index == 3)
//                       Row(
//                         children: [
//                           Text("Painting of premises (external)"),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: 165,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextField(
//                                         controller: _textControllers[index],
//                                         decoration: InputDecoration(
//                                           hintText: 'mm / dd / yyyy',
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.calendar_today),
//                                       onPressed: () => _selectDate(index),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 3)
//                       Row(
//                         children: [
//                           Text("Painting of premises (internal)"),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: 165,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextField(
//                                         controller: _textControllers[index],
//                                         decoration: InputDecoration(
//                                           hintText: 'mm / dd / yyyy',
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.calendar_today),
//                                       onPressed: () => _selectDate(index),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 3)
//                       Row(
//                         children: [
//                           Text("Flooring laid/replaced/cleaned"),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: 165,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextField(
//                                         controller: _textControllers[index],
//                                         decoration: InputDecoration(
//                                           hintText: 'mm / dd / yyyy',
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.calendar_today),
//                                       onPressed: () => _selectDate(index),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 4)
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               "Agrees to undertake the following cleaning, repairs, additions, or other work during the tenancy",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                           TextField(
//                             controller: _textControllers[index],
//                             decoration: InputDecoration(
//                               labelText: 'Comment...',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 4)
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             Text("Landlord agrees to complete that work by"),
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   width: 165,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.grey),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: TextField(
//                                           controller: _textControllers[index],
//                                           decoration: InputDecoration(
//                                             hintText: 'mm / dd / yyyy',
//                                           ),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         icon: Icon(Icons.calendar_today),
//                                         onPressed: () => _selectDate(index),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String getChecklistItemTitle(int index, int itemIndex) {
//     switch (index) {
//       case 0:
//         switch (itemIndex) {
//           case 0:
//             return 'Signs of moulds and dampness';
//           case 1:
//             return 'Pests and vermin';
//           case 2:
//             return 'Rubbish bin left on the premises';
//           default:
//             return '';
//         }
//       case 1:
//         switch (itemIndex) {
//           case 0:
//             return 'A telephone line is connected to the residential premises';
//           case 1:
//             return 'An internet line is connected to the residential premises';
//           default:
//             return '';
//         }
//       case 2:
//         switch (itemIndex) {
//           case 0:
//             return 'Showerheads have a maximum flow rate of 9 liters per minute';
//           case 1:
//             return 'Internal cold water taps and single mixer taps in kitchen or bathroom hand basins have a maximum flow rate of 9 litres per minute';
//           case 2:
//             return 'No leaking taps';
//           default:
//             return '';
//         }

//       case 3:
//         switch (itemIndex) {
//           case 0:
//             return 'Internal cold water taps and single mixer taps in kitchen or bathroom hand basins have a maximum flow rate of 9 litres per minute';
//           case 1:
//             return 'No leaking taps';
//           default:
//             return '';
//         }
//       default:
//         return '';
//     }
//   }

//   void _selectDate(int index) async {
//     final DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (selectedDate != null) {
//       setState(() {
//         _selectedDates[index] = selectedDate;
//       });
//     }
//   }
// }

// import 'package:flutter/material.dart';

// class CompliancePage extends StatefulWidget {
//   final ComplianceData data;

//   CompliancePage({Key? key, required this.data}) : super(key: key);

//   @override
//   _CompliancePageState createState() => _CompliancePageState();
// }

// class ChecklistItem {
//   final String title;
//   bool isChecked;

//   ChecklistItem(this.title, this.isChecked);
// }

// class ComplianceData {
//   final List<bool> checklistItems;
//   String waterMeterReading;
//   final String cleaningRepairNotes;
//   String installationWtrMeasuresOn;
//   String paintPremisesExternalOn;
//   String paintPremisesInternalOn;
//   String landlordAgreesWorkOn;
//   String flooringCleanReplacedOn;

//   ComplianceData({
//     required this.checklistItems,
//     required this.waterMeterReading,
//     required this.cleaningRepairNotes,
//     required this.installationWtrMeasuresOn,
//     required this.paintPremisesExternalOn,
//     required this.paintPremisesInternalOn,
//     required this.landlordAgreesWorkOn,
//     required this.flooringCleanReplacedOn,
//   });
// }

// class _CompliancePageState extends State<CompliancePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80.0,
//         backgroundColor: Color.fromRGBO(162, 154, 255, 1),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "Utilities",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//             fontSize: 37.0,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.copy),
//             onPressed: () {
//               // Handle copy button press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.create),
//             onPressed: () {
//               // Handle create button press
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: widget.data.checklistItems.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: EdgeInsets.all(10.0),
//             child: ExpansionTile(
//               title: Text(widget.data.checklistItems[index].title),
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CheckboxListTile(
//                       title: Text('Completed'),
//                       value: widget.data.checklistItems[index].isChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           widget.data.checklistItems[index].isChecked =
//                               value ?? false;
//                         });
//                       },
//                     ),
//                     if (index == 2)
//                       Column(
//                         children: [
//                           Align(
//                               alignment: Alignment.topLeft,
//                               child: Text('Water meter reading')),
//                           TextField(
//                             controller: TextEditingController(
//                                 text: widget.data.waterMeterReading),
//                             decoration: InputDecoration(
//                               labelText: '0',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 3)
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             Row(
//                               children: [
//                                 Text("Installation of water efficiency measures"),
//                                 Align(
//                                   alignment: Alignment.topRight,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       width: 165,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: TextField(
//                                               controller: TextEditingController(
//                                                   text:
//                                                       widget.data.installationWtrMeasuresOn),
//                                               decoration: InputDecoration(
//                                                 hintText: 'mm / dd / yyyy',
//                                               ),
//                                             ),
//                                           ),
//                                           IconButton(
//                                             icon: Icon(Icons.calendar_today),
//                                             onPressed: () =>
//                                                 _selectDate(index),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     if (index == 3)
//                       Row(
//                         children: [
//                           Text("Painting of premises (external)"),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: 165,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextField(
//                                         controller: TextEditingController(
//                                             text:
//                                                 widget.data.paintPremisesExternalOn),
//                                         decoration: InputDecoration(
//                                           hintText: 'mm / dd / yyyy',
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.calendar_today),
//                                       onPressed: () => _selectDate(index),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 3)
//                       Row(
//                         children: [
//                           Text("Painting of premises (internal)"),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: 165,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextField(
//                                         controller: TextEditingController(
//                                             text:
//                                                 widget.data.paintPremisesInternalOn),
//                                         decoration: InputDecoration(
//                                           hintText: 'mm / dd / yyyy',
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.calendar_today),
//                                       onPressed: () => _selectDate(index),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 3)
//                       Row(
//                         children: [
//                           Text("Flooring laid/replaced/cleaned"),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: 165,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextField(
//                                         controller: TextEditingController(
//                                             text:
//                                                 widget.data.flooringCleanReplacedOn),
//                                         decoration: InputDecoration(
//                                           hintText: 'mm / dd / yyyy',
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.calendar_today),
//                                       onPressed: () => _selectDate(index),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 4)
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               "Agrees to undertake the following cleaning, repairs, additions, or other work during the tenancy",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                           TextField(
//                             controller:
//                                 TextEditingController(text: widget.data.cleaningRepairNotes),
//                             decoration: InputDecoration(
//                               labelText: 'Comment...',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     if (index == 4)
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             Text("Landlord agrees to complete that work by"),
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   width: 165,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.grey),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: TextField(
//                                           controller: TextEditingController(
//                                               text: widget.data.landlordAgreesWorkOn),
//                                           decoration: InputDecoration(
//                                             hintText: 'mm / dd / yyyy',
//                                           ),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         icon: Icon(Icons.calendar_today),
//                                         onPressed: () => _selectDate(index),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _selectDate(int index) async {
//     final DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (selectedDate != null) {
//       setState(() {
//         switch (index) {
//           case 2:
//             widget.data.waterMeterReading = selectedDate.toLocal().toString();
//             break;
//           case 3:
//             widget.data.installationWtrMeasuresOn =
//                 selectedDate.toLocal().toString();
//             break;
//           case 4:
//             widget.data.paintPremisesExternalOn = selectedDate.toLocal().toString();
//             break;
//           case 5:
//             widget.data.paintPremisesInternalOn = selectedDate.toLocal().toString();
//             break;
//           case 6:
//             widget.data.flooringCleanReplacedOn = selectedDate.toLocal().toString();
//             break;
//           case 7:
//             widget.data.landlordAgreesWorkOn = selectedDate.toLocal().toString();
//             break;
//         }
//       });
//     }
//   }
// }

// import 'package:flutter/material.dart';

// class CompliancePage extends StatefulWidget {
//   final ComplianceData data;

//   CompliancePage({Key? key, required this.data}) : super(key: key);

//   @override
//   _CompliancePageState createState() => _CompliancePageState();
// }

// class ComplianceData {
//   bool signsMouldsDampness;
//   bool pestsVermin;
//   bool rubbishBinLeftPremises;
//   bool telephoneLinePremises;
//   bool internetLinePremises;
//   bool showerWaterRateLtrMinute;
//   bool internalBasinsWaterRateLtrMinute;
//   bool noLickingTaps;
//   String waterMeterReading;
//   String cleaningRepairNotes;
//   String installationWaterMeasuresOn;
//   String paintPremisesExternalOn;
//   String paintPremisesInternalOn;
//   String landlordAgreesWorkOn;
//   String flooringCleanReplacedOn;

//   ComplianceData({
//     required this.signsMouldsDampness,
//     required this.pestsVermin,
//     required this.rubbishBinLeftPremises,
//     required this.telephoneLinePremises,
//     required this.internetLinePremises,
//     required this.showerWaterRateLtrMinute,
//     required this.internalBasinsWaterRateLtrMinute,
//     required this.noLickingTaps,
//     required this.waterMeterReading,
//     required this.cleaningRepairNotes,
//     required this.installationWaterMeasuresOn,
//     required this.paintPremisesExternalOn,
//     required this.paintPremisesInternalOn,
//     required this.landlordAgreesWorkOn,
//     required this.flooringCleanReplacedOn,
//   });
// }

// class _CompliancePageState extends State<CompliancePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80.0,
//         backgroundColor: Color.fromRGBO(162, 154, 255, 1),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "Utilities",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//             fontSize: 37.0,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.copy),
//             onPressed: () {
//               // Handle copy button press
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.create),
//             onPressed: () {
//               // Handle create button press
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         children: [
//           CheckboxListTile(
//             title: Text("Signs of Moulds and Dampness"),
//             value: widget.data.signsMouldsDampness,
//             onChanged: (value) {
//               setState(() {
//                 widget.data.signsMouldsDampness = value ?? false;
//               });
//             },
//           ),
//           CheckboxListTile(
//             title: Text("Pests and Vermin"),
//             value: widget.data.pestsVermin,
//             onChanged: (value) {
//               setState(() {
//                 widget.data.pestsVermin = value ?? false;
//               });
//             },
//           ),
//           CheckboxListTile(
//             title: Text("Rubbish Bin Left on Premises"),
//             value: widget.data.rubbishBinLeftPremises,
//             onChanged: (value) {
//               setState(() {
//                 widget.data.rubbishBinLeftPremises = value ?? false;
//               });
//             },
//           ),
//           CheckboxListTile(
//             title: Text("Telephone Line on Premises"),
//             value: widget.data.telephoneLinePremises,
//             onChanged: (value) {
//               setState(() {
//                 widget.data.telephoneLinePremises = value ?? false;
//               });
//             },
//           ),
//           CheckboxListTile(
//             title: Text("Internet Line on Premises"),
//             value: widget.data.internetLinePremises,
//             onChanged: (value) {
//               setState(() {
//                 widget.data.internetLinePremises = value ?? false;
//               });
//             },
//           ),
//           CheckboxListTile(
//             title: Text("Shower Water Rate (Ltr/Minute)"),
//             value: widget.data.showerWaterRateLtrMinute,
//             onChanged: (value) {
//               setState(() {
//                 widget.data.showerWaterRateLtrMinute = value ?? false;
//               });
//             },
//           ),
//           CheckboxListTile(
//             title: Text("Internal Basins Water Rate (Ltr/Minute)"),
//             value: widget.data.internalBasinsWaterRateLtrMinute,
//             onChanged: (value) {
//               setState(() {
//                 widget.data.internalBasinsWaterRateLtrMinute = value ?? false;
//               });
//             },
//           ),
//           CheckboxListTile(
//             title: Text("No Licking Taps"),
//             value: widget.data.noLickingTaps,
//             onChanged: (value) {
//               setState(() {
//                 widget.data.noLickingTaps = value ?? false;
//               });
//             },
//           ),
//           if (widget.data.signsMouldsDampness)
//             TextField(
//               controller:
//                   TextEditingController(text: widget.data.waterMeterReading),
//               decoration: InputDecoration(
//                 labelText: "Water Meter Reading",
//               ),
//             ),
//           if (widget.data.signsMouldsDampness)
//             TextField(
//               controller:
//                   TextEditingController(text: widget.data.cleaningRepairNotes),
//               decoration: InputDecoration(
//                 labelText: "Cleaning/Repair Notes",
//               ),
//             ),
//           if (widget.data.signsMouldsDampness)
//             TextField(
//               controller: TextEditingController(
//                   text: widget.data.installationWaterMeasuresOn),
//               decoration: InputDecoration(
//                 labelText: "Installation of Water Efficiency Measures On",
//               ),
//             ),
//           if (widget.data.signsMouldsDampness)
//             TextField(
//               controller: TextEditingController(
//                   text: widget.data.paintPremisesExternalOn),
//               decoration: InputDecoration(
//                 labelText: "Painting of Premises (External) On",
//               ),
//             ),
//           if (widget.data.signsMouldsDampness)
//             TextField(
//               controller: TextEditingController(
//                   text: widget.data.paintPremisesInternalOn),
//               decoration: InputDecoration(
//                 labelText: "Painting of Premises (Internal) On",
//               ),
//             ),
//           if (widget.data.signsMouldsDampness)
//             TextField(
//               controller:
//                   TextEditingController(text: widget.data.landlordAgreesWorkOn),
//               decoration: InputDecoration(
//                 labelText: "Landlord Agrees to Complete Work On",
//               ),
//             ),
//           if (widget.data.signsMouldsDampness)
//             TextField(
//               controller: TextEditingController(
//                   text: widget.data.flooringCleanReplacedOn),
//               decoration: InputDecoration(
//                 labelText: "Flooring Laid/Replaced/Cleaned On",
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CompliancePage extends StatefulWidget {
  bool? signs_moulds_dampness;
  bool? pests_vermin;
  bool? rubbish_bin_left_premises;
  bool? telephone_line_premises;
  bool? internet_line_premises;
  bool? shower_wtr_rate_ltr_minute;
  bool? internal_basins_wtr_rate_ltr_minute;
  bool? no_licking_taps;
  final String water_meter_reading;
  final String cleaning_repair_notes;
  final String instalation_wtr_measures_on;
  final String paint_premises_external_on;
  final String paint_premises_internal_on;
  final String landlord_aggred_work_on;
  final String flooring_clean_replaced_on;

  CompliancePage({
    Key? key,
    this.signs_moulds_dampness,
    this.pests_vermin,
    this.rubbish_bin_left_premises,
    this.telephone_line_premises,
    this.internet_line_premises,
    this.shower_wtr_rate_ltr_minute,
    this.internal_basins_wtr_rate_ltr_minute,
    this.no_licking_taps,
    required this.water_meter_reading,
    required this.cleaning_repair_notes,
    required this.instalation_wtr_measures_on,
    required this.paint_premises_external_on,
    required this.paint_premises_internal_on,
    required this.landlord_aggred_work_on,
    required this.flooring_clean_replaced_on,
  }) : super(key: key);

  @override
  _CompliancePageState createState() => _CompliancePageState();
}

class _CompliancePageState extends State<CompliancePage> {
  List<bool> _isExpandedList = List.generate(5, (index) => false);
  List<List<bool>> _checklistItems = [
    List<bool>.filled(3, false), // Index 0
    List<bool>.filled(2, false), // Index 1
    List<bool>.filled(3, false), // Index 2
    List<bool>.filled(0, false), // Index 3
    List<bool>.filled(0, false), // Index 4 (or as needed)
  ];
  List<DateTime?> _selectedDates = List.filled(5, null);
  List<TextEditingController> _textControllers =
      List.generate(5, (_) => TextEditingController());

  final List<String> items = [
    'Health Issues',
    'Communication Facilities',
    'Water Efficiency Device',
    'Work Last Done',
    "Landlord's promise to undertake work",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color.fromRGBO(162, 154, 255, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Utilities",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 37.0,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.copy),
        //     onPressed: () {
        //       // Handle copy button press
        //     },
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.create),
        //     onPressed: () {
        //       // Handle create button press
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10.0),
              child: ExpansionTile(
                title: Text(items[index]),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < _checklistItems[index].length; i++)
                        CheckboxListTile(
                          title: Text(getChecklistItemTitle(index, i)),
                          value: getChecklistItemValue(index, i),
                          onChanged: (newValue) {
                            updateChecklistItemValue(index, i, newValue);
                          },
                        ),
                      if (index >= 2 && index <= 7)
                        Row(
                          children: [
                            Text(getDateFieldTitle(index)),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 165,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: buildDateTextField(index),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_today),
                                        onPressed: () => _selectDate(index),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool getChecklistItemValue(int index, int itemIndex) {
    switch (index) {
      case 0:
        switch (itemIndex) {
          case 0:
            return widget.signs_moulds_dampness ?? false;
          case 1:
            return widget.pests_vermin ?? false;
          case 2:
            return widget.rubbish_bin_left_premises ?? false;
        }
        break;
      case 1:
        switch (itemIndex) {
          case 0:
            return widget.telephone_line_premises ?? false;
          case 1:
            return widget.internet_line_premises ?? false;
        }
        break;
      case 2:
        switch (itemIndex) {
          case 0:
            return widget.shower_wtr_rate_ltr_minute ?? false;
          case 1:
            return widget.internal_basins_wtr_rate_ltr_minute ?? false;
          case 2:
            return widget.no_licking_taps ?? false;
        }
        break;
      default:
        return false;
    }
    return false;
  }

  void updateChecklistItemValue(int index, int itemIndex, bool? newValue) {
    switch (index) {
      case 0:
        switch (itemIndex) {
          case 0:
            widget.signs_moulds_dampness = newValue;
            break;
          case 1:
            widget.pests_vermin = newValue;
            break;
          case 2:
            widget.rubbish_bin_left_premises = newValue;
            break;
        }
        break;
      case 1:
        switch (itemIndex) {
          case 0:
            widget.telephone_line_premises = newValue;
            break;
          case 1:
            widget.internet_line_premises = newValue;
            break;
        }
        break;
      case 2:
        switch (itemIndex) {
          case 0:
            widget.shower_wtr_rate_ltr_minute = newValue;
            break;
          case 1:
            widget.internal_basins_wtr_rate_ltr_minute = newValue;
            break;
          case 2:
            widget.no_licking_taps = newValue;
            break;
        }
        break;
    }
    setState(() {});
  }

  String getChecklistItemTitle(int index, int itemIndex) {
    switch (index) {
      case 0:
        switch (itemIndex) {
          case 0:
            return 'Signs of moulds and dampness';
          case 1:
            return 'Pests and vermin';
          case 2:
            return 'Rubbish bin left on the premises';
        }
        break;
      case 1:
        switch (itemIndex) {
          case 0:
            return 'A telephone line is connected to the residential premises';
          case 1:
            return 'An internet line is connected to the residential premises';
        }
        break;
      case 2:
        switch (itemIndex) {
          case 0:
            return 'Showerheads have a maximum flow rate of 9 liters per minute';
          case 1:
            return 'Internal cold water taps and single mixer taps in kitchen or bathroom hand basins have a maximum flow rate of 9 litres per minute';
          case 2:
            return 'No leaking taps';
        }
        break;
      default:
        return '';
    }
    return '';
  }

  String getDateFieldTitle(int index) {
    switch (index) {
      case 2:
        return 'Water meter reading';
      case 3:
        return 'Installation of water efficiency measures';
      case 4:
        return 'Painting of premises (external)';
      case 5:
        return 'Painting of premises (internal)';
      case 6:
        return 'Landlord agrees to undertake the following work';
      case 7:
        return 'Landlord agrees to complete that work by';
      default:
        return '';
    }
  }

  TextField buildDateTextField(int index) {
    String dateValue = _getInitialDateValue(index);

    return TextField(
      controller: _textControllers[index],
      decoration: InputDecoration(
        hintText: dateValue,
      ),
    );
  }

  String _getInitialDateValue(int index) {
    switch (index) {
      case 2:
        return widget.water_meter_reading;
      case 3:
        return widget.instalation_wtr_measures_on;
      case 4:
        return widget.paint_premises_external_on;
      case 5:
        return widget.paint_premises_internal_on;
      case 6:
        return widget.landlord_aggred_work_on;
      case 7:
        return widget.flooring_clean_replaced_on;
      default:
        return '';
    }
  }

  void _selectDate(int index) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDates[index] = selectedDate;
        _textControllers[index].text =
            "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
      });
    }
  }
}
