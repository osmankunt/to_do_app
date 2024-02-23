import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/view/archived/archived_view_model.dart';
import 'package:to_do_app/view/done/done_view_model.dart';
import 'package:to_do_app/view/home/home_view_model.dart';
import 'package:to_do_app/view/main/main_view.dart';
import 'package:to_do_app/view/main/main_view_model.dart';
import 'package:to_do_app/view/todos/todos_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ToDoModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox<ToDoModel>(Constants.toDoBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeViewModel()),
        BlocProvider<MainViewModel>(create: (context) => MainViewModel()),
        BlocProvider<ToDoViewModel>(create: (context) => ToDoViewModel()),
        BlocProvider<DoneViewModel>(create: (context) => DoneViewModel()),
        BlocProvider<ArchivedViewModel>(create: (context) => ArchivedViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const MainView(),
      ),
    );
  }
}
