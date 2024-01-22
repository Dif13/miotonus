import 'package:flutter/material.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';
import 'package:miotonus/src/presentation/pages/workout/widgets/workout_form_field.dart';
import 'package:miotonus/src/presentation/pages/workout/widgets/workout_table.dart';

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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              workoutFormFields(
                userCubit,
                workoutTableRowLstCubit,
              ),
              workoutTable(
                userCubit,
                workoutTableRowLstCubit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
