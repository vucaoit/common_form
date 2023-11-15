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
              onFormValid: (formValid) {
                if (formValid) {
                  print("form valid");
                } else {
                  print("form invalid");
                }
              },
              listFieldBuilder: (context, checkFormValid) {
                return [
                  CommonField(
                    isRequired: true,
                    builder: (context, setFieldValid) {
                      return TextFormField(
                        onChanged: (value) {
                          setFieldValid.call(value.isNotEmpty);
                        },
                      );
                    },
                    onFieldValid: (isFieldValid) {
                      checkFormValid(isFieldValid);
                    },
                    title: 'Email',
                  ),
                  CommonField(
                    isRequired: true,
                    builder: (context, setFieldValid) {
                      return TextFormField(
                        onChanged: (value) {
                          setFieldValid.call(value.isNotEmpty);
                        },
                      );
                    },
                    onFieldValid: (isFieldValid) {
                      // checkFormValid(isFieldValid);
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
