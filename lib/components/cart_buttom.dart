import 'package:flutter/material.dart';

import '../pages/cart_page.dart';

class CartButtom extends StatelessWidget {
   CartButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CartPage()),
      );
    },
    backgroundColor: Theme.of(context).primaryColor,
    child: const Icon(Icons.shopping_cart, color: Colors.white),
    );
  }
}