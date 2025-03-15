class AttendanceModel {
  final int id;
  final int classId;
  final int qrCode;
  final String scannedAt;
  AttendanceModel(
      {required this.id,
      required this.classId,
      required this.qrCode,
      required this.scannedAt});

  factory AttendanceModel.toJson(Map json) {
    return AttendanceModel(
      id: json['id'],
      classId: json['class_id'],
      qrCode: json['qr_code'],
      scannedAt: json['scanned_at'],
    );
  }
}
