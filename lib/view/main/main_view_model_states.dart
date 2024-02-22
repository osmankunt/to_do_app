import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';

class MainViewModelStates extends Equatable {
  const MainViewModelStates({this.viewStatus = ViewStatus.initial, required this.index});

  final ViewStatus viewStatus;
  final int index;

  @override
  List<Object?> get props => [viewStatus, index];

  MainViewModelStates copyWith({ViewStatus? viewStatus, int? index}) {
    return MainViewModelStates(viewStatus: viewStatus ?? this.viewStatus, index: index ?? this.index);
  }
}
