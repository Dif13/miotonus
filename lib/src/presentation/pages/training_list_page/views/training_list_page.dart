import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:miotonus/src/config/router.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

class TrainingListPage extends StatefulWidget {
  const TrainingListPage({super.key});

  @override
  State<TrainingListPage> createState() => _TrainingListPageState();
}

class _TrainingListPageState extends State<TrainingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(trainingListTitle),
      ),
      body: BlocBuilder(
          bloc: workoutHistoryLstCubit,
          builder: (context, row) {
            return ListView.separated(
              itemCount: workoutHistoryLstCubit.state.length - 1,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text(workoutHistoryLstCubit.state[index].id.toString()),
                  onTap: () {
                    currentAppStateCubit.state.tappedWorkoutID =
                        workoutHistoryLstCubit.state[index].id;
                    context.go('/workout_list/detail');
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          }),
    );
  }
}
