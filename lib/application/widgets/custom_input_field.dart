import 'package:flutter/material.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';

class CustomInputField extends StatelessWidget {
  final double radius;
  final String? label;
  final Icon icon;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final bool readOnly;
  final String? text;
  final int? maxLength;

  const CustomInputField({
    Key? key,
    this.readOnly = false,
    this.text,
    this.radius = 8,
    this.label,
    this.icon = const Icon(Icons.person),
    this.validator,
    this.onChange,
    this.inputType,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      decoration: InputDecoration(
        label: label == null ? null : Text(label ?? ''),
        prefixIcon: icon,
        enabledBorder:const OutlineInputBorder(
        ),
        focusedBorder: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(),
        focusedErrorBorder: const OutlineInputBorder(),
      ),
      keyboardType: inputType,
      validator: validator,
      onChanged: onChange,
      readOnly: readOnly,
    );
  }
}
