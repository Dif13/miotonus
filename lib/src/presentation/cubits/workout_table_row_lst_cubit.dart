import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/workout_table_row.dart';

class WorkoutTableRowLstCubit extends Cubit<List<WorkoutTableRow>> {
  WorkoutTableRowLstCubit()
      : super([
          WorkoutTableRow(
              id: -1,
              time: DateTime.now(),
              localMin: 0.0,
              localMax: 0.0,
              muscleTone: 5),
        ]);

  void updateState() {
    state.last = WorkoutTableRow(
        id: state.last.id,
        time: DateTime.now(),
        localMin: state.last.localMin,
        localMax: state.last.localMax,
        muscleTone: state.last.muscleTone);
    print(state.length);
    print(state.last.id);

    emit([...state]);
    state.last.id++;
    state.add(
      WorkoutTableRow(
          id: state.last.id,
          time: DateTime.now(),
          localMin: 0.0,
          localMax: 0.0,
          muscleTone: 5),
    );
  }
}
