// // class Area {
// //   String name;
// //   String description;
// //   String imagePath; // Path to the image file on local storage

// //   Area({required this.name, required this.description, required this.imagePath});
// // }
class Areas {
  final String name;
  final String notes;
  final String photosNotes;
  final String tenantComment;
  bool isDeleted;
  List<Area> items; // List of Item
  List<dynamic> photos; // List of Photo

  Areas({
    required this.name,
    required this.notes,
    required this.photosNotes,
    required this.tenantComment,
    required this.isDeleted,
    required this.items,
    required this.photos,
  });
}

class Inspection {
  String name;
  String notes;
  String photosNotes;
  String tenantComment;
  bool isDeleted;
  List<Area> items;

  Inspection({
    required this.name,
    required this.notes,
    required this.photosNotes,
    required this.tenantComment,
    required this.isDeleted,
    required this.items,
  });
}

class Area {
  String name;
  String agentComment;
  String otherComment;
  bool isDeleted;
  List<Condition> conditions;

  Area({
    required this.name,
    required this.agentComment,
    required this.otherComment,
    required this.isDeleted,
    required this.conditions,
  });
}

class Condition {
  String name;
  String value;

  Condition({required this.name, required this.value});
}
// class Area {
//   String name;
//   String agentComment;
//   String otherComment;
//   bool isDeleted;
//   List<Condition> conditions;

//   Area({
//     required this.name,
//     required this.agentComment,
//     required this.otherComment,
//     required this.isDeleted,
//     required this.conditions,
//   });
// }

// class Condition {
//   String name;
//   String value;

//   Condition({required this.name, required this.value});
// }

// class Areas {
//   final String name;
//   final String notes;
//   final String photosNotes;
//   final String tenantComment;
//   bool isDeleted;
//   List<Area> items;
//   List<dynamic> photos;

//   Areas({
//     required this.name,
//     required this.notes,
//     required this.photosNotes,
//     required this.tenantComment,
//     required this.isDeleted,
//     required this.items,
//     required this.photos,
//   });
// }
