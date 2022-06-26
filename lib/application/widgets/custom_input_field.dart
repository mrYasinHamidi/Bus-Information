import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final Color fillColor;
  final Color borderColor;
  final Color activeBorderColor;
  final double borderWidth;
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
    this.readOnly=false,this.text,
    this.fillColor = Colors.grey,
    this.activeBorderColor = Colors.blue,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
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
        // icon: icon,
        prefixIcon: icon,
        label: label == null ? null : Text(label ?? ''),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: activeBorderColor,
            width: borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      ),
      keyboardType: inputType,
      validator: validator,
      onChanged: onChange,
      readOnly: readOnly,
    );
  }
}
