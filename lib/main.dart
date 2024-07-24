import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'routes/AppRoutes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inicializa o firebase com as opções de configurações da plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // tira aquele banner no canto da tela
    initialRoute: AppRoutes.loginPage, // ao iniciar o app, a primeira página é o de Login
    routes: AppRoutes.define(), // define as rotas do app com base o "routes/AppRoutes".
  ));
}
