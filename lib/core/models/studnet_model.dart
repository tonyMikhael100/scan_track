class StudentModel {
  final int id;
  final String firstName;
  final String phone;
  final String parentPhone;
  final int qrCode;
  final int classId;

  StudentModel({
    required this.id,
    required this.firstName,
    required this.phone,
    required this.parentPhone,
    required this.qrCode,
    required this.classId,
  });

  factory StudentModel.toJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      firstName: json['name'],
      phone: json['phone'],
      parentPhone: json['parent_phone'],
      qrCode: json['qr_code'],
      classId: json['class_id'],
    );
  }
}
