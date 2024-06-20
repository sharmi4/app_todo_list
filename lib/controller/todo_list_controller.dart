import 'package:get/get.dart';
import 'package:todolist_app/model/todo_list_model.dart';
import 'package:todolist_app/sqflite_database/sqflite_database.dart';

class TodolistController extends GetxController {
  var taskList = <TodoTaskModel>[].obs;
  
  DataBaseHelper dbHelper = DataBaseHelper();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadTasks();
  }
  

 void loadTasks() async {
    List<TodoTaskModel> todolistmodel = await dbHelper.queryAllTasks();
    taskList.assignAll(_removeDuplicates(todolistmodel));
  }
  
  void addTask(TodoTaskModel todo) async {
    await dbHelper.insertTask(todo);
    loadTasks();
  }

  void updateTask(TodoTaskModel todoTaskModel) async {
    await dbHelper.updateTask(todoTaskModel);
    loadTasks();
  }

  void deleteTask(int id) async {
  await dbHelper.deleteTask(id);
  loadTasks();
}


  List<TodoTaskModel> _removeDuplicates(List<TodoTaskModel> tasks) {
    final uniqueTasks = <int, TodoTaskModel>{};
    for (var task in tasks) {
      uniqueTasks[task.id!] = task;
    }
    return uniqueTasks.values.toList();
  }

}
