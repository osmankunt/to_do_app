import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/home/home_view.dart';

const String toDoBox = "todos";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var path = Directory.current.path;
  Hive.init(path);
  Hive.registerAdapter(ToDoModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox<ToDoModel>(toDoBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
