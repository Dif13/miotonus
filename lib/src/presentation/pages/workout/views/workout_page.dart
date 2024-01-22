import 'package:flutter/material.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';
import 'package:miotonus/src/presentation/pages/workout/widgets/workout_form_field.dart';
import 'package:miotonus/src/presentation/pages/workout/widgets/workout_table.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, required this.title});

  final String title;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  UserCubit userCubit = UserCubit();
  WorkoutTableRowLstCubit workoutTableRowLstCubit = WorkoutTableRowLstCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              workoutFormFields(userCubit, workoutTableRowLstCubit),
              const SizedBox(height: 16),
              workoutTable(userCubit, workoutTableRowLstCubit, constraint),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Завершить тренировку'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: TextButton.styleFrom(
                  side: const BorderSide(color: Colors.red, width: 2),
                ),
                onPressed: () {
                  workoutTableRowLstCubit.clearTableState(userCubit);
                },
                child: const Text(workoutButtonTextClearWorkout),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }
}
