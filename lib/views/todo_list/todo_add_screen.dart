// lib/screens/add_todo_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todolist_app/const/app_fonts.dart';
import 'package:todolist_app/model/todo_list_model.dart';

import '../../controller/todo_list_controller.dart';


class TodoAddScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  var todoController = Get.find<TodolistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('Add To-Do',
        style:TextStyle(
          color: Colors.white
        )),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 13,right: 13),
          child: ListView(
            
            children: [
              ksizedBox40,
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white
                  )),
                  ksizedBox20,
                  Container(
                    height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                        style: TextStyle(color: Colors.white),

                      controller: _titleController,
                      decoration: InputDecoration(
                        
                        labelText: 'Enter your title',
                        hintStyle: TextStyle(
                        color: Colors.white
                        ),
                        
                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(10)
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
                    fontSize: 15.sp,
                    color: Colors.white
                  ),),
                  ksizedBox20,
                  Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                         style: TextStyle(color: Colors.white),
                      maxLines: 10,
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: ' Enter your description',
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
              ksizedBox20,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150.w, 40.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    TodoTaskModel newTodo = TodoTaskModel(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    todoController.addTask(newTodo);
                     ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
              
                      backgroundColor: Colors.green[100],
                      content: Text('Todo-Add updated successfully',
                      style: TextStyle(
                        color: Colors.black
                      ),),
                      duration: Duration(seconds: 2),
                    ),
                  );
                    Get.back();
                  }
                },
                child: Text('Add',
                style: TextStyle(
                  fontSize: 17
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
