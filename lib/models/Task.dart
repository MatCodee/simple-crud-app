
class Task {
  final String id;
  final String title;
  final String subtitle;
  final String deviceId;
  //final String date;
  //final bool done;

  Task({
    this.id = '',
    required this.title,
    required this.subtitle,
    required this.deviceId,
    //required this.date,
    //this.done = false,
  });

  Map<String,dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'deviceId': deviceId,
    //'date': date,
    //'done': done
  };

  static Task fromJson(Map<String,dynamic> json, String documentID) => 
    Task(
      id: documentID,
      title: json['title'], 
      subtitle: json['subtitle'], 
      deviceId: json['deviceId'],
      //date: json['date'],
      //done: json['done']
    );


}