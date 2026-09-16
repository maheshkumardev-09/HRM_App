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
  // ==================== COMMON (used by ALL forms) ====================
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

  // ==================== LETTER AUTHENTICATION REQUEST ====================
  // Uses only common fields: subjectController, descriptionController, selectedFile

  // ==================== SALARY INCREASE REQUEST ====================
  Rx<DateTime?> proposedIncrementDate = Rx<DateTime?>(null);
  // ==================== SALARY LETTER REQUEST ====================
  RxBool includeArabicVersion = false.obs;
  RxBool includeEnglishVersion = false.obs;
  final directedToArabicController = TextEditingController();
  final directedToEnglishController = TextEditingController();

  // ==================== WORK SHIFT CHANGE REQUEST ====================
  Rx<DateTime?> shiftDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> shiftStartTime = Rx<TimeOfDay?>(null);
  RxString selectedShift = ''.obs;
  List<String> shiftOptions = ['Morning Shift', 'Evening Shift', 'Night Shift'];

  // ==================== TRAVEL TICKET REQUEST ====================
  final departureController = TextEditingController();
  final arrivalController = TextEditingController();
  Rx<DateTime?> travelDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> departureTime = Rx<TimeOfDay?>(null);
  RxBool isRoundTrip = false.obs;
  Rx<DateTime?> returnDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> returnTime = Rx<TimeOfDay?>(null);
  RxBool isBusinessTrip = false.obs;

  // ==================== PURCHASE REQUEST ====================
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

  // ==================== LOAN REQUEST ====================
  Rx<DateTime?> loanStartDate = Rx<DateTime?>(null);
  final loanAmountController = TextEditingController();
  final loanMonthsController = TextEditingController();

  // ==================== BENEFIT DISBURSEMENT REQUEST ====================
  RxString selectedBenefitType = ''.obs;
  List<String> benefitTypeOptions = [
    'Medical',
    'Housing',
    'Transport',
    'Education',
  ];

  // ==================== OUT OF OFFICE REQUEST ====================
  Rx<DateTime?> oooDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> fromTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> toTime = Rx<TimeOfDay?>(null);

  // ==================== TRAINING COURSE REQUEST ====================
  final courseTitleController = TextEditingController();
  final justificationController = TextEditingController();
  RxList<Country> trainingCountries = <Country>[].obs;
  Rx<Country?> selectedTrainingCountry = Rx<Country?>(null);
  Rx<DateTime?> trainingFromDate = Rx<DateTime?>(null);
  Rx<DateTime?> trainingToDate = Rx<DateTime?>(null);

  // ==================== RESIGNATION REQUEST ====================
  Rx<DateTime?> lastWorkingDay = Rx<DateTime?>(null);
  RxString selectedTerminationType = ''.obs;
  List<String> terminationTypeOptions = [
    'Resignation',
    'Retirement',
    'Contract End',
    'Termination',
  ];
  final reasonController = TextEditingController();
  // ==================== GRIEVANCE REQUEST ====================
  RxString selectedDepartment = ''.obs;
  List<String> departmentOptions = [
    'HR',
    'Finance',
    'IT',
    'Operations',
    'Sales',
  ];
  final grievanceSubjectController = TextEditingController();
  // ==================== JOB REQUISITION REQUEST ====================
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
  // ==================== REQUEST TO CHANGE A REST DAY ====================
  Rx<DateTime?> restDayToReplace = Rx<DateTime?>(null);
  Rx<DateTime?> workdayToAssign = Rx<DateTime?>(null);
  final workShiftController = TextEditingController();
  // ==================== FAMILY VISIT AUTHENTICATION REQUEST ====================
  Rx<DateTime?> applicationSubmissionDate = Rx<DateTime?>(null);
  // ==================== RETURN TO WORK FROM VACATION REQUEST ====================
  Rx<DateTime?> returnToWorkDate = Rx<DateTime?>(null);
  // ==================== BUSINESS VISIT REQUEST ====================
  Rx<DateTime?> orderDate = Rx<DateTime?>(null);
  // ==================== PASSPORT UPDATE REQUEST ====================
  Rx<File?> newPassportFile = Rx<File?>(null);
  Rx<DateTime?> passportOrderDate = Rx<DateTime?>(null);
  final requestNoteController = TextEditingController();
  // ==================== EXIT AND RETURN VISA APPLICATION ====================
  Rx<DateTime?> visaOrderDate = Rx<DateTime?>(
    null,
  ); // naya naam, passportOrderDate/orderDate se clash na ho
  RxString selectedVisaType = ''.obs;
  List<String> visaTypeOptions = [
    'Single Exit',
    'Multiple Exit',
    'Return Visa',
  ];
  // ==================== PR REQUEST ====================
  RxString selectedPRProduct = ''.obs;
  List<String> prProductOptions = [
    'Laptop',
    'Office Chair',
    'Printer',
    'Stationery',
    'Software License',
  ];
  final prQuantityController = TextEditingController();
  // ==================== LIFECYCLE ====================
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
    super.onClose();
  }

  // ==================== REQUEST TYPES (GRID + SEARCH) ====================
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

  // ==================== LOAD / SAVE ====================
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

  // ==================== FILE PICKER (shared by all forms) ====================
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "png", "jpg", "jpeg"],
    );
    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  // ==================== SUBMIT (shared by all forms) ====================
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

  // ==================== FILTER (My Requests list) ====================
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
      onCancel: () {
        Get.back();
      },
      onConfirm: () async {
        await removeRequest(request);
        Get.back();
      },
    );
  }

  // ==================== SALARY INCREASE — date picker ====================
  Future<void> pickProposedIncrementDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      proposedIncrementDate.value = picked;
    }
  }

  // ==================== WORK SHIFT CHANGE — pickers ====================
  Future<void> pickShiftDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      shiftDate.value = picked;
    }
  }

  Future<void> pickShiftStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      shiftStartTime.value = picked;
    }
  }

  // ==================== TRAVEL TICKET — pickers ====================
  // NOTE: previously these used `() => value = picked` by mistake, which
  // defines a function but never calls it, so the value never updated.
  // Fixed to direct assignment below.
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

  // ==================== PURCHASE REQUEST — picker ====================
  Future<void> pickPurchaseDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) purchaseDate.value = picked;
  }

  // ==================== LOAN REQUEST — picker ====================
  Future<void> pickLoanStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) loanStartDate.value = picked;
  }

  // ==================== OUT OF OFFICE — pickers ====================
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

  // ==================== TRAINING COURSE — pickers + country ====================
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

  Future<void> loadTrainingCountries() async {
    trainingCountries.value = await getAllCountries();
  }

  void selectTrainingCountry(Country country) {
    selectedTrainingCountry.value = country;
  }

  // ==================== RESIGNATION — picker ====================
  Future<void> pickLastWorkingDay(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) lastWorkingDay.value = picked;
  }
  // ========== Request to change a rest day ===========

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

  // ==================== FAMILY VISIT AUTHENTICATION REQUEST ====================
  Future<void> pickApplicationSubmissionDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) applicationSubmissionDate.value = picked;
  }

  // ==================== RETURN TO WORK FROM VACATION REQUEST ====================
  Future<void> pickReturnToWorkDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) returnToWorkDate.value = picked;
  }

  // ==================== BUSINESS VISIT REQUEST ====================
  Future<void> pickOrderDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) orderDate.value = picked;
  }
  // ==================== PASSPORT UPDATE REQUEST ====================

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
    if (picked != null) orderDate.value = picked;
  }

  // ==================== EXIT AND RETURN VISA APPLICATION ====================
  Future<void> pickVisaOrderDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) visaOrderDate.value = picked;
  }

  // ==================== CLEAR FORM (resets EVERY form's fields) ====================
  void clearForm() {
    // Common
    selectedRequestType.value = '';
    subjectController.clear();
    descriptionController.clear();
    selectedFile.value = null;
    // Salary Increase
    proposedIncrementDate.value = null;
    // Salary Letter
    includeArabicVersion.value = false;
    includeEnglishVersion.value = false;
    directedToArabicController.clear();
    directedToEnglishController.clear();
    // Work Shift Change
    shiftDate.value = null;
    shiftStartTime.value = null;
    selectedShift.value = '';
    // Travel Ticket
    departureController.clear();
    arrivalController.clear();
    travelDate.value = null;
    departureTime.value = null;
    isRoundTrip.value = false;
    returnDate.value = null;
    returnTime.value = null;
    isBusinessTrip.value = false;

    // Purchase Request
    selectedProduct.value = '';
    quantityController.clear();
    purchaseDate.value = null;
    purchaseAmountController.clear();
    // Loan Request
    loanStartDate.value = null;
    loanAmountController.clear();
    loanMonthsController.clear();
    // Benefit Disbursement
    selectedBenefitType.value = '';
    // Out of Office
    oooDate.value = null;
    fromTime.value = null;
    toTime.value = null;
    // Training Course
    courseTitleController.clear();
    justificationController.clear();
    selectedTrainingCountry.value = null;
    trainingFromDate.value = null;
    trainingToDate.value = null;
    // Resignation
    lastWorkingDay.value = null;
    selectedTerminationType.value = '';
    reasonController.clear();
    // Griveance
    selectedDepartment.value = '';
    grievanceSubjectController.clear();
    // job requisition
    selectedJobTitle.value = '';
    selectedEducationLevel.value = '';
    selectedMinExperience.value = '';
    //request to change a rest day
    restDayToReplace.value = null;
    workdayToAssign.value = null;
    workShiftController.clear();
    //  FAMILY VISIT AUTHENTICATION REQUEST
    applicationSubmissionDate.value = null;
    // RETURN TO WORK FROM VACATION REQUES
    returnToWorkDate.value = null;
    // BUSINESS VISIT REQUES
    orderDate.value = null;
    // PASSPORT UPDATE REQUEST
    newPassportFile.value = null;
    requestNoteController.clear();
    purchaseDate.value = null;
    // EXIT AND RETURN VISA APPLICATION
    visaOrderDate.value = null;
    selectedVisaType.value = '';
    // PR REQUEST
    selectedPRProduct.value = '';
    prQuantityController.clear();
  }
}
