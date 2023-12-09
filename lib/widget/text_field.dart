import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String text;
  final TextEditingController textController;
  final VoidCallback? callback;
  final IconData? icon;

  const TextInputField(
      {required this.textController,
      this.callback,
      required this.text,
      this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onTap: () => callback != null ? callback!() : null,
        controller: textController,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black45),
          errorStyle: const TextStyle(color: Colors.redAccent),
          border: const OutlineInputBorder(),
          suffixIcon: icon != null ? Icon(icon) : null,
          labelText: text,
        ),
      ),
    );
  }
}
