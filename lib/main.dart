import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_clothing_store/models/cart_model.dart';
import 'package:online_clothing_store/models/user_models.dart';
import 'package:online_clothing_store/pages/home_page.dart';
import 'package:online_clothing_store/pages/login_page.dart';
import 'package:scoped_model/scoped_model.dart';

import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return ScopedModel<UserModel>(
            model: UserModel(),
            child: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                return ScopedModel<CartModel>(
                  model: CartModel(model),
                  child: MaterialApp(
                    title: 'RGD Store',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                      primaryColor: const Color.fromARGB(255, 43, 43, 43),
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                    ),
                    debugShowCheckedModeBanner: false,
                    home: const HomePage(),
                  ),
                );
              },
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
