import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/utils/index.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';

import 'main_view_model_states.dart';

class MainViewModel extends Cubit<MainViewModelStates> {
  MainViewModel() : super(const MainViewModelStates(index: 0));

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }
}
