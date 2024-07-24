import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app_study/utils/DrawerCustom.dart';
import '../../routes/AppRoutes.dart';
import '../../utils/ColorsCustom.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        backgroundColor: ColorsCustom.colorPrimary,
      ),
      drawer: DrawerCustom(),
      // configura uo StreamBuilder para atualizar em tempo real a coleção 'tasks'
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('completed',
                isEqualTo:
                    false) // Um filtro onde mostra todas as tarefas que não foram completas
            .snapshots(),
        builder: (context, snapshot) {
          final tasks = snapshot.data!.docs;
          return ListView.builder(
            itemCount: tasks.length, // verifica quantas tasks tem
            itemBuilder: (context, index) {
              final task = tasks[index]; // obtem a task atual
              final taskData = task.data()
                  as Map<String, dynamic>; // transforma os dados em um mapa

              return ListTile(
                title: Text(taskData['title']), // mostra o titulo da task
                subtitle: Text(taskData['description']), // mostra a da task

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.editTaskPage,
                          arguments: {'taskId': task.id},
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        /* Aqui pega a tarefa pelo ID e deleta utilizando uma Função do Firestone*/
                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(task.id)
                            .delete();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        /* Aqui muda a tarefa de "completed: false" para ==> "completed: true"
                        Pega a tarefa pelo ID e faz um update*/

                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(task.id)
                            .update(
                          {
                            'completed': true,
                          },
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tarefa concluida!')),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTaskPage);
        },
        child: Icon(Icons.add),
        backgroundColor: ColorsCustom.colorPrimary,
      ),
    );
  }
}
