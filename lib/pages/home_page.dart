import 'package:flutter/material.dart';
import 'package:online_clothing_store/components/cart_buttom.dart';
import 'package:online_clothing_store/pages/tabs/home_tab.dart';
import 'package:online_clothing_store/pages/tabs/my_orders_tab.dart';
import 'package:online_clothing_store/pages/tabs/places_tab.dart';
import 'package:online_clothing_store/pages/tabs/products_tab.dart';

import '../components/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          floatingActionButton: CartButtom(),
          body: const HomeTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Produtos'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: const ProductsTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Lojas'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: const PlacesTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Meus Pedidos'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: const OrdersTab(),
          drawer: CustomDrawer(pageController: _pageController),
        )
      ],
    );
  }
}
