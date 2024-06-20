class TodoTaskModel {
  String title;
  int? id;
  String description;
  bool isCompleted;

  TodoTaskModel({
    this.id,
    this.isCompleted = false,
    required this.title,
    required this.description,
  });

  factory TodoTaskModel.fromMap(Map<String, dynamic> json) => TodoTaskModel(
      title: json['title']??'',
      description: json['description']??'',
      id: json['id']??'0',
      isCompleted: json['isCompleted'] == 1);

  Map<String, dynamic> toMap() {
    return {'id': id, 
    'title': title,
    'description':description, 
    'isCompleted': isCompleted ? 1 : 0};
  }
}
