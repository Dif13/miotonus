import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miotonus/src/config/router.dart';
import 'package:miotonus/src/presentation/pages/workout_page/widgets/workout_form_field.dart';
import 'package:miotonus/src/presentation/pages/workout_page/widgets/workout_table.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({
    super.key,
  });

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(workoutTitle),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              workoutFormFields(userCubit, workoutTableRowLstCubit),
              const SizedBox(height: 16),
              workoutTable(userCubit, workoutTableRowLstCubit), //, constraint),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  workoutHistoryLstCubit
                      .addWorkoutToHistory(workoutTableRowLstCubit);
                  workoutTableRowLstCubit.clearTableState(userCubit);
                  context.go('/workout_list');
                },
                child: const Text('Завершить тренировку'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  workoutTableRowLstCubit.clearTableState(userCubit);
                },
                child: const Text(
                  workoutButtonTextClearWorkout,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ));
  }
}
