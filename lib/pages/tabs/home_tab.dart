import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_clothing_store/pages/list_products_page.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../components/gradient.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientApp(
          colors: [Colors.black, Theme.of(context).primaryColor, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 180,
                  child: const Image(
                    image: AssetImage(
                      'assets/logo1.png',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ]),
            ),
            //SliverToBoxAdapter é um widget que converte um widget normal em um sliver
            //barra de pesquisa
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Pesquisar',
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            //Slider
            FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('home').orderBy('promo').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          height: 200,
                          child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(8),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: snapshot.data!.docs[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                    );
                  }
                }),
            //Novidades
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: 50,
                child: Text(
                  'Novidades!',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //SliverStaggeredGrid é um widget que cria uma grade com tamanhos diferentes
            //para cada item
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('home').orderBy('pos').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SliverGrid(
                    //gridDelegate controla o tamanho e a posição
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      //transforma cada um dos documentos em uma QuiltedGridTiles e converte todas em uma lista
                      pattern: snapshot.data!.docs.map((doc) {
                        return QuiltedGridTile(doc['y'], doc['x']);
                      }).toList(),
                    ),
                    //delegate fornece os itens da lista conforme aparecem
                    //SliverChildBuilderDelegate cria a lista lentamente
                    delegate: SliverChildBuilderDelegate(
                      childCount: snapshot.data!.docs.length,
                      (context, index) => Container(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {},
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: snapshot.data!.docs[index]['image'],
                            fit: BoxFit.cover, //para cobrir todo o espaço possível na tile
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
              //ver mais
            ),
            FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('products').doc('blusas').get(),
                builder: (context, snapshot) {
                  return SliverToBoxAdapter(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      height: 50,
                      child: ListTile(
                        title: Text(
                          'Ver mais',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ListProducts(snapshot: snapshot.data),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        )
      ],
    );
  }
}
