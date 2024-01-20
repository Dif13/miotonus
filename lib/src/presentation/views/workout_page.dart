import 'package:flutter/material.dart';
import 'package:miotonus/src/domain/models/hieght_class.dart';
import 'package:miotonus/src/presentation/widgets/WorkoutFormFieldHeight.dart';
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
  Height height = Height(localMin: '', localMax: '');

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
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  workoutFormFieldHeight(
                    _formKey,
                    workoutFormHintTextMinHeight,
                    (value) {
                      height.localMin = value ?? '';
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: standartEdge)),
                  workoutFormFieldHeight(
                    _formKey,
                    workoutFormHintTextMaxHeight,
                    (value) {
                      height.localMax = value ?? '';
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: standartEdge)),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(height.localMin);
                        print(height.localMax);
                      }
                    },
                    child: const Text(workoutFormTextButtonConfirm),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
