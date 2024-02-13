import 'package:flutter/material.dart';

class ToDosView extends StatelessWidget {
  const ToDosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Text(index.toString());
      },
    );
  }
}
