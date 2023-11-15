import 'package:flutter/material.dart';

///
///
/// [init] : when field created at first time
/// [invalid] : when value of field is incorrect
/// [invalid] : when value of field is correct
///
enum FieldStatus { init, invalid, valid }

class CommonField extends StatefulWidget {
  const CommonField(
      {super.key,
      required this.isRequired,
      required this.builder,
      required this.onFieldValid,
      required this.title,
      this.fieldStatus = FieldStatus.init});

  final bool isRequired;

  final FieldStatus fieldStatus;
  final String title;

  ///
  /// [setValid] call when [builder] (textField,ComboBox, DropDown Button) is Valid
  final Widget Function(BuildContext context, Function(bool) setValid) builder;

  ///
  /// return true when field is valid
  final Function(bool) onFieldValid;

  bool isFieldRequired() {
    return isRequired;
  }

  @override
  State<CommonField> createState() => _CommonFieldState();
}

class _CommonFieldState extends State<CommonField> {
  bool _isFieldValid = false;

  late FieldStatus _status;

  @override
  void initState() {
    super.initState();
    _status = widget.fieldStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: widget.title),
            TextSpan(
                text: widget.isRequired ? "*" : '',
                style: const TextStyle(color: Colors.red))
          ]),
        ),
        Container(
          decoration: BoxDecoration(
            border: _status == FieldStatus.invalid
                ? Border.all(color: Colors.red)
                : null,
          ),
          child: widget.builder(context, (childSetValid) {
            // _isFieldValid != childSetValid prevent call multi times
            if (_isFieldValid != childSetValid) {
              _isFieldValid = childSetValid;
              setState(() {
                // set field valid/invalid
                widget.onFieldValid(_isFieldValid);
                // update status
                _status =
                    _isFieldValid ? FieldStatus.valid : FieldStatus.invalid;
              });
            }
          }),
        )
      ],
    );
  }
}
