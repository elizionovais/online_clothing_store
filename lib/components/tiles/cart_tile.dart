import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_clothing_store/data/cart_product.dart';

import '../../data/product_data.dart';
import '../../models/cart_model.dart';

class CartTile extends StatelessWidget {
   CartTile({super.key, required this.cartProduct});

  CartProduct cartProduct;


  @override
  Widget build(BuildContext context) {


    Widget _buildContent(BuildContext context) {
      CartModel.of(context).updatePrices();
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 120,
            child: Image.network(cartProduct.productData!.images![0],
                fit: BoxFit.cover),
            
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartProduct.productData!.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'Tamanho: ${cartProduct.size}',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'R\$ ${cartProduct.productData!.price!.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: cartProduct.quantity! > 1
                            ? () {
                                CartModel.of(context).decProduct(cartProduct);
                              }
                            : null,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          CartModel.of(context).incProduct(cartProduct);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          CartModel.of(context).removeProduct(cartProduct);
                        },
                        child: const Text('Remover'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }


    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null?
      FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('products').doc(cartProduct.category).collection('items').doc(cartProduct.productId).get(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            cartProduct.productData = ProductData.fromDocument(snapshot.data!);
            return _buildContent(context);
          } else {
            return Container(
              height: 70,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ) : _buildContent(context),
    );
  }
}