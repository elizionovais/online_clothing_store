import 'package:flutter/material.dart';
import 'package:online_clothing_store/pages/signup_page.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user_models.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Entrar'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignupPage())
                  );
                },
                child: const Text(
                  'Criar Conta',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ))
          ],
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: 'E-mail',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)))),
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
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)))),
                        keyboardType: TextInputType.visiblePassword,
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
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            model.login(
                                email: _emailController.text,
                                pass: _passwordController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0))),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      TextButton(onPressed: (){
                        if (_emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Insira seu e-mail para recuperação'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            )
                          );
                        } else {
                          model.recoverPass(_emailController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: const Text('Confira seu e-mail'),
                              backgroundColor: Theme.of(context).primaryColor,
                              duration: const Duration(seconds: 2),
                            )
                          );
                        }
                      }, 
                      child: Text('Esqueci minha senha', style: TextStyle(color: Theme.of(context).primaryColor),))
                    ],
                  ),
                ),
              ));
        },));
  }
  void _onSuccess(){
    Navigator.of(context).pop();
  }
  void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Falha ao entrar'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      )
    );
  }
}
