import 'package:flutter_bloc/flutter_bloc.dart';
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

  List<int> getMuscleTone(
    UserCubit userCubit,
    double localMaxHeight,
    double localMinHeight,
  ) {
    double diffMaxHeight = localMaxHeight - userCubit.state.minHeight;
    double diffMinHeight = localMinHeight - userCubit.state.minHeight;

    int maxHeightMusculeToneX1 = ((4.4 - diffMaxHeight) / 0.1).round(); //[0;25]
    int maxHeightMusculeToneX2 =
        ((diffMaxHeight + 0.554) / 0.09908).round(); //[25;50]

    int minHeightMusculeToneX1 =
        ((diffMinHeight + 0.2243) / 0.08969).round(); //[0;25]
    int minHeightMusculeToneX2 =
        ((9.07 - diffMinHeight) / 0.2821).round(); //[25;32]
    int minHeightMusculeToneX3 =
        ((diffMinHeight + 7.3268) / 0.2303).round(); //[32;50]

    Set maxHeightMusculeToneX = {
      maxHeightMusculeToneX1 <= 25 ? maxHeightMusculeToneX1 : null,
      maxHeightMusculeToneX2 >= 25 ? maxHeightMusculeToneX2 : null,
    };
    Set minHeightMusculeToneX = {
      minHeightMusculeToneX1 <= 25 ? minHeightMusculeToneX1 : null,
      minHeightMusculeToneX2 >= 25 && minHeightMusculeToneX2 <= 32
          ? minHeightMusculeToneX2
          : null,
      minHeightMusculeToneX3 >= 32 ? minHeightMusculeToneX3 : null,
    };
    print('maxHeightMusculeToneX: $maxHeightMusculeToneX');
    print('minHeightMusculeToneX: $minHeightMusculeToneX');

    int distance;

    Map<int, List<List<int>>> pairs = {};
    if (maxHeightMusculeToneX.isNotEmpty) {
      for (int maxX in maxHeightMusculeToneX) {
        for (int minX in minHeightMusculeToneX) {
          distance = (minX - maxX).abs();
          if (pairs[distance]?.length == null) {
            pairs[distance] = [
              [minX, maxX]
            ];
          } else {
            pairs[distance]!.add([minX, maxX]);
          }
        }
      }

      List<int> keys = pairs.keys.toList();
      keys.sort();
      List<int> muscleTone;
      print("keys: $keys");
      for (int key in keys) {
        for (List<int> pair in pairs[key]!) {
          muscleTone = [GetMuscleTone(pair[0]), GetMuscleTone(pair[1])];
          return muscleTone;
        }
      }
    }
    return [-1, -1];
  }

  int GetMuscleTone(int toneGrade) {
    print('toneGrade: $toneGrade');
    if (toneGrade >= 0 && toneGrade <= 5) {
      return 1;
    }
    if (toneGrade >= 6 && toneGrade <= 13) {
      return 2;
    }
    if (toneGrade >= 14 && toneGrade <= 21) {
      return 3;
    }
    if (toneGrade >= 22 && toneGrade <= 27) {
      return 4;
    }
    if (toneGrade >= 28 && toneGrade <= 36) {
      return 5;
    }
    if (toneGrade >= 37 && toneGrade <= 50) {
      return 6;
    } else {
      return -1;
    }
  }
}
