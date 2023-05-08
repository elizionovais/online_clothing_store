import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_clothing_store/data/product_data.dart';

import '../components/cart_buttom.dart';
import '../components/tiles/prouct_tile.dart';

class ListProducts extends StatelessWidget {
  ListProducts({super.key, required this.snapshot});

  DocumentSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: CartButtom(),
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              snapshot?.get('title'),
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.list)),
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              //buscano no banco de dados os produtos da categoria selecionada
              future: FirebaseFirestore.instance.collection('products').doc(snapshot?.id).collection('item').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return TabBarView(
                    children: [
                      //mostra o card com o tipo de layout grid
                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          //convertendo o documento em um objeto do tipo ProductData
                          ProductData data = ProductData.fromDocument(snapshot.data!.docs[index]);
                          //passando o id da categoria para o objeto ProductData
                          data.category = this.snapshot!.id;
                          return ProductTile(type: 'grid', product: data);
                        },
                      ),
                      //mostra o card com o tipo de layout list
                      ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          //convertendo o documento em um objeto do tipo ProductData
                          ProductData data = ProductData.fromDocument(snapshot.data!.docs[index]);
                          //passando o id da categoria para o objeto ProductData
                          data.category = this.snapshot!.id;
                          return ProductTile(type: 'list', product: data);
                        },
                      ),
                    ],
                  );
                }
              }),
        ));
  }
}
