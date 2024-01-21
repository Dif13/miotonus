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
              muscleTone: 0.0,
            ),
          ],
        );

  void updateState(
    UserCubit userCubit,
    double localMaxHeight,
    double localMinHeight,
  ) {
    double muscleTone = getMuscleTone(
      userCubit,
      localMaxHeight,
      localMinHeight,
    );
    state.last = WorkoutTableRow(
        id: state.last.id,
        time: DateTime.now(),
        localMinHeight: localMinHeight,
        localMaxHeight: localMaxHeight,
        muscleTone: muscleTone);
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
          muscleTone: 5),
    );
  }

  double getMuscleTone(
    UserCubit userCubit,
    double localMaxHeight,
    double localMinHeight,
  ) {
    /*

    1. Зона индивидуальных минимальных и максимальных значений роста (с 0 по 5 градацию);
    2. Зона оптимальных значений тонуса мышц (с 6 по 13 градацию);
    3. Рабочая зона (с 14 по 21 градацию);
    4. Зона резко повышенного тонуса всех скелетных мышц (с 22 по 27 градацию);
    5. Зона "второго дыхания" (с 28 по 36 градацию);
    6. Зона повышенного тонуса (с 37 по 50 градацию) 
*/
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
      maxHeightMusculeToneX1 >= 0 && maxHeightMusculeToneX1 <= 25
          ? maxHeightMusculeToneX1
          : null,
      maxHeightMusculeToneX2 >= 25 && maxHeightMusculeToneX2 <= 50
          ? maxHeightMusculeToneX2
          : null,
    };
    Set minHeightMusculeToneX = {
      minHeightMusculeToneX1 >= 0 && minHeightMusculeToneX1 <= 25
          ? minHeightMusculeToneX1
          : null,
      minHeightMusculeToneX2 >= 25 && minHeightMusculeToneX2 <= 32
          ? minHeightMusculeToneX2
          : null,
      minHeightMusculeToneX3 >= 32 && minHeightMusculeToneX3 <= 50
          ? minHeightMusculeToneX3
          : null,
    };
    print('maxHeightMusculeToneX: $maxHeightMusculeToneX');
    print('minHeightMusculeToneX: $minHeightMusculeToneX');

    int cnt = 0;
    int distance;

    Map<int, List<List<int>>> pairs = {};
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

    print(keys);
    //Todo: Выводдить одну или 2 зоны (в зависимостиот дистанции, наверное). Склеить как строку, наверное

    return 3.0;
  }
}
