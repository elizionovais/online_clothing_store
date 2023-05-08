import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../pages/list_products_page.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({
    super.key,
    this.snapshot,
  });
  DocumentSnapshot? snapshot;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          snapshot?.get('icon'),
        ),
      ),
      title: Text(snapshot?.get('title')),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ListProducts(snapshot: snapshot);
        }));
     },
    );
  }
}
