// addTask.dart

import 'package:flutter/material.dart';
import '../../db/FirebaseDatabase.dart';
import '../../utils/ColorsCustom.dart';
import '../../utils/OtherCustom.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Tarefa'),
        backgroundColor: ColorsCustom.colorPrimary,
      ),
      backgroundColor: ColorsCustom.colorWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SB10,
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/add-task-image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SB30,
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) { // Verifica se o campo title task está vazia
                      return 'Por favor, insira o título da tarefa';
                    }
                    return null;
                  },
                ),
                SB10,
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a descrição da tarefa'; // Verifica se o campo description task está vazia
                    }
                    return null;
                  },
                ),
                SB10,
                ElevatedButton(
                  onPressed: () {
                    _addTask();
                  },
                  child: Text('Adicionar Tarefa'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorsCustom.colorWhite,
                    backgroundColor: ColorsCustom.colorPrimary,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/* 
Aqui adiciona todos os campos preenchidos da task e manda para o arquivo 
FirebaseDatabase e adiciona a task com os campos:
- title
- description
- completed
*/

  void _addTask() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;
      bool completed = false;
      _firebaseDatabase.addTask(
        context: context,
        title: title,
        description: description,
        completed: completed,
      );
    }
  }
}
