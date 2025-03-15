class ClassModel {
  final int id;
  final String className;
  final String groupName;

  factory ClassModel.toJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      className: json['class_name'],
      groupName: json['group_name'],
    );
  }

  ClassModel(
      {required this.id, required this.className, required this.groupName});
}
