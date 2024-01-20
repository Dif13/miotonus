import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/hieght_class.dart';
import 'package:miotonus/src/presentation/cubits/height_cubit.dart';
import 'package:miotonus/src/presentation/widgets/workout_form_field_height.dart';
import 'package:miotonus/src/utils/constants/nums.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, required this.title});

  final String title;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final heightCubit = HeightCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          formFields(),
          BlocBuilder<HeightCubit, Height>(
              bloc: heightCubit,
              builder: (context, height) {
                return Column(
                  children: [
                    Text(height.localMin.toString()),
                    Text(height.localMax.toString()),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget formFields() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          workoutFormFieldHeight(
            _formKey,
            workoutFormHintTextMinHeight,
            (value) {
              heightCubit.state.localMin = double.tryParse(value ?? '') ?? 0.0;
            },
          ),
          const Padding(padding: EdgeInsets.only(top: standartEdge)),
          workoutFormFieldHeight(
            _formKey,
            workoutFormHintTextMaxHeight,
            (value) {
              heightCubit.state.localMax = double.tryParse(value ?? '') ?? 0.0;
            },
          ),
          const Padding(padding: EdgeInsets.only(top: standartEdge)),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                heightCubit.update_state();
                print(heightCubit.state.localMin);
                print(heightCubit.state.localMax);
              }
            },
            child: const Text(workoutFormTextButtonConfirm),
          ),
          const Padding(padding: EdgeInsets.only(top: standartEdge)),
        ],
      ),
    );
  }
}
