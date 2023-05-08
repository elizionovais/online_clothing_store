import 'package:flutter/material.dart';
import 'package:online_clothing_store/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PriceCard extends StatelessWidget {
   PriceCard({super.key, required this.buy});

  VoidCallback buy;
  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: ScopedModelDescendant<CartModel>(builder: (context, child, model) {

          double shipPrice = model.getShipPrice();
          double discount = model.getDiscount();
          double price = model.getProductsPrice();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Resumo do pedido',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Subtotal'),
                  Text('R\$ ${price.toStringAsFixed(2)}'),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Desconto'),
                  Text(
                      'R\$ ${discount.toStringAsFixed(2)} (${model.cupomCode})'),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Entrega'),
                  Text(
                      'R\$ ${shipPrice.toStringAsFixed(2)}'),
                ],
              ),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'R\$ ${(price + shipPrice - discount).toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: buy,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text('Finalizar Pedido'),
              ),
            ],
          );
        },)
      ),
    );
  }
}