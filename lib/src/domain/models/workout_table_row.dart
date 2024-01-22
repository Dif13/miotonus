class WorkoutTableRow {
  int id;
  DateTime time;
  double localMaxHeight, localMinHeight;
  int muscleToneMaxHeight;
  int muscleToneMinHeight;
  WorkoutTableRow({
    required this.id,
    required this.time,
    required this.localMaxHeight,
    required this.localMinHeight,
    required this.muscleToneMaxHeight,
    required this.muscleToneMinHeight,
  });
}
