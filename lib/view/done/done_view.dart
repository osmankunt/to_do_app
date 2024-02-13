import 'package:flutter/material.dart';

class DoneView extends StatelessWidget {
  const DoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Text(index.toString());
      },
    );
  }
}
