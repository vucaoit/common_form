import 'package:flutter/material.dart';

enum FieldStatus { init, invalid, valid }

class CommonField extends StatefulWidget {
  const CommonField(
      {super.key,
      required this.isRequired,
      required this.builder,
      required this.onFieldValid,
      required this.title});

  final bool isRequired;
  final String title;
  final Widget Function(BuildContext context, Function(bool) setValid) builder;
  final Function(bool) onFieldValid;

  bool isFieldRequired(){
    return isRequired;
  }
  @override
  State<CommonField> createState() => _CommonFieldState();
}

class _CommonFieldState extends State<CommonField> {
  bool isValid = false;
  FieldStatus status = FieldStatus.init;

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
                style: TextStyle(color: Colors.red))
          ]),
        ),
        Container(
          decoration: BoxDecoration(
            border: status == FieldStatus.invalid
                ? Border.all(color: Colors.red)
                : null,
          ),
          child: widget.builder(context, (valid) {
            if (isValid != valid) {
              isValid = valid;
              setState(() {
                widget.onFieldValid(isValid);
              });
              status = isValid ? FieldStatus.valid : FieldStatus.invalid;
            }
          }),
        )
      ],
    );
  }
}
