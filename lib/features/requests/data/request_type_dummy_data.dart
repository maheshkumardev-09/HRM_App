import 'package:hrm_app/features/requests/data/app_requets_images.dart';
import 'package:hrm_app/features/requests/models/request_type_model.dart';
import 'package:hrm_app/routes/app_routes.dart';

class RequestTypeDummyData {
  static List<RequestTypeModel> types = [
    RequestTypeModel(
      title: 'Request for letter authentication',
      icon: AppRequestImages.letterAuthentication,
      route: AppRoutes.letterauthview,
    ),
    RequestTypeModel(
      title: 'Request for a salary increase',
      icon: AppRequestImages.salaryIncrease,
      route: AppRoutes.salaryincreaseview,
    ),
    RequestTypeModel(
      title: 'Request Salary Letter',
      icon: AppRequestImages.salaryLetter,
      route: AppRoutes.salaryletterview,
    ),
    RequestTypeModel(
      title: 'Work Shift Change Request',
      icon: AppRequestImages.workingShiftChange,
      route: AppRoutes.workshiftchangeview,
    ),
    RequestTypeModel(
      title: 'Request Travel Ticket',
      icon: AppRequestImages.travelTicket,
      route: AppRoutes.traveticketview,
    ),
    RequestTypeModel(
      title: 'Purchase Request',
      icon: AppRequestImages.purchase,
      route: AppRoutes.purchaserequestView,
    ),
    RequestTypeModel(
      title: 'Loan Request',
      icon: AppRequestImages.loan,
      route: AppRoutes.loanview,
    ),
    RequestTypeModel(
      title: 'Benefit Disbursement Request',
      icon: AppRequestImages.benefitDisbursement,
      route: AppRoutes.benefitdisbursementview,
    ),
    RequestTypeModel(
      title: 'Request Out of Office',
      icon: AppRequestImages.outOfOffice,
      route: AppRoutes.outoffofficeview,
    ),
    RequestTypeModel(
      title: 'Request Training Course',
      icon: AppRequestImages.trainingCourse,
      route: AppRoutes.trainingcourseview,
    ),
    RequestTypeModel(
      title: 'Resignation Request',
      icon: AppRequestImages.resignation,
      route: AppRoutes.resignationview,
    ),
    RequestTypeModel(
      title: 'Request Grievance',
      icon: AppRequestImages.grievance,
      route: AppRoutes.griveanceview,
    ),
    RequestTypeModel(
      title: 'Job Requisition',
      icon: AppRequestImages.job,
      route: AppRoutes.jobrequisitionview,
    ),
    RequestTypeModel(
      title: 'Fixation Salary Request',
      icon: AppRequestImages.fixationSalary,
      route: AppRoutes.fixationsalaryview,
    ),
    RequestTypeModel(
      title: 'Request to change a rest day',
      icon: AppRequestImages.changeRestDay,
      route: AppRoutes.requesttochangearestdayview,
    ),
    RequestTypeModel(
      title: 'Request for family visit authentication',
      icon: AppRequestImages.familyVisitAuthentication,
      route: AppRoutes.requestTofamilyvistAuthview,
    ),
    RequestTypeModel(
      title: 'Apply for another application',
      icon: AppRequestImages.applyForAnother,
      route: AppRoutes.applyforanotherview,
    ),
    RequestTypeModel(
      title: 'Return to work from vacation',
      icon: AppRequestImages.returnToWorkFromVacation,
      route: AppRoutes.returntoworkfromhomeview,
    ),
    RequestTypeModel(
      title: 'Business visit request',
      icon: AppRequestImages.businessVisit,
      route: AppRoutes.businessvisitview,
    ),
    RequestTypeModel(
      title: 'Passport update request',
      icon: AppRequestImages.passportUpdate,
      route: AppRoutes.passportupdateview,
    ),
    RequestTypeModel(
      title: 'Exit and return visa application',
      icon: AppRequestImages.exitAndReturnVisa,
      route: AppRoutes.exitandreturnvisaapplicationview,
    ),
    RequestTypeModel(
      title: 'PR Request',
      icon: AppRequestImages.pr,
      route: AppRoutes.prview,
    ),
  ];
}
