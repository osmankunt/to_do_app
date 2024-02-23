import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';

class DoneStates extends Equatable {
  const DoneStates({this.viewStatus = ViewStatus.initial});

  final ViewStatus viewStatus;

  @override
  List<Object?> get props => [viewStatus];

  DoneStates copyWith({ViewStatus? viewStatus}) {
    return DoneStates(viewStatus: viewStatus ?? this.viewStatus);
  }
}
