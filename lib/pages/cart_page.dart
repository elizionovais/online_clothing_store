import 'package:flutter/material.dart';
import 'package:online_clothing_store/components/price_card.dart';
import 'package:online_clothing_store/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

import '../components/discount_card.dart';
import '../components/ship_card.dart';
import '../components/tiles/cart_tile.dart';
import '../models/cart_model.dart';
import 'login_page.dart';
import 'order_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int? p = model.products.length;
                return Text(
                  '$p ${p == 1 ? 'ITEM' : 'ITENS'}',
                  style: const TextStyle(fontSize: 17),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if(model.isLoading && UserModel.of(context).isLoggedIn()) {
          return const Center(child: CircularProgressIndicator());
        } else if(!UserModel.of(context).isLoggedIn()) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Icon(Icons.remove_shopping_cart, size: 80, color: Theme.of(context).primaryColor),
                const SizedBox(height: 16),
                const Text('Faça o login para adicionar produtos!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          );
        } else if(
          model.products == null || model.products.length == 0
         ) {
          return const Center(child: Text('Nenhum produto no carrinho!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center));
        } else {
          return ListView(
            children: [
              Column(
                children: model.products.map((product) {
                  return CartTile(cartProduct: product);
                }).toList(),
              ),
              const DiscountCard(),
              const ShipCard(),
              PriceCard(
                buy: () async {
                  String? orderId = await model.finishOrder();
                  if(orderId != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrderPage(orderid: orderId)));
                  }
                }
              )
            ],
          );
        }
      },
      ),
    );
  }
}