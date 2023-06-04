import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_todo_flutter/controller/todo_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: todoController.todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  onTap: () {
                    todoController.todoTitleController.text = todoController.todoList[index].title!;
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        height: 240,
                        width: Get.width,
                        child: Form(
                          key: todoController.formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: todoController.todoTitleController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "can't empty";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text("Title"),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: Get.width,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    todoController.updateTodo(todoController.todoList[index].key);
                                  },
                                  child: const Text("UPDATE"),
                                ),
                              ),
                              const SizedBox(height: 20)
                            ],
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                    );
                  },
                  title: Text(todoController.todoList[index].title!),
                  leading: Checkbox(
                    value: todoController.todoList[index].isEnable,
                    onChanged: (value) {
                      todoController.setData(todoController.todoList[index]);
                      todoController.onCheckTodo(todoController.todoList[index].key, value);
                    },
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        todoController.deleteTodo(todoController.todoList[index].key);
                      },
                      icon: const Icon(Icons.delete)),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoController.todoTitleController.clear();
          Get.bottomSheet(
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              height: 240,
              width: Get.width,
              child: Form(
                key: todoController.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: todoController.todoTitleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "can't empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: Get.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: todoController.createTodo,
                        child: const Text("ADD"),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
