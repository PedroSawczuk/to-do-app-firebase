/* Aqui é todas as rotas utilizadas no projeto */

import 'package:flutter/material.dart';
import '../pages/HomePage.dart';
import '../pages/autenticacao/SignUpPage.dart';
import '../pages/autenticacao/LoginPage.dart';
import '../pages/autenticacao/ForgotPasswordPage.dart';
import '../pages/to-do/addTask.dart';
import '../pages/to-do/editTaskPage.dart';
import '../pages/to-do/viewCompletedTaskPage.dart';

class AppRoutes {
  static const homePage = '/homePage';
  static const signUpPage = '/signUpPage';
  static const loginPage = '/loginPage';
  static const forgotPasswordPage = '/forgotPasswordPage';
  static const addTaskPage = '/addTaskPage';
  static const editTaskPage = '/editTaskPage';
  static const viewCompletedTaskPage = '/viewCompletedTaskPage';

  static Map<String, WidgetBuilder> define() {
    return {
      homePage: (BuildContext context) => HomePage(),
      signUpPage: (BuildContext context) => SignUpPage(),
      loginPage: (BuildContext context) => LoginPage(),
      forgotPasswordPage: (BuildContext context) => ForgotPasswordPage(),
      addTaskPage: (BuildContext context) => AddTaskPage(),
      editTaskPage: (BuildContext context) { // Função para criar a página de edição de tarefas
        // pega os argumentos para essa rota utilizando o "ModalRoute"
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        // pega o 'taskId' dos argumentos para identificar a tarefa para ser editada
        final taskId = args['taskId'] as String;
        // volta para a página 'EditTaskPage' (Para editar a tarefa) utilizando 'taskId' como parametro'
        return EditTaskPage(taskId: taskId);
      },
      viewCompletedTaskPage: (BuildContext context) => ViewCompletedTaskPage(),
    };
  }
}
