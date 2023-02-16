import 'package:flutter/material.dart';

class TargetShip extends StatelessWidget {
  final String? title;
  final Color? colorText;
  final Color? color;
  final VoidCallback? onPressed;

  const TargetShip({
    super.key,
    this.title,
    this.colorText = Colors.black,
    this.color = const Color.fromARGB(255, 241, 236, 255),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: color,
        ),
        child: Text(
          title!,
          style: TextStyle(
              fontSize: 16, color: colorText, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
