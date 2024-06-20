// lib/screens/edit_todo_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todolist_app/const/app_fonts.dart';
import 'package:todolist_app/controller/todo_list_controller.dart';

import 'package:todolist_app/model/todo_list_model.dart';

class EditTodoScreen extends StatelessWidget {
  final TodoTaskModel todoTaskModel;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  EditTodoScreen({required this.todoTaskModel}) {
    _titleController.text = todoTaskModel.title;
    _descriptionController.text = todoTaskModel.description;
  }

  @override
  Widget build(BuildContext context) {
    final todoTaskController = Get.find<TodolistController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Edit To-Do',
        style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Title',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  )),
                  ksizedBox20,
                Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextFormField(
                
                      textCapitalization: TextCapitalization.words,
                             style: TextStyle(color: Colors.white),
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            ksizedBox40,
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                  ),),
                  ksizedBox20,
                Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                               style: TextStyle(color: Colors.white),
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            ksizedBox40,
            ksizedBox40,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150.w, 40.h)
              ),
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  // Update todo
                  todoTaskModel.title = _titleController.text;
                  todoTaskModel.description = _descriptionController.text;
                  todoTaskController.updateTask(todoTaskModel);
                
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
              
                      backgroundColor: Colors.green[100],
                      content: Text('Todo-List updated successfully',
                      style: TextStyle(
                        color: Colors.black
                      ),),
                      duration: Duration(seconds: 2),
                    ),
                  );
                   
                  Get.back(); 
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
