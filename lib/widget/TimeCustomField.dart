import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class TimeCustomField extends StatefulWidget {
  final String? targetName;
  final TextEditingController? timeController;


  const TimeCustomField({super.key,required this.targetName,this.timeController});

  @override
  State<TimeCustomField> createState() => _TimeCustomFieldState();
}

class _TimeCustomFieldState extends State<TimeCustomField> {
  late final TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _timeController = widget.timeController ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.4,
      child: DateTimeFormField(
        decoration:  InputDecoration(
          hintStyle: const TextStyle(color: Colors.black45),
          errorStyle: const TextStyle(color: Colors.redAccent),
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.event_note),
          labelText: widget.targetName,
        ),
        mode: DateTimeFieldPickerMode.time,
        autovalidateMode: AutovalidateMode.always,
        validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
        onDateSelected: (DateTime value) {
          _timeController.text = convertCompleteDateToTime(value.toString());
        },
      ),
    );
  }

  String convertCompleteDateToTime(String currentDate) {
    RegExp regex = RegExp(r'\d{2}:\d{2}:\d{2}.\d{3}');
    String? hora = regex.stringMatch(currentDate);
    return hora!;
  }
}
