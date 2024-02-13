import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToDoListTile extends StatelessWidget {
  const ToDoListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          const Text('Subject'),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.archive),
          ),
        ],
      ),
      subtitle: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi'),
            Text(
              DateFormat.yMMMEd().format(DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }
}
