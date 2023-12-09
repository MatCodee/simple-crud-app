import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_homework/models/Task.dart';
import 'package:crud_homework/updateTask.dart';
import 'package:crud_homework/widget/targetShip.dart';
import 'package:flutter/material.dart';

class CardElement extends StatefulWidget {
  final Task task;
  //final String date;

  const CardElement({super.key,required this.task});

  @override
  State<CardElement> createState() => _CardElementState();
}

class _CardElementState extends State<CardElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 30,right: 30, top: 30,bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 238, 238, 238),
            blurRadius: 10,
            offset: Offset(0, 10), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      widget.task.date,
                      style: const TextStyle(
                      fontSize: 15, color: Colors.black54),
                    )),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        widget.task.title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                  const SizedBox(
                    height: 5,
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  TargetShip(title:widget.task.category,colorText: Colors.blue,color:Colors.blue.shade50)
                ],
              ),
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
        
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.task.done = !widget.task.done;  
                        print(widget.task.done);                      
                      });
                    },
                    icon:  widget.task.done  ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
                    iconSize: 60,
                    color:  Colors.blue ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    "Hora: ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Text(
                      formatDateTime(widget.task.startTime,widget.task.endTime),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateTask(documentId: widget.task.id)));
                },
                icon: const Icon(Icons.edit),
                color: Colors.blue,
                iconSize: 40,
              ),
              IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("tasks")
                      .doc(widget.task.id)
                      .delete();
                },
                icon: const Icon(Icons.delete),
                color: Colors.blue,
                iconSize: 40,
              )
            ],
          )
        ],
      ),
    );
  }

  String formatDateTime(String startTime,String endTime) {
    RegExp regex = RegExp(r'^\d{2}:\d{2}');
    String? start = regex.stringMatch(startTime);
    String? end = regex.stringMatch(endTime);
    return '${start} - ${end}';
  }
}
