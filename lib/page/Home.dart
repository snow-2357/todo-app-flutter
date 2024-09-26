import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert'; // For JSON encoding/decoding
import '../utils/floating_input.dart';
import '../utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<dynamic>> todoList = [];
  final TextEditingController controller = TextEditingController();
  final _storage = const FlutterSecureStorage();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Load tasks from secure storage
  Future<void> _loadTasks() async {
    String? storedData = await _storage.read(key: 'todoList');

    if (storedData != null) {
      setState(() {
        todoList.addAll(List<List<dynamic>>.from(json.decode(storedData)));
      });
    }
  }

  // Save tasks to secure storage
  Future<void> _saveTasks() async {
    await _storage.write(key: 'todoList', value: json.encode(todoList));
  }

  void checkBoxChange(int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
    _saveTasks();
  }

  void addTask() {
    if (controller.text.isNotEmpty) {
      setState(() {
        todoList.insert(0, [controller.text, false]);
        controller.clear();
      });
      _saveTasks();
    }
    scrollToTop();
  }

  void removeTask(int index) {
    if (todoList[index][1]) {
      setState(() {
        todoList.removeAt(index);
      });
      _saveTasks();
    }
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0, // Scroll to the top
      duration: const Duration(milliseconds: 500), // Animation duration
      curve: Curves.easeOut, // Animation curve
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: todoList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == todoList.length) {
              // This is the extra space at the bottom
              return const SizedBox(height: 100); // Adjust the height as needed
            } else {
              String task = todoList[index][0];
              bool isDone = todoList[index][1];
              return TodoList(
                  taskName: task,
                  isDone: isDone,
                  onChanged: (value) => checkBoxChange(index),
                  onDelete: (value) => removeTask(index));
            }
          },
        ),
      ),
      floatingActionButton: FloatingInput(
        controller: controller,
        addTask: addTask,
      ),
    );
  }
}
