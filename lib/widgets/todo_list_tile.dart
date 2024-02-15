import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/home/home_view_model.dart';

class ToDoListTile extends StatelessWidget {
  const ToDoListTile({
    required this.todoModel,
    Key? key,
  }) : super(key: key);
  final ToDoModel todoModel;

  @override
  Widget build(BuildContext context) {
    var cubit = HomeViewModel.get(context);
    return ListTile(
      title: Row(
        children: [
          Text(todoModel.title),
          const Spacer(),
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
