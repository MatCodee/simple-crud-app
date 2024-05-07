import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Grouptext extends StatelessWidget {
  final String title;
  final int value;
  bool activate;
  Grouptext({required this.title,required this.value,required this.activate,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: activate ? Colors.blue : Colors.black, fontSize: 14),
          ),
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: activate ? Colors.blue : Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Center(
              child: Text(
                '${(value)}',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
