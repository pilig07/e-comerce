import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final String name;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool OT;

  const AppFormField(
    this.name,
    this.label,
    this.icon,
    this.validator,
    this.OT, {
    Key? key,
    required this.formData,
  }) : super(key: key);

  final Map<String, String> formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        formData[name] = value;
      },
      validator: validator,
      obscureText: OT,
      decoration: InputDecoration(
        icon: Icon(icon),
        hintText: label,
      ),
    );
  }
}
