import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_clothing_store/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/cart_product.dart';

class CartModel extends Model {

  UserModel user;
  CartModel(this.user){
    if(user.isLoggedIn()) {
      _loadCartItems();
    }
  }

// com essa static posso chamar o CartModel.of(context) em qualquer lugar
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  List<CartProduct> products = [];
  bool isLoading = false;
  String? cupomCode;
  int discountPercentage = 0;
// adicionar um produto ao carrinho
  void addProduct(CartProduct product) {
    products.add(product);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .add(product.toMap())
        .then((doc) {
      product.cartId = doc.id;
    });

    notifyListeners();
  }
// remover um produto do carrinho
  void removeProduct(CartProduct product) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .doc(product.cartId)
        .delete();

    products.remove(product);


    notifyListeners();
  }

// diminuir a quantidade de um produto no carrinho
  void decProduct(CartProduct product) {
    product.quantity = product.quantity! - 1;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .doc(product.cartId)
        .update(product.toMap());

    notifyListeners();
  }
// aumentar a quantidade de um produto no carrinho
  void incProduct(CartProduct product) {
    product.quantity = product.quantity! + 1;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .doc(product.cartId)
        .update(product.toMap());

    notifyListeners();
  }
// atualizar o carrinho
  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .get();

    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }
// atualizar o cupom de desconto
  void setCoupon(String? couponCode, int discountPercentage) {
    this.cupomCode = couponCode;
    this.discountPercentage = discountPercentage;
  }
// pega o preço total dos produtos
  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      if (c.productData != null) {
        price += c.quantity! * c.productData!.price!;
      }
    }
    return price;
  }
// atualizar o preço com desconto
  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }
// preco do frete
  double getShipPrice() {
    return 9.99;
  }
// atualizar o preço total
  void updatePrices() {
    notifyListeners();
  }

  Future<String?> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder = await FirebaseFirestore.instance
        .collection('orders')
        .add({
      'clientId': user.firebaseUser!.uid,
      'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
      'shipPrice': shipPrice,
      'productsPrice': productsPrice,
      'discount': discount,
      'totalPrice': productsPrice - discount + shipPrice,
      'status': 1,
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('orders')
        .doc(refOrder.id)
        .set({'orderId': refOrder.id});

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .get();

    for (DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }

    products.clear();
    cupomCode = null;
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.id;
  }
}