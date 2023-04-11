import 'package:flutter/material.dart';
import 'package:tmdb/app/core/ui/extensions/theme_extension.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator; 
  final String label;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;

  CustomTextFormField(
      {super.key, required this.label, this.obscureText = false, this.controller, this.validator})
      : _obscureTextVN = ValueNotifier(obscureText);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget._obscureTextVN,
        builder: (_, obscureTextVNValue, child) {
          return TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              obscureText: obscureTextVNValue,
              decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle:
                      const TextStyle(fontSize: 15, color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15), gapPadding: 0),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      gapPadding: 0,
                      borderSide: const BorderSide(color: Colors.grey)),
                  suffixIcon: widget.obscureText
                      ? IconButton(
                          onPressed: () {
                            widget._obscureTextVN.value = !obscureTextVNValue;
                          },
                          icon: Icon(
                              obscureTextVNValue ? Icons.lock : Icons.lock_open,
                              color: context.primaryColor))
                      : null));
        });
  }
}
