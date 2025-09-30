class Course {
  int? id;
  String title;
  String description;

  Course({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
  };

  factory Course.fromMap(Map<String, dynamic> map) => Course(
    id: map['id'],
    title: map['title'],
    description: map['description'],
  );
}
