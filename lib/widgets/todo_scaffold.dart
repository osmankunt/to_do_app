import 'package:flutter/material.dart';
import 'package:to_do_app/utils/page_utils.dart';
import 'package:to_do_app/widgets/todo_alert_dialog.dart';

import '../view/archived/archived_view.dart';
import '../view/done/done_view.dart';
import '../view/todos/todos_view.dart';

class ToDoScaffold extends StatelessWidget {
  const ToDoScaffold({required this.pageName, required this.child, Key? key}) : super(key: key);

  final Widget child;
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF9E8C9),
            border: Border.all(width: 4, color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: PageUtils.getPageView(pageName),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ToDoAlertDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
