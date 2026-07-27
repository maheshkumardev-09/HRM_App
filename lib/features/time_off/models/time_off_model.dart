class TimeOffModel {
  final String allocation;
  final String status;
  final String leaveType;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int leaveDuration;

  TimeOffModel({
    required this.status,
    required this.leaveType,
    required this.dateFrom,
    required this.dateTo,
    required this.leaveDuration,
    required this.allocation,
  });
}
