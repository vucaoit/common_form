import 'package:common_form/common_field.dart';
import 'package:common_form/common_form.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: CommonForm(
              onFormValid: (valid) {
                if (valid) {
                  print("form valid");
                } else {
                  print("form invalid");
                }
              },
              listFieldBuilder: (context, checkValid) {
                return [
                  CommonField(
                    isRequired: true,
                    builder: (context, setValid) {
                      return TextFormField(
                        onChanged: (value) {
                          setValid.call(value.isNotEmpty);
                        },
                      );
                    },
                    onFieldValid: (isFieldValid) {
                      checkValid(isFieldValid);
                    },
                    title: 'Email',
                  ),
                  CommonField(
                    isRequired: true,
                    builder: (context, setValid) {
                      return TextFormField(
                        onChanged: (value) {
                          setValid.call(value.isNotEmpty);
                        },
                      );
                    },
                    onFieldValid: (isFieldValid) {
                      // checkValid(isFieldValid);
                    },
                    title: 'Password',
                  )
                ];
              },
            ),
          ),
        ),
      ),
    );
  }
}
