import 'package:crud_homework/models/Task.dart';
import 'package:crud_homework/widget/TimeCustomField.dart';
import 'package:crud_homework/widget/targetShip.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserCreate extends StatefulWidget {
  const UserCreate({super.key});

  @override
  State<UserCreate> createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  final storage = const FlutterSecureStorage();
  String? deviceId;



  // Controladores de la fecha inicial yla final
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();


  // Este es el fielField de DatePicker de la fecha

  final dateController = TextEditingController();

  var _currentStartDate;
  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    if(selectedDate != null ) {
      setState(() {
        _currentStartDate = selectedDate;
        dateController.text = selectedDate != null ? convertCompleteTimeToDate(selectedDate.toString()) : "";
      });
    }
  }
  String convertCompleteDateToTime(String currentDate) {
    RegExp regex = RegExp(r'\d{2}:\d{2}:\d{2}.\d{3}');
    String? hora = regex.stringMatch(currentDate);
    return hora!;
  }
  String convertCompleteTimeToDate(String currentDate) {
    RegExp regex =  RegExp(r'^\d{4}-\d{2}-\d{2}');
    String? fecha = regex.stringMatch(currentDate);
    return fecha!;
  }
  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
      builder: (context,child) {
        return Theme(data: ThemeData.dark(),child: child!);
      }
    );
  }
  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  String _selectedTitle = '';
  void _onTargetShipPressed(String title) {
    setState(() {
      _selectedTitle = title;
      categorySelectController.text = _selectedTitle;
    });
  }

  final controllTitle = TextEditingController();
  final controllSubtitle = TextEditingController();
  final controllDate = TextEditingController();
  final categoryController = TextEditingController();
  final categorySelectController = TextEditingController();

  List<String> ships = ["Programming"];

  @override
  void initState() {
    super.initState();
  }

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
        title: const Text(
          "Create",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
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
          const SizedBox(
            height: 30,
          ),
          TextField(
            onTap: () => callDatePicker(),
              controller: dateController,
              decoration: const  InputDecoration(
                hintStyle:  TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: "fecha para la organizacion",
              ),
            ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TimeCustomField(targetName: "start time",timeController: startTimeController),
              TimeCustomField(targetName: "end time", timeController: endTimeController),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Column(
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Agregar alguna Categoria',
                ),
              ),
              IconButton(
                  onPressed: () {
                    ships.add(categoryController.text);
                    setState(() {
                      categoryController.text = "";
                    });
                  },
                  icon: const Icon(Icons.add)),
              const SizedBox(
                height: 24,
              ),
              Container(
                child: Wrap(
                  spacing: 10.0,
                  children: [
                    TargetShip(
                      title: "Ui Desing",
                      colorText: const Color.fromARGB(255, 125, 85, 234),
                      color: Color.fromARGB(255, 241, 236, 255),
                      onPressed: () => _onTargetShipPressed('Ui Desing'),
                    ),
                    TargetShip(
                      title: "Web Design",
                      colorText: const Color.fromARGB(255, 125, 15, 169),
                      color: Color.fromARGB(255, 240, 235, 255),
                      onPressed: () => _onTargetShipPressed('Web Design'),
                    ),
                    TargetShip(
                      title: "UI UX",
                      colorText: Colors.green,
                      color: Color.fromARGB(255, 237, 255, 242),
                      onPressed: () => _onTargetShipPressed('UI UX'),
                    ),
                    TargetShip(
                      title: "Website",
                      colorText: const Color.fromARGB(255, 63, 60, 244),
                      color: Color.fromARGB(255, 202, 215, 255),
                      onPressed: () => _onTargetShipPressed('Website'),
                    ),
                    ...ships
                        .map((e) => TargetShip(
                              title: e,
                              onPressed: () => _onTargetShipPressed(e),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: categorySelectController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Category',
              prefixIcon: Icon(Icons.add),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
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
                creatTask(title: title, subtitle: subtitle);
                Navigator.pop(context);
              },
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  Text(
                    "Create Task",
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
      )),
    );
  }

  Future creatTask({required String title, required String subtitle}) async {
    deviceId = await storage.read(key: 'device_id');
    if (deviceId == null) deviceId = generateDeviceId();

    final docUser = FirebaseFirestore.instance.collection('tasks').doc();
    
    print("Esta es la fecha completa");
    print("date: " + dateController.text);


    print("hora inicial");
    print(startTimeController.text);
    print("hora final");
    print(endTimeController.text);

    print("categoria");
    print(categorySelectController.text);
    
    final task = Task(
      id: docUser.id,
      title: title,
      deviceId: deviceId!,
      date: dateController.text,
      startTime: startTimeController.text,
      endTime: endTimeController.text,
      category: categorySelectController.text,
      done: false,
    );
    
    final json = task.toJson();
    await docUser.set(json);
  }
}
