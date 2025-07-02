import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final IconData? icon;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.isPassword,
    this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        labelText: label,
        filled: true,
        fillColor: Theme.of(context).cardColor.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}