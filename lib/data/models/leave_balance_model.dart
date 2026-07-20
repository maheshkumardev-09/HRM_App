class LeaveBalanceModel {
  final String leaveType; // "Sick Day Off", "Paid leaves"
  final double usedDays;
  final double totalDays;

  LeaveBalanceModel({
    required this.leaveType,
    required this.usedDays,
    required this.totalDays,
  });
}
