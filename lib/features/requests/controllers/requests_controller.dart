import 'dart:convert';
import 'dart:io';
import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_app/features/auth/controllers/auth_controller.dart';
import 'package:hrm_app/features/requests/data/request_dummy_data.dart';
import 'package:hrm_app/features/requests/data/request_type_dummy_data.dart';
import 'package:hrm_app/features/requests/models/request_model.dart';
import 'package:hrm_app/features/requests/models/request_type_model.dart';
import 'package:hrm_app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestsController extends GetxController {
  // ════════════════════════════════════════════════════════════════
  // COMMON — used by ALL 22 forms
  // ════════════════════════════════════════════════════════════════
  final List<RequestTypeModel> requestTypes = RequestTypeDummyData.types;
  final RxString searchQuery = ''.obs;
  final searchController = TextEditingController();

  final RxString selectedRequestType = ''.obs;
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  Rx<File?> selectedFile = Rx<File?>(null);
  RxBool isLoading = false.obs;

  RxList<RequestModel> requestList = <RequestModel>[].obs;

  // Filters for "My Requests" list
  Rx<DateTime?> filterDateFrom = Rx<DateTime?>(null);
  Rx<DateTime?> filterDateTo = Rx<DateTime?>(null);

  // ════════════════════════════════════════════════════════════════
  // LIFECYCLE
  // ════════════════════════════════════════════════════════════════
  @override
  void onInit() {
    super.onInit();
    loadData();
    loadTrainingCountries();
  }

  @override
  void onClose() {
    searchController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    directedToArabicController.dispose();
    directedToEnglishController.dispose();
    departureController.dispose();
    arrivalController.dispose();
    quantityController.dispose();
    purchaseAmountController.dispose();
    loanAmountController.dispose();
    loanMonthsController.dispose();
    courseTitleController.dispose();
    justificationController.dispose();
    reasonController.dispose();
    grievanceSubjectController.dispose();
    workShiftController.dispose();
    requestNoteController.dispose();
    prQuantityController.dispose();
    super.onClose();
  }

  // ════════════════════════════════════════════════════════════════
  // REQUEST TYPES — grid + search + selection
  // ════════════════════════════════════════════════════════════════
  List<RequestTypeModel> get filteredRequestTypes {
    if (searchQuery.value.trim().isEmpty) return requestTypes;
    final query = searchQuery.value.trim().toLowerCase();
    return requestTypes
        .where((type) => type.title.toLowerCase().contains(query))
        .toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void selectRequestType(String title) {
    selectedRequestType.value = title;
  }

  // ════════════════════════════════════════════════════════════════
  // LOAD / SAVE — SharedPreferences persistence
  // ════════════════════════════════════════════════════════════════
  Future<void> loadData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('requestsList');
    if (data == null) {
      requestList.value = RequestDummyData.requests
          .map((r) => RequestModel.fromJson(r))
          .toList();
    } else {
      List decoded = jsonDecode(data);
      requestList.value = decoded.map((e) => RequestModel.fromJson(e)).toList();
    }
    isLoading.value = false;
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = requestList.map((e) => e.toJson()).toList();
    await prefs.setString('requestsList', jsonEncode(data));
  }

  // ════════════════════════════════════════════════════════════════
  // FILE PICKER — shared "attachment" field used by most forms
  // ════════════════════════════════════════════════════════════════
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "png", "jpg", "jpeg"],
    );
    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  // ════════════════════════════════════════════════════════════════
  // SUBMIT — shared by all forms
  // ════════════════════════════════════════════════════════════════
  Future<void> submitRequest({
    Map<String, String> extraFields = const {},
  }) async {
    if (selectedRequestType.value.isEmpty ||
        subjectController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    final auth = Get.find<AuthController>();
    final now = DateTime.now();
    final newRequest = RequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      requestType: selectedRequestType.value,
      subject: subjectController.text.trim(),
      description: descriptionController.text.trim(),
      status: 'Pending',
      attachmentPath: selectedFile.value?.path,
      employeeId: auth.currentUser.value?.id ?? '',
      employeeName: auth.currentUser.value?.name ?? '',
      startDate: now,
      endDate: now,
      extraFields: extraFields,
    );
    requestList.add(newRequest);
    await saveData();
    clearForm();
    Get.toNamed(AppRoutes.requestsview);
    Get.snackbar('Success', 'Request submitted successfully');
  }

  // ════════════════════════════════════════════════════════════════
  // FILTER — "My Requests" list (date range)
  // ════════════════════════════════════════════════════════════════
  Future<void> pickFilterDateFrom(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) filterDateFrom.value = picked;
  }

  Future<void> pickFilterDateTo(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      if (filterDateFrom.value != null &&
          picked.isBefore(filterDateFrom.value!)) {
        Get.snackbar("Error", "To date cannot be before From date");
        return;
      }
      filterDateTo.value = picked;
    }
  }

  void clearDateFilter() {
    filterDateFrom.value = null;
    filterDateTo.value = null;
  }

  List<RequestModel> get filteredRequests {
    var list = requestList.toList();
    if (filterDateFrom.value != null) {
      list = list
          .where((e) => !e.startDate.isBefore(filterDateFrom.value!))
          .toList();
    }
    if (filterDateTo.value != null) {
      list = list
          .where((e) => !e.startDate.isAfter(filterDateTo.value!))
          .toList();
    }
    return list;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }

  RequestModel? getRequestById(String id) {
    return requestList.firstWhereOrNull((r) => r.id == id);
  }

  Future<void> removeRequest(RequestModel request) async {
    requestList.removeWhere((e) => e.id == request.id);

    await saveData();

    Get.snackbar("Deleted", "Request removed successfully");
  }

  void showDeleteDialog(RequestModel request) {
    Get.defaultDialog(
      title: "Delete Request",
      middleText: "Are you sure you want to delete this request?",
      textCancel: "Cancel",
      textConfirm: "Delete",

      onCancel: () {},

      onConfirm: () async {
        Get.back();
        

        await removeRequest(request);
      },
    );
  }

  // ════════════════════════════════════════════════════════════════
  // 1. LETTER AUTHENTICATION REQUEST
  // Uses only common fields: subjectController, descriptionController, selectedFile
  // ════════════════════════════════════════════════════════════════

  // ════════════════════════════════════════════════════════════════
  // 2. SALARY INCREASE REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> proposedIncrementDate = Rx<DateTime?>(null);

  Future<void> pickProposedIncrementDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (picked != null) proposedIncrementDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 3. SALARY LETTER REQUEST
  // ════════════════════════════════════════════════════════════════
  RxBool includeArabicVersion = false.obs;
  RxBool includeEnglishVersion = false.obs;
  final directedToArabicController = TextEditingController();
  final directedToEnglishController = TextEditingController();

  // ════════════════════════════════════════════════════════════════
  // 4. WORK SHIFT CHANGE REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> shiftDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> shiftStartTime = Rx<TimeOfDay?>(null);
  RxString selectedShift = ''.obs;
  List<String> shiftOptions = ['Morning Shift', 'Evening Shift', 'Night Shift'];

  Future<void> pickShiftDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) shiftDate.value = picked;
  }

  Future<void> pickShiftStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) shiftStartTime.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 5. TRAVEL TICKET REQUEST
  // NOTE: pickers below previously used `() => value = picked` by mistake,
  // which defines a function but never calls it, so the value never
  // updated. Fixed to direct assignment.
  // ════════════════════════════════════════════════════════════════
  final departureController = TextEditingController();
  final arrivalController = TextEditingController();
  Rx<DateTime?> travelDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> departureTime = Rx<TimeOfDay?>(null);
  RxBool isRoundTrip = false.obs;
  Rx<DateTime?> returnDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> returnTime = Rx<TimeOfDay?>(null);
  RxBool isBusinessTrip = false.obs;

  Future<void> pickTravelDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) travelDate.value = picked;
  }

  Future<void> pickDepartureTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) departureTime.value = picked;
  }

  Future<void> pickReturnDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) returnDate.value = picked;
  }

  Future<void> pickReturnTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) returnTime.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 6. PURCHASE REQUEST
  // ════════════════════════════════════════════════════════════════
  RxString selectedProduct = ''.obs;
  List<String> productOptions = [
    'Laptop',
    'Office Chair',
    'Printer',
    'Stationery',
  ];
  final quantityController = TextEditingController();
  Rx<DateTime?> purchaseDate = Rx<DateTime?>(null);
  final purchaseAmountController = TextEditingController();

  Future<void> pickPurchaseDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) purchaseDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 7. LOAN REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> loanStartDate = Rx<DateTime?>(null);
  final loanAmountController = TextEditingController();
  final loanMonthsController = TextEditingController();

  Future<void> pickLoanStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) loanStartDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 8. BENEFIT DISBURSEMENT REQUEST
  // ════════════════════════════════════════════════════════════════
  RxString selectedBenefitType = ''.obs;
  List<String> benefitTypeOptions = [
    'Medical',
    'Housing',
    'Transport',
    'Education',
  ];

  // ════════════════════════════════════════════════════════════════
  // 9. OUT OF OFFICE REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> oooDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> fromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> toTime = Rx<TimeOfDay?>(null);

  Future<void> pickOooDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) oooDate.value = picked;
  }

  Future<void> pickFromTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) fromTime.value = picked;
  }

  Future<void> pickToTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) toTime.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 10. TRAINING COURSE REQUEST
  // ════════════════════════════════════════════════════════════════
  final courseTitleController = TextEditingController();
  final justificationController = TextEditingController();
  RxList<Country> trainingCountries = <Country>[].obs;
  Rx<Country?> selectedTrainingCountry = Rx<Country?>(null);
  Rx<DateTime?> trainingFromDate = Rx<DateTime?>(null);
  Rx<DateTime?> trainingToDate = Rx<DateTime?>(null);

  Future<void> loadTrainingCountries() async {
    trainingCountries.value = await getAllCountries();
  }

  void selectTrainingCountry(Country country) {
    selectedTrainingCountry.value = country;
  }

  Future<void> pickTrainingFromDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) trainingFromDate.value = picked;
  }

  Future<void> pickTrainingToDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) trainingToDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 11. RESIGNATION REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> lastWorkingDay = Rx<DateTime?>(null);
  RxString selectedTerminationType = ''.obs;
  List<String> terminationTypeOptions = [
    'Resignation',
    'Retirement',
    'Contract End',
    'Termination',
  ];
  final reasonController = TextEditingController();

  Future<void> pickLastWorkingDay(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) lastWorkingDay.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 12. GRIEVANCE REQUEST
  // ════════════════════════════════════════════════════════════════
  RxString selectedDepartment = ''.obs;
  List<String> departmentOptions = [
    'HR',
    'Finance',
    'IT',
    'Operations',
    'Sales',
  ];
  final grievanceSubjectController = TextEditingController();

  // ════════════════════════════════════════════════════════════════
  // 13. JOB REQUISITION REQUEST
  // ════════════════════════════════════════════════════════════════
  RxString selectedJobTitle = ''.obs;
  List<String> jobTitleOptions = [
    'Software Engineer',
    'HR Manager',
    'Accountant',
    'Sales Executive',
  ];
  RxString selectedEducationLevel = ''.obs;
  List<String> educationLevelOptions = [
    'High School',
    'Bachelor',
    'Master',
    'PhD',
  ];
  RxString selectedMinExperience = ''.obs;
  List<String> experienceOptions = ['0', '1', '2', '3', '5+'];

  // ════════════════════════════════════════════════════════════════
  // 14. FIXATION SALARY REQUEST
  // Uses only common fields: subjectController, descriptionController
  // ════════════════════════════════════════════════════════════════

  // ════════════════════════════════════════════════════════════════
  // 15. REQUEST TO CHANGE A REST DAY
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> restDayToReplace = Rx<DateTime?>(null);
  Rx<DateTime?> workdayToAssign = Rx<DateTime?>(null);
  final workShiftController = TextEditingController();

  Future<void> pickRestDayToReplace(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) restDayToReplace.value = picked;
  }

  Future<void> pickWorkdayToAssign(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) workdayToAssign.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 16. FAMILY VISIT AUTHENTICATION REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> applicationSubmissionDate = Rx<DateTime?>(null);

  Future<void> pickApplicationSubmissionDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) applicationSubmissionDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 17. APPLY FOR ANOTHER APPLICATION
  // Uses only common fields: subjectController, descriptionController, selectedFile
  // ════════════════════════════════════════════════════════════════

  // ════════════════════════════════════════════════════════════════
  // 18. RETURN TO WORK FROM VACATION REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> returnToWorkDate = Rx<DateTime?>(null);

  Future<void> pickReturnToWorkDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) returnToWorkDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 19. BUSINESS VISIT REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> orderDate = Rx<DateTime?>(null);

  Future<void> pickOrderDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) orderDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 20. PASSPORT UPDATE REQUEST
  // ════════════════════════════════════════════════════════════════
  Rx<File?> newPassportFile = Rx<File?>(null);
  Rx<DateTime?> passportOrderDate = Rx<DateTime?>(null);
  final requestNoteController = TextEditingController();

  Future<void> pickNewPassportFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "png", "jpg", "jpeg"],
    );
    if (result != null) {
      newPassportFile.value = File(result.files.single.path!);
    }
  }

  Future<void> pickPassportOrderDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) passportOrderDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 21. EXIT AND RETURN VISA APPLICATION
  // ════════════════════════════════════════════════════════════════
  Rx<DateTime?> visaOrderDate = Rx<DateTime?>(null);
  RxString selectedVisaType = ''.obs;
  List<String> visaTypeOptions = [
    'Single Exit',
    'Multiple Exit',
    'Return Visa',
  ];

  Future<void> pickVisaOrderDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) visaOrderDate.value = picked;
  }

  // ════════════════════════════════════════════════════════════════
  // 22. PR REQUEST
  // ════════════════════════════════════════════════════════════════
  RxString selectedPRProduct = ''.obs;
  List<String> prProductOptions = [
    'Laptop',
    'Office Chair',
    'Printer',
    'Stationery',
    'Software License',
  ];
  final prQuantityController = TextEditingController();

  // ════════════════════════════════════════════════════════════════
  // CLEAR FORM — resets EVERY form's fields, called after successful submit
  // ════════════════════════════════════════════════════════════════
  void clearForm() {
    // Common
    selectedRequestType.value = '';
    subjectController.clear();
    descriptionController.clear();
    selectedFile.value = null;

    // 2. Salary Increase
    proposedIncrementDate.value = null;

    // 3. Salary Letter
    includeArabicVersion.value = false;
    includeEnglishVersion.value = false;
    directedToArabicController.clear();
    directedToEnglishController.clear();

    // 4. Work Shift Change
    shiftDate.value = null;
    shiftStartTime.value = null;
    selectedShift.value = '';

    // 5. Travel Ticket
    departureController.clear();
    arrivalController.clear();
    travelDate.value = null;
    departureTime.value = null;
    isRoundTrip.value = false;
    returnDate.value = null;
    returnTime.value = null;
    isBusinessTrip.value = false;

    // 6. Purchase Request
    selectedProduct.value = '';
    quantityController.clear();
    purchaseDate.value = null;
    purchaseAmountController.clear();

    // 7. Loan Request
    loanStartDate.value = null;
    loanAmountController.clear();
    loanMonthsController.clear();

    // 8. Benefit Disbursement
    selectedBenefitType.value = '';

    // 9. Out of Office
    oooDate.value = null;
    fromTime.value = null;
    toTime.value = null;

    // 10. Training Course
    courseTitleController.clear();
    justificationController.clear();
    selectedTrainingCountry.value = null;
    trainingFromDate.value = null;
    trainingToDate.value = null;

    // 11. Resignation
    lastWorkingDay.value = null;
    selectedTerminationType.value = '';
    reasonController.clear();

    // 12. Grievance
    selectedDepartment.value = '';
    grievanceSubjectController.clear();

    // 13. Job Requisition
    selectedJobTitle.value = '';
    selectedEducationLevel.value = '';
    selectedMinExperience.value = '';

    // 15. Request to Change a Rest Day
    restDayToReplace.value = null;
    workdayToAssign.value = null;
    workShiftController.clear();

    // 16. Family Visit Authentication
    applicationSubmissionDate.value = null;

    // 18. Return to Work from Vacation
    returnToWorkDate.value = null;

    // 19. Business Visit
    orderDate.value = null;

    // 20. Passport Update
    newPassportFile.value = null;
    requestNoteController.clear();
    passportOrderDate.value = null;

    // 21. Exit and Return Visa Application
    visaOrderDate.value = null;
    selectedVisaType.value = '';
    // 22. PR Request
    selectedPRProduct.value = '';
    prQuantityController.clear();
  }
}
