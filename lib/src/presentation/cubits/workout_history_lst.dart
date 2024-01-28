import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/workout.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';

class WorkoutHistoryLstCubit extends Cubit<List<Workout>> {
  WorkoutHistoryLstCubit()
      : super(
          [
            Workout(
              id: 0,
              workoutTable: WorkoutTableRowLstCubit(),
            )
          ],
        );

  void addWorkoutToHistory(WorkoutTableRowLstCubit workout) {
    state.last = Workout(id: state.last.id, workoutTable: workout);
    emit([...state]);
    state.add(Workout(
      id: state.last.id + 1,
      workoutTable: WorkoutTableRowLstCubit(),
    ));
  }
}
