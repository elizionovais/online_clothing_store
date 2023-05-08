import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: const Text(
          'Calcular frete',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        leading: const Icon(Icons.location_on),
        trailing: const Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu CEP',
              ),
              initialValue: '',
              onFieldSubmitted: (text) {},
            ),
          ),
        ],
      ),
    );
  }
}