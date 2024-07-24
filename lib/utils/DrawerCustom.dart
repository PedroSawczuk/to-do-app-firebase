import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes/AppRoutes.dart';
import 'ColorsCustom.dart';

class DrawerCustom extends StatelessWidget {
  DrawerCustom({super.key});
  final User? user = FirebaseAuth
      .instance.currentUser; // Pega o usuário que está logado atualmente

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorsCustom.colorPrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'To Do App',
                  style: TextStyle(
                      fontSize: 21,
                      color: ColorsCustom.colorWhite,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  user?.email ?? 'Não autenticado',
                  style: TextStyle(
                      fontSize: 21,
                      fontStyle: FontStyle.italic,
                      color: ColorsCustom.colorWhite,
                      fontWeight: FontWeight.normal),
                ), // se estiver logado, aparece o email do usuário. Caso não esteja, aparece o texto "Não autenticado"
              ],
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(
                  context, AppRoutes.homePage); // Rota para a homePage
            },
          ),
          ListTile(
            title: Text('Ver Tarefas Concluidas'),
            onTap: () {
              Navigator.pushNamed(
                  context,
                  AppRoutes
                      .viewCompletedTaskPage); // Rota para a página de tarefas completadas
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () async {
              await FirebaseAuth.instance
                  .signOut(); // Uma ferramente do FirebaseAuth para fazer logout
              Navigator.pushReplacementNamed(
                  context, AppRoutes.loginPage); // Volta para a página de login
            },
          ),
        ],
      ),
    );
  }
}
