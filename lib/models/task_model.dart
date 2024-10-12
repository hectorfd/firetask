class TaskModel{
  String title;
  String description;
  String date;
  String category;
  bool status;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.status,
});

  factory TaskModel.fromJson(Map<String, dynamic> json)=> TaskModel(
      title: json["title"],
      description: json["description"],
      date: json["date"],
      category: json["category"],
      status: json["status"],
  );



}