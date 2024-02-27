import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'done_states.dart';

class DoneViewModel extends Cubit<DoneStates> {
  DoneViewModel() : super(DoneStates()) {
    getFilterList();
  }

  void getFilterList() async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    await getHiveBox();
    filterList(toDoList);
  }

  List<ToDoModel>? toDoList = [];
  List<ToDoModel>? filteredList = [];

  void filterList(List<ToDoModel>? toDoList) {
    if (toDoList != null) {
      for (var item in toDoList) {
        if (item.isDone) {
          filteredList?.add(item);
        }
      }
    }
    emit(state.copyWith(doneList: filteredList, viewStatus: ViewStatus.success));
  }

  // get hive box
  getHiveBox() async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    var box = await Hive.openBox<ToDoModel>(Constants.toDoBox);

    // Empty the HiveBox
    //box.deleteFromDisk();
    var keys = [];
    keys = box.keys.cast<int>().toList();
    toDoList = [];
    for (var key in keys) {
      toDoList!.add(box.get(key)!);
    }
    emit(state.copyWith(doneList: toDoList, viewStatus: ViewStatus.success));
  }
}
