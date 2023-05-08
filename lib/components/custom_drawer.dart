import 'package:flutter/material.dart';
import 'package:online_clothing_store/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pages/login_page.dart';
import 'tiles/drawtile.dart';
import 'gradient.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key, required this.pageController});
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          GradientApp(
            colors: [
              Theme.of(context).primaryColor,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          ListView(
            padding: const EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8,
                      left: 0,
                      child: Image(
                        image: AssetImage('assets/logo1.png'),
                        height: 120,
                        width: 120,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                'Olá, ${!model.isLoggedIn() ? '' : model.userData!['name'] }',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                child: Text(model.isLoggedIn() ? 'Sair' :
                                  'Entre ou cadastre-se >',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  if (!model.isLoggedIn()) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => LoginPage()),
                                    );
                                  } else {
                                    model.logout();
                                  }
                                  
                                },
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              DrawTile(icon: Icons.home, text: 'Início', controller: pageController, page: 0),
              DrawTile(icon: Icons.list, text: 'Produtos', controller: pageController, page: 1),
              DrawTile(icon: Icons.location_on, text: 'Lojas', controller: pageController, page: 2),
              DrawTile(icon: Icons.playlist_add_check, text: 'Meus Pedidos', controller: pageController, page: 3),
            ],
          ),
        ],
      ),
    );
  }
}
