class TimeOffDummyData {
  static final leaveBalance = [
    {"leaveType": "Annual Leave", "total": 20, "used": 5, "remaining": 15},

    {"leaveType": "Sick Leave", "total": 10, "used": 2, "remaining": 8},
  ];

  static final leaves = [
    {
      "allocation": "Annual Leave",
      "status": "Approved",
      "leaveType": "Casual Leave",
      "dateFrom": "2026-07-10",
      "dateTo": "2026-07-12",
      "duration": 3,
    },
    {
      "allocation": "Sick Leave",
      "status": "Pending",
      "leaveType": "Medical Leave",
      "dateFrom": "2026-07-15",
      "dateTo": "2026-07-16",
      "duration": 2,
    },
    {
      "allocation": "Annual Leave",
      "status": "Approved",
      "leaveType": "Casual Leave",
      "dateFrom": "2026-07-12",
      "dateTo": "2026-07-13",
      "duration": 2,
    },
  ];
}
