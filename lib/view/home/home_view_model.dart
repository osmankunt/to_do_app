import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';

class HomeViewModel extends Cubit<HomeViewModelStates> {
  HomeViewModel() : super(const HomeViewModelStates());

  Index currentIndex = Index.all;

  static HomeViewModel get(context) => BlocProvider.of(context);

  setBottomBar(int index) {
    currentIndex = setIndex(index);
    emit(HomeViewModelStates(index: currentIndex));
  }

  changeState() {}

  Index setIndex(int index) {
    switch (index) {
      case 1:
        return Index.all;
      case 2:
        return Index.done;
      case 3:
        return Index.active;
      default:
        return Index.all;
    }
  }
}
