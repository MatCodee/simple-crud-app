import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_homework/models/Task.dart';
import 'package:crud_homework/updateTask.dart';
import 'package:crud_homework/widget/targetShip.dart';
import 'package:flutter/material.dart';

class CardElement extends StatelessWidget {
  final Task task;
  //final String date;

  const CardElement({super.key,required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
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
                      task.date,
                      style: const TextStyle(
                      fontSize: 15, color: Colors.black54),
                    )),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        task.title,
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
                  TargetShip(title:task.category,colorText: Colors.blue,color:Colors.blue.shade50)
                ],
              ),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                    color: Colors.white),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      formatDateTime(task.startTime,task.endTime),
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
                          builder: (context) => UpdateTask(documentId: task.id)));
                },
                icon: const Icon(Icons.edit),
                color: Colors.blue,
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("tasks")
                      .doc(task.id)
                      .delete();
                },
                icon: const Icon(Icons.delete),
                color: Colors.blue,
                iconSize: 30,
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
