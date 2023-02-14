import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Grouptext extends StatelessWidget {
  const Grouptext({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          texttarget("All", 14, true),
          texttarget("Open", 14, false),
          texttarget("Closed", 0, false),
          texttarget("Archived", 0, false),
        ],
      ),
    );
  }

  Widget texttarget(String title, int number, bool active) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: active ? Colors.blue : Colors.black, fontSize: 14),
        ),
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: active ? Colors.blue : Colors.black12,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Text(
            '${(number)}',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        )
      ],
    );
  }
}
