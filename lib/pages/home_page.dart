import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_homework/createUser.dart';
import 'package:crud_homework/models/Task.dart';
import 'package:crud_homework/widget/card.dart';
import 'package:crud_homework/widget/groupText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = const FlutterSecureStorage();
  String? deviceId;
  bool isLoading = true;
  DateTime now = DateTime.now();


  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  Future<void> initStateAsync() async {
    await getDeviceId();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getDeviceId() async {
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
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          DateFormat('EEEE, d MMMM').format(now),
                          style: const TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 245, 255),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserCreate()));
                        },
                        child: const Center(
                            child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            Text(
                              "New Task",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Grouptext(title: "All",value: 14,activate: true),
                    Grouptext(title: "Open",value: 14,activate: false),
                    Grouptext(title: "Closed",value: 14,activate: false),
                    Grouptext(title: "Archived",value: 14,activate: false),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //const CardElement(title: "Client Review & Feedback", subtitle: "Crypto wallet Redesing"),
                getTaskElements(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTaskElements() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        child: StreamBuilder(
          stream: readTask(deviceId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Algun error ${snapshot.error}');
            } else if (snapshot.hasData) {
              final task = snapshot.data!;
              return Wrap(
                direction: Axis.horizontal,
                spacing: 15.0,
                runSpacing: 15.0,
                children: task.map(buildUser).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    }
  }

  Stream<List<Task>> readTask(String? deviceId) {
    print(deviceId);
    var data = FirebaseFirestore.instance
        .collection("tasks")
        .where("deviceId", isEqualTo: deviceId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromJson(doc.data(), doc.id))
            .toList());
    return data;
  }

  Widget buildUser(Task task) => CardElement(task: task);
}
