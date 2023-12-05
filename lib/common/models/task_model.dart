class TaskModel {
  final int? id;
  final String title;
  final String description;
  final int isCompleted;
  final String date;
  final String? startTime;
  final String? endTime;
  final int? remind;
  final String? repeat;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'repeat': repeat,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as int,
      date: map['date'] as String,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      remind: map['remind'] != null ? map['remind'] as int : null,
      repeat: map['repeat'] != null ? map['repeat'] as String : null,
    );
  }
}
