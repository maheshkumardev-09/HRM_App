class LeaveBalanceModel {
  final String leaveType;
  final int totalDay;
  final int useDday;
  final int remaining;

  LeaveBalanceModel({
    required this.leaveType,
    required this.totalDay,
    required this.useDday,
    required this.remaining,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceModel(
      leaveType: json['leaveType'],
      totalDay: json['total'] ?? 0,
      useDday: json['used'] ?? 0,
      remaining: json['remaining'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leaveType": leaveType,
      "total": totalDay,
      "used": useDday,
      "remaining": remaining,
    };
  }
}
