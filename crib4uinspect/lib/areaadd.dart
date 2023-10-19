// class Area {
//   String name;
//   String description;
//   String imagePath; // Path to the image file on local storage

//   Area({required this.name, required this.description, required this.imagePath});
// }
class Areas {
  final String name;
  final String notes;
  final String photosNotes;
  final String tenantComment;
  bool isDeleted;
  List<dynamic> items; // List of Item
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

class InspectionItem {
  final String name; // The name of the inspection item
  final String agentComment; // Comment from the agent
  final String otherComment; // Other comment
  final bool isDeleted; // Indicates if the item is deleted
  final List<Condition> conditions; // List of conditions for the item

  InspectionItem({
    required this.name,
    required this.agentComment,
    required this.otherComment,
    required this.isDeleted,
    required this.conditions,
  });
}

class Condition {
  final String name; // The name of the condition (e.g., "Clean," "Undamaged")
  final String value; // The value associated with the condition

  Condition({
    required this.name,
    required this.value,
  });
}

class Item {
  final String name; // The name or description of the item
  final double price; // The price or cost of the item
  final int quantity; // The quantity of the item
  final List<InspectionItem> inspectionItems; // List of inspection items

  Item({
    required this.name,
    required this.price,
    required this.quantity,
    required this.inspectionItems,
  });
}

class Photo {
  final String imageUrl; // URL or path to the image
  final String caption; // A caption or description for the photo
  // Add other relevant properties
  Photo({
    required this.imageUrl,
    required this.caption,
    // Add other properties as needed
  });
}
