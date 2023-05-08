import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  OrderTile({super.key, required this.orderId});

  String orderId;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        //Stream builder para atualizar os dados do pedido em tempo real de acordo com o status do pedido
        //stream: metodo que vai ser chamado para atualizar os dados
        child: StreamBuilder<DocumentSnapshot>(
          //coloca .snapshots() (e não .get()) pois quer atualização em tempo real
          stream: FirebaseFirestore.instance.collection('orders').doc(orderId).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else {
              int status = snapshot.data!.get('status');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Código do pedido: ${snapshot.data!.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    _buildProductsText(snapshot.data!),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Text(
                    'Status do pedido:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle('1', 'Preparação', status, 1),
                       Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey,
                      ),
                      _buildCircle('2', 'Transporte', status, 2),
                       Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey,
                      ),
                      _buildCircle('3', 'Entrega', status, 3),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = 'Descrição:\n';
    for(LinkedHashMap p in snapshot.get('products')) {
      text += '${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n';
    }
    text += 'Total: R\$ ${snapshot.get('totalPrice').toStringAsFixed(2)}';
    return text;
  }

  Widget _buildCircle(String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;
    if(status < thisStatus) {
      backColor = Colors.grey[500]!;
      child = Text(title, style: const TextStyle(color: Colors.white));
    }else if(status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: const TextStyle(color: Colors.white)),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    }else {
      backColor = Colors.green;
      child = const Icon(
        Icons.check,
        color: Colors.white,
      );
    }
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(subtitle),
      ],
    );
  }
}
