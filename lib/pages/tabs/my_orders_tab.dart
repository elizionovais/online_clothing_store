import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_clothing_store/models/user_models.dart';
import 'package:online_clothing_store/pages/login_page.dart';

import '../../components/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    if(UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser!.uid;

      //se eu quero um dociumento especifico eu uso o futurebuilder<DocumentSNAPSHOT>
      //se eu quero uma lista de documentos eu uso o futurebuilder<QUERYSNAPSHOT>
      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(uid).collection('orders').get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else {
            return ListView(
              children: snapshot.data!.docs.map((doc) => OrderTile(orderId: doc.id)).toList().reversed.toList(),
            );
          }
        },
        
        );
  }else {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.view_list,
            size: 80.0,
            color: Colors.black,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            'Faça o login para acompanhar!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  LoginPage()),);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
              textStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            child: const Text(
              'Entrar',
              style: TextStyle(fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }

}
}