
class Task {
  final String id;
  final String title;
  final String deviceId;

  final String date;
  final String startTime;
  final String endTime;
  final String category;
  final bool done;

  Task({
    this.id = '',
    required this.title,
    required this.deviceId,

    required this.date,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.done
  });

  Map<String,dynamic> toJson() => {
    'id': id,
    'title': title,
    'deviceId': deviceId,
    'date': date,
    'startTime': startTime,
    'endTime': endTime,
    'category': category,
    'done': done
  };

  static Task fromJson(Map<String,dynamic> json, String documentID) => 
    Task(
      id: documentID,
      title: json['title'], 
      deviceId: json['deviceId'],
      
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      category: json['category'],
      done: json['done'],
    );

}