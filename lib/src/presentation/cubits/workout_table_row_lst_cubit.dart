import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/utils/services/muscle_tone.dart';
import 'package:miotonus/src/domain/models/workout_table_row.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';

class WorkoutTableRowLstCubit extends Cubit<List<WorkoutTableRow>> {
  WorkoutTableRowLstCubit()
      : super(
          [
            WorkoutTableRow(
              id: -1,
              time: DateTime.now(),
              localMaxHeight: 0.0,
              localMinHeight: 0.0,
              muscleToneMaxHeight: -1,
              muscleToneMinHeight: -1,
            ),
          ],
        );

  void updateState(
    UserCubit userCubit,
    double localMaxHeight,
    double localMinHeight,
  ) {
    List<int> muscleTone = getMuscleTone(
      userCubit,
      localMaxHeight,
      localMinHeight,
    );
    state.last = WorkoutTableRow(
      id: state.last.id,
      time: DateTime.now(),
      localMinHeight: localMinHeight,
      localMaxHeight: localMaxHeight,
      muscleToneMaxHeight: muscleTone[0],
      muscleToneMinHeight: muscleTone[1],
    );
    //print(localHieghtMin);
    // print(state.last.id);

    emit([...state]);
    state.last.id++;
    state.add(
      WorkoutTableRow(
        id: state.last.id,
        time: DateTime.now(),
        localMaxHeight: state.last.localMaxHeight,
        localMinHeight: state.last.localMinHeight,
        muscleToneMaxHeight: muscleTone[0],
        muscleToneMinHeight: muscleTone[1],
      ),
    );
  }
}
