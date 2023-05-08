import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String? id;
  String? category;
  String? title;
  String? description;
  double? price;
  List? images;
  List? sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot.get('title');
    description = snapshot.get('description');
    price = snapshot.get('price') + 0.0;
    images = snapshot.get('images');
    sizes = snapshot.get('sizes');
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
    };
  }
}
