import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.taskName,
      required this.isDone,
      this.onChanged,
      this.onDelete});

  final String taskName;
  final bool isDone;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
            )
          ],
        ),
        child: TaskCard(),
      ),
    );
  }

  Container TaskCard() {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(15), // Added border radius
        ),
        child: Row(
          children: [
            Checkbox(
              value: isDone,
              onChanged: onChanged,
              checkColor: Colors.white,
              activeColor: Colors.black,
              side: const BorderSide(color: Colors.black),
            ),
            Text(
              taskName[0].toUpperCase() + taskName.substring(1),
              style: TextStyle(
                  // capitalize
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  decoration: isDone
                      ? (TextDecoration.lineThrough)
                      : TextDecoration.none,
                  decorationThickness: 2,
                  color: Colors.black),
            ),
          ],
        ));
  }
}
