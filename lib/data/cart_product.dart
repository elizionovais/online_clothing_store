import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_clothing_store/data/product_data.dart';

class CartProduct {
  String? cartId;
  String? productId;
  String? category;

  int? quantity;
  String? size;

  CartProduct();

  ProductData? productData;
  CartProduct.fromDocument(DocumentSnapshot doc) {
    cartId = doc.id;
    productId = doc.get('productId');
    category = doc.get('category');
    quantity = doc.get('quantity');
    size = doc.get('size');
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "category": category,
      "quantity": quantity,
      "size": size,
      "product": productData?.toResumeMap()
    };
  }

  
}
