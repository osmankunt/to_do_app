import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'done_states.dart';

class DoneViewModel extends Cubit<DoneStates> {
  DoneViewModel() : super(DoneStates()) {
    getHiveBox();
  }

  static DoneViewModel get(context) => BlocProvider.of(context);
  List<ToDoModel>? toDoList = [];

  // change state
  changeState({List<ToDoModel>? toDoList, ViewStatus? viewStatus}) {
    emit(state.copyWith(toDoList: toDoList, viewStatus: viewStatus));
  }

  // get hive box
  getHiveBox() async {
    changeState(viewStatus: ViewStatus.loading);
    var box = await Hive.openBox<ToDoModel>(Constants.toDoBox);

    // Empty the HiveBox
    //box.deleteFromDisk();
    var keys = [];
    keys = box.keys.cast<int>().toList();
    toDoList = [];
    for (var key in keys) {
      toDoList!.add(box.get(key)!);
    }
    changeState(toDoList: toDoList, viewStatus: ViewStatus.success);
  }
}
