import 'package:flutter/material.dart';
import '../utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<dynamic>> todoList = [
    ['Buy groceries', false],
    ['Walk the dog', false],
    ['Finish project report', false],
    ['Call the plumber', false],
    ['Book flight tickets', false],
  ];

  final TextEditingController controller = TextEditingController();

  void checkBoxChange(int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void addTask() {
    if (controller.text.isNotEmpty) {
      setState(() {
        todoList.add([controller.text, false]);
        controller.clear(); // Clear the input field after adding
      });
    }
  }

  void removeTask(index) {
    if (todoList[index][1]) {
      setState(() {
        todoList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 236, 218),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String task = todoList[index][0];
            bool isDone = todoList[index][1];
            return TodoList(
                taskName: task,
                isDone: isDone,
                onChanged: (value) => checkBoxChange(index),
                onDelete: (value) => removeTask(index));
          },
        ),
      ),
      floatingActionButton: FloatingInput(),
    );
  }

  Padding FloatingInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 28),
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.amber), // Focused border color
                    borderRadius: BorderRadius.circular(15),
                  ),

                  hintText: 'Add a new task',

                  hintStyle:
                      const TextStyle(color: Colors.grey), // Hint text color
                  filled: true,
                  fillColor: Colors.black, // Dark background for the TextField
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.amber), // Focused border color
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding:
                      const EdgeInsets.all(16), // Padding inside the TextField
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: addTask,
            backgroundColor: Colors.amber, // Background color of the button
            child: const Icon(
              Icons.add,
              size: 24,
              color: Colors.black, // Icon color
            ),
          ),
        ],
      ),
    );
  }
}
