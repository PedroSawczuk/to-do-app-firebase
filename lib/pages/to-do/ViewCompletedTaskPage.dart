import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/ColorsCustom.dart';

class ViewCompletedTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas Concluídas'),
        backgroundColor: ColorsCustom.colorPrimary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('completed', isEqualTo: true) // filtra as tasks concluídas
            .snapshots(),
        builder: (context, snapshot) {
          final tasks = snapshot.data!.docs;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final taskData = task.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(taskData['title']),
                subtitle: Text(taskData['description']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(task.id)
                            .delete();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(task.id)
                            .update(
                          {
                            /* Aqui muda a tarefa de "completed: true" para ==> "completed: false"
                        Pega a tarefa pelo ID e faz um update*/
                            'completed': false,
                          },
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tarefa não concluida!')),
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
    );
  }
}
