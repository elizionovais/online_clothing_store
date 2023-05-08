import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser;
  User? currentUser; //variável para quando sair do app, pegar o usuário que ficou logado
  Map<String, dynamic>? userData = {};

  bool isLoading = false;
  //fazendo isso eu posso acessar esse model de qualquer lugar do codigo apenas com UserModel.of(context)....
  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  //função para fazer o login
  void login(
      {required String email, required String pass, required VoidCallback onSuccess, required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then((user) async {
      firebaseUser = user.user;
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  //função para deslogar o usuário
  void logout() {
    _auth.signOut();
    userData = {};
    firebaseUser = null;
    notifyListeners();
  }

  // função para criar um usuário
  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
      email: userData['email'],
      password: pass,
    )
        .then((user) async {
      firebaseUser = user.user;
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  //função para verificar se o usuário está logado
  bool isLoggedIn() {
    return firebaseUser != null;
  }

  //função para recuperar a senha
  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  //função para salvar os dados no firebase
  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection('users').doc(firebaseUser!.uid).set(userData);
  }

  //função para carregar os dados do usuário
  Future<void> _loadCurrentUser() async {
    firebaseUser ??= _auth.currentUser;
    if (firebaseUser != null) {
      if (userData!['name'] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance.collection('users').doc(firebaseUser!.uid).get();
        userData = docUser.data() as Map<String, dynamic>;
      }
    }
    notifyListeners();
  }
}
