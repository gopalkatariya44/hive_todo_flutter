import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_todo_flutter/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  Rx<Todo> todoObj = Todo().obs;
  Todo get todo => todoObj.value;
  setData(Todo todo) {
    todoObj.value = todo;
  }

  final formKey = GlobalKey<FormState>();
  final todoTitleController = TextEditingController();
  final todoBox = Hive.box('todo');
  var uuid = const Uuid();

  var todoList = <Todo>[].obs;
  var todoCompleteList = <Todo>[].obs;

  createTodo() {
    if (formKey.currentState!.validate()) {
      todoBox.add(Todo(
        id: uuid.v1(),
        title: todoTitleController.text,
        isEnable: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJson());
      Get.back();
      refreshTodoList();
    }
  }

  updateTodo(key) {
    todoBox.put(
      key,
      Todo(
        id: todo.id,
        title: todoTitleController.text,
        isEnable: todo.isEnable,
        createdAt: todo.createdAt,
        updatedAt: DateTime.now(),
      ).toJson(),
    );
    Get.back();
    refreshTodoList();
  }

  onCheckTodo(key, isEnable) {
    todoBox.put(
      key,
      Todo(
        id: todo.id,
        title: todo.title,
        isEnable: isEnable,
        createdAt: todo.createdAt,
        updatedAt: DateTime.now(),
      ).toJson(),
    );
    refreshTodoList();
  }

  deleteTodo(key) {
    todoBox.delete(key);
    refreshTodoList();
  }

  refreshTodoList() {
    todoList.clear();
    todoCompleteList.clear();
    final todos = todoBox.keys.map((key) {
      final todo = Map<String, dynamic>.from(todoBox.get(key));
      todo.addAll({"key": key});
      return Todo.fromJson(todo);
    }).toList();
    for (var todo in todos) {
      if (todo.isEnable == false) {
        todoList.add(todo);
      } else {
        todoCompleteList.add(todo);
      }
    }
    // todoList.value = todos.reversed.cast<Todo>().toList();
  }

  @override
  void onInit() {
    refreshTodoList();
    super.onInit();
  }
}
