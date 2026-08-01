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
  // final List<TeamLeaveModel> teamLeaves = [
  //   TeamLeaveModel(
  //     employeeImage: AppImages.personIcon,
  //     date: DateTime(2026, 4, 29),
  //     startTime: "07:00",
  //     endTime: "16:00",
  //     leaveType: "Unplanned Leave",
  //     employName: "Sandeep Kumar",
  //   ),
  //   TeamLeaveModel(
  //     employeeImage: AppImages.personIcon,
  //     date: DateTime(2026, 4, 29),
  //     startTime: "09:00",
  //     endTime: "16:00",
  //     leaveType: "Sick Leave",
  //     employName: "Umer Khayyam",
  //   ),
  // ];
  static final teamLeave = [
    {
      "employeeName": "Sandeep Kumar",
      "employeeImage": "assets/icon/icon22.png",
      "startTime": "07:00",
      "endTime": "16:00",
      "leaveType": "Unplanned Leave",
      "leaveDate": "2026-04-29",
    },
    {
      "employeeName": "Umer Khayyam",
      "employeeImage": "assets/icon/icon22.png",
      "startTime": "09:00",
      "endTime": "16:00",
      "leaveType": "Sick Leave",
      "leaveDate": "2026-04-29",
    },
    {
      "employeeName": "Ali Ahmed",
      "employeeImage": "assets/icon/icon22.png",
      "startTime": "10:00",
      "endTime": "18:00",
      "leaveType": "Annual Leave",
      "leaveDate": "2026-04-30",
    },
  ];
}
