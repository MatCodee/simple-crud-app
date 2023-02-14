import 'package:crud_homework/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UpdateTask extends StatelessWidget {
  final storage = const FlutterSecureStorage();
  String? deviceId;
  final String? documentId;

  UpdateTask({super.key,this.documentId});

  final controllTitle = TextEditingController();
  final controllSubtitle = TextEditingController();
  final controllDate = TextEditingController();
  



  void getDeviceId() async {
    deviceId = await storage.read(key: 'device_id');
    if (deviceId == null) {
      deviceId = generateDeviceId();
      await storage.write(key: 'device_id', value: deviceId);
    }
  }
  String generateDeviceId() {
    return 'device_' + DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Update",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.black54,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: controllTitle,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'title',
              ),
            ),
            const SizedBox(height: 30,),
            TextField(
              controller: controllSubtitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
            ),

            const SizedBox(height: 24,),
                  Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 245, 255),
                        borderRadius: BorderRadius.all(Radius.circular(15)), 
                      ),
                      child: InkWell(
                        onTap: () {
                          final title = controllTitle.text;
                          final subtitle = controllSubtitle.text;
                          creatTask(title: title, subtitle: subtitle, id: documentId!);   
                          Navigator.pop(context);                     
                        },
                        child:  Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add,color: Colors.blue,),
                              Text("Create Task", style: TextStyle( fontSize: 20,color: Colors.blue,fontWeight: FontWeight.w500,),),
                            ],
                          )
                        ),
                      ),
                    ),
          ],
        )
      ),
    );
  }

  Future creatTask({ required String title, required String subtitle,required String id }) async {
    deviceId = await storage.read(key: 'device_id');
    if (deviceId == null) deviceId = generateDeviceId();
    
    final docUser = FirebaseFirestore.instance.collection('tasks').doc(id);    
      final task = Task(
        id: docUser.id,
        title: title,
        subtitle: subtitle,
        deviceId: deviceId!,
      );
      final json = task.toJson();
      await docUser.update(json);
    }
}