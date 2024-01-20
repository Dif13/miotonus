import 'package:flutter/material.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

Widget workoutFormFieldHeight(
    GlobalKey myFormKey, String myHintText, Function(String?) callback) {
  return TextFormField(
    onChanged: callback,
    decoration: InputDecoration(
      hintText: myHintText,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return workoutFormTextValidator;
      }
      return null;
    },
  );
}
