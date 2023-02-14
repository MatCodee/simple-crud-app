import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_homework/createUser.dart';
import 'package:crud_homework/models/Task.dart';
import 'package:crud_homework/widget/card.dart';
import 'package:crud_homework/widget/groupText.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color.fromARGB(255, 255, 255, 255),
        ),
        iconTheme: const IconThemeData(
          color: Colors.purple,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      children: const [
                        Text(
                          "New Task",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Wdnesday, 11 May",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
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
                        child: Center(
                            child: Row(
                          children: const [
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
                const Grouptext(),
                const SizedBox(
                  height: 10,
                ),
                //const CardElement(title: "Client Review & Feedback", subtitle: "Crypto wallet Redesing"),

                Container(
                  child: StreamBuilder(
                    stream: readTask(),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stream<List<Task>> readTask() {
    var data = FirebaseFirestore.instance.collection("tasks").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Task.fromJson(doc.data(), doc.id))
            .toList());
    return data;
  }

  Widget buildUser(Task task) =>
      CardElement(title: task.title, subtitle: task.subtitle, id: task.id);
}
