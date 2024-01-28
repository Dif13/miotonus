import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/workout.dart';
import 'package:miotonus/src/domain/models/workout_table_row.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';

class WorkoutHistoryLstCubit extends Cubit<List<Workout>> {
  WorkoutHistoryLstCubit()
      : super(
          [
            Workout(
              id: 0,
              workoutTable: [],
            )
          ],
        );

  void addWorkoutToHistory(WorkoutTableRowLstCubit workout) {
    List<WorkoutTableRow> newWorkout =
        List.from(workout.state.sublist(0, workout.state.length - 1));
    int currentId = state.last.id;
    state.last = Workout(id: currentId, workoutTable: newWorkout);
    emit([...state]);
    state.add(Workout(
      id: state.last.id + 1,
      workoutTable: [],
    ));
  }
}
