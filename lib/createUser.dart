import 'package:crud_homework/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_homework/models/User.dart';


class UserCreate extends StatefulWidget {
  const UserCreate({super.key});

  @override
  State<UserCreate> createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  final controllTitle = TextEditingController();
  final controllSubtitle = TextEditingController();
  final controllDate = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(controller: controllTitle),
            TextField(controller: controllSubtitle),

            const SizedBox(height: 24,),
            ElevatedButton(
              onPressed: () {
                final title = controllTitle.text;
                final subtitle = controllSubtitle.text;
                creatTask(title: title, subtitle: subtitle);
                //Navigator.pop(context);
              }, 
              child: const Text("Create")
            )
          ],
        )
      ),
    );
  }
    Future creatTask({ required String title, required String subtitle }) async {
    final docUser = FirebaseFirestore.instance.collection('tasks').doc();
    
      final user = Task(
        id: docUser.id,
        title: title,
        subtitle: subtitle
      );
      print(user);
      final json = user.toJson();
      await docUser.set(json);
    }
}