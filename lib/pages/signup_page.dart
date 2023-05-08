import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user_models.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Criar Conta'),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: 'Nome',
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40.0)))),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (value.length < 3) {
                            return 'Nome muito curto';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          hintText: 'E-mail',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40.0)))),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (!value.contains('@')) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          hintText: 'Senha',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40.0)))),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (value.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                          hintText: 'Endereço',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40.0)))),
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (value.length < 6) {
                          return 'Endereço muito curto';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> userData = {
                              'name': _nameController.text,
                              'email': _emailController.text,
                              'address': _addressController.text
                            };
                            model.signUp(
                                userData: userData,
                                pass: _passwordController.text,
                                onSuccess: () {
                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                    content: const Text('Usuário criado com sucesso!'),
                                    backgroundColor: Theme.of(context).primaryColor,
                                    duration: const Duration(seconds: 4),
                                  ));
                                  Future.delayed(const Duration(seconds: 4), () {
                                    Navigator.of(context).pop();
                                  });
                                },
                                onFail: () {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Falha ao criar conta'),
                                    backgroundColor: Colors.redAccent,
                                    duration: Duration(seconds: 4),
                                  ));
                                });
                          }
                        },
                        child: const Text(
                          'Criar Conta',
                          style: TextStyle(fontSize: 18.0),
                        )),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
