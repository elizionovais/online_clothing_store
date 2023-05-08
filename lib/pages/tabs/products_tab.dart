import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/tiles/category_tile.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('products').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var dividedTiles = ListTile.divideTiles(
            //pega cada documento/ cada documento se torna um CategoryTile
            // transforma todos os CategoryTile em uma lista
            tiles: snapshot.data!.docs.map((doc) {
              return CategoryTile(snapshot: doc);
            }).toList(),
            color: Colors.grey[500],
          ).toList();
          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
