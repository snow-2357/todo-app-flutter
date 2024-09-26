import 'package:flutter/material.dart';

class FloatingInput extends StatelessWidget {
  const FloatingInput({super.key, required this.controller, this.addTask});

  final TextEditingController controller;
  final Function()? addTask;

  @override
  Widget build(BuildContext context) {
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
