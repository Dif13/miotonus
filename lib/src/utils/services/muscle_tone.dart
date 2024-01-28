import 'package:miotonus/src/presentation/cubits/user_cubit.dart';

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
  // print(maxHeightMusculeToneX1);
  // print(maxHeightMusculeToneX2);
  // print(minHeightMusculeToneX1);
  // print(minHeightMusculeToneX2);
  // print(minHeightMusculeToneX3);

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

  maxHeightMusculeToneX.removeWhere((element) => element == null);
  minHeightMusculeToneX.removeWhere((element) => element == null);
  int distance;
  Map<int, List<List<int>>> pairs = {};
  if (maxHeightMusculeToneX.isNotEmpty && minHeightMusculeToneX.isNotEmpty) {
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
    for (int key in keys) {
      for (List<int> pair in pairs[key]!) {
        muscleTone = [
          _getMuscleToneGrade(pair[0]),
          _getMuscleToneGrade(pair[1])
        ];
        return muscleTone;
      }
    }
  }
  return [-1, -1];
}

int _getMuscleToneGrade(int toneGrade) {
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
