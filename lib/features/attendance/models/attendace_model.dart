class AttendanceModel {
  final String status; // "In Progress", "Checked Out"
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final DateTime? breakInTime;
  final DateTime? breakOutTime;

  AttendanceModel({
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    this.breakInTime,
    this.breakOutTime,
  });
}
