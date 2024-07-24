// FirebaseDatabase.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../routes/AppRoutes.dart';

class FirebaseDatabase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
      print('cadastrado com sucesso!');
      print('Email: $email /// Senha: $password');
      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao realizar cadastro: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro desconhecido: $e')),
      );
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login realizado com sucesso!')),
      );
      print('logado com sucesso!');
      print('Email: $email');
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao realizar login: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro desconhecido: $e')),
      );
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail de redefinição enviado com sucesso!')),
      );
      Navigator.pop(context);  // Voltar para a página de login
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar e-mail de redefinição: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro desconhecido: $e')),
      );
    }
  }

  Future<void> addTask({
    required BuildContext context,
    required String title,
    required String description,
    required bool completed,
  }) async {
    try {
      CollectionReference tasks = _firestore.collection('tasks');
      await tasks.add({
        'title': title,
        'description': description,
        'completed': completed,
        'created_at': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarefa adicionada com sucesso!')),
      );
      Navigator.pop(context); 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar tarefa: $e')),
      );
    }
  }
}
