import 'package:common_form/common_field.dart';
import 'package:flutter/material.dart';

class CommonForm extends StatefulWidget {
  const CommonForm(
      {super.key, required this.onFormValid, required this.listFieldBuilder});

  final Function(bool) onFormValid;
  final List<CommonField> Function(BuildContext,Function(bool)) listFieldBuilder;

  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  int count = 0;
@override
  void initState() {
    super.initState();
    for (var element in widget.listFieldBuilder(context,(b){})) {
      if(element.isFieldRequired()){
        count++;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.listFieldBuilder(context,(formValid){
        checkValidForm(formValid);
      }),
    );
  }

  checkValidForm(bool isFieldValid) {
    if (isFieldValid) {
      count--;
    } else {
      count++;
    }
    widget.onFormValid.call(isFormValid());
  }

  bool isFormValid() {
    print("count : $count");
    if (count == 0) {
      return true;
    }
    return false;
  }
}
