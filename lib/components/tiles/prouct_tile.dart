import 'package:flutter/material.dart';

import '../../data/product_data.dart';
import '../../pages/product_page.dart';

class ProductTile extends StatelessWidget {
  ProductTile({super.key, required this.type, required this.product});

  String? type;
  ProductData product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //ao clicar no card, vai para a tela de detalhes do produto
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(
                  product: product,
                )));
      },
      child: Card(
          //mostra o card com o tipo de layout escolhido
          child: type == 'grid'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.8,
                      //mostra a imagem do produto
                      child: Image.network(
                        product.images![0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            //mostra o titulo do produto
                            Text(
                              product.title!,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            //mostra o preço do produto
                            Text(
                              'R\$ ${product.price!.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              //type == 'list'
              : Row(
                  children: [
                    //mostra a imagem do produto
                    Flexible(
                      flex: 1,
                      child: Image.network(
                        product.images![0],
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //mostra o titulo do produto
                            Text(
                              product.title!,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            //mostra o preço do produto
                            Text(
                              'R\$ ${product.price!.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}
