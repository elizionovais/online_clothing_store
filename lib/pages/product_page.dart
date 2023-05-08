import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_clothing_store/data/cart_product.dart';
import 'package:online_clothing_store/data/product_data.dart';
import 'package:online_clothing_store/models/cart_model.dart';
import 'package:online_clothing_store/pages/login_page.dart';

import '../components/cart_buttom.dart';
import '../models/user_models.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key, required this.product});

  ProductData product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? size;
  int corrente = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CartButtom(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.product.title!),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              items: widget.product.images!.map((url) {
                return Image.network(url);
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true, //rolar as imagens automaticamente
                aspectRatio: 1.0,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  setState(() {
                    corrente = index;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.images!.map((url) {
              int index = widget.product.images!.indexOf(url);
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: corrente == index ? Theme.of(context).primaryColor : Colors.grey,
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${widget.product.price!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.product.sizes!.map((s) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          size = s;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: s == size ? Theme.of(context).primaryColor : Colors.grey[500]!,
                            width: 3,
                          ),
                        ),
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(s),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: size != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {
                              CartProduct cartProduct = CartProduct();
                              cartProduct.size = size;
                              cartProduct.quantity = 1;
                              cartProduct.productId = widget.product.id;
                              cartProduct.category = widget.product.category;
                              cartProduct.productData = widget.product;
                              CartModel.of(context).addProduct(cartProduct);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Produto adicionado ao carrinho!'),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            }
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey[500]!;
                          }
                          return Theme.of(context).primaryColor;
                        },
                      ),
                    ),
                    child: Text( UserModel.of(context).isLoggedIn() ? 'Adicionar ao Carrinho' : 'Entre para Comprar',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.product.description!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
