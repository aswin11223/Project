import 'package:flutter/material.dart';

class BuyField extends StatelessWidget {
  final String hinttexxt;
  final bool obs;
  final TextEditingController textcont;
  final FormFieldValidator<String>? validator;

  BuyField({
    required this.hinttexxt,
    required this.obs,
    required this.textcont,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textcont,
      obscureText: obs,
      decoration: InputDecoration(
        hintText: hinttexxt,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
