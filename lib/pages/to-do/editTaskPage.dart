import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/ColorsCustom.dart';

class EditTaskPage extends StatefulWidget {
  final String taskId;

  EditTaskPage({required this.taskId});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  Future<void> _loadTask() async {
    DocumentSnapshot taskDoc = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.taskId)
        .get();
    final taskData = taskDoc.data() as Map<String, dynamic>;
    _titleController.text = taskData['title'];
    _descriptionController.text = taskData['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa'),
        backgroundColor: ColorsCustom.colorPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('tasks')
                    .doc(widget.taskId)
                    .update({
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                   /* Aqui atualiza o title e description para atualização acima. Pegando pelo ID*/
                });
                Navigator.pop(context);
              },
              child: Text('Salvar'),
              style: ElevatedButton.styleFrom(
                foregroundColor: ColorsCustom.colorWhite,
                backgroundColor: ColorsCustom.colorPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
