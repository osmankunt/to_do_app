import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/todo_list_tile.dart';

class ToDosView extends StatelessWidget {
  const ToDosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const Column(
          children: [
            ToDoListTile(),
            Divider(),
          ],
        );
      },
    );
  }
}
