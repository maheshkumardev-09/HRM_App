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
      route: '',
    ),
    RequestTypeModel(
      title: 'Work Shift Change Request',
      icon: AppRequestImages.workingShiftChange,
      route: '',
    ),
    RequestTypeModel(
      title: 'Request Travel Ticket',
      icon: AppRequestImages.travelTicket,
      route: '',
    ),
    RequestTypeModel(
      title: 'Purchase Request',
      icon: AppRequestImages.purchase,
      route: '',
    ),
    RequestTypeModel(
      title: 'Loan Request',
      icon: AppRequestImages.loan,
      route: '',
    ),
    RequestTypeModel(
      title: 'Benefit Disbursement Request',
      icon: AppRequestImages.benefitDisbursement,
      route: '',
    ),
    RequestTypeModel(
      title: 'Request Out of Office',
      icon: AppRequestImages.outOfOffice,
      route: '',
    ),
    RequestTypeModel(
      title: 'Request Training Course',
      icon: AppRequestImages.trainingCourse,
      route: '',
    ),
    RequestTypeModel(
      title: 'Resignation Request',
      icon: AppRequestImages.resignation,
      route: '',
    ),
    RequestTypeModel(
      title: 'Request Grievance',
      icon: AppRequestImages.grievance,
      route: '',
    ),
    RequestTypeModel(
      title: 'Job Requisition',
      icon: AppRequestImages.job,
      route: '',
    ),
    RequestTypeModel(
      title: 'Fixation Salary Request',
      icon: AppRequestImages.fixationSalary,
      route: '',
    ),
    RequestTypeModel(
      title: 'Request to change a rest day',
      icon: AppRequestImages.changeRestDay,
      route: '',
    ),
    RequestTypeModel(
      title: 'Request for family visit authentication',
      icon: AppRequestImages.familyVisitAuthentication,
      route: '',
    ),
    RequestTypeModel(
      title: 'Apply for another application',
      icon: AppRequestImages.applyForAnother,
      route: '',
    ),
    RequestTypeModel(
      title: 'Return to work from vacation',
      icon: AppRequestImages.returnToWorkFromVacation,
      route: '',
    ),
    RequestTypeModel(
      title: 'Business visit request',
      icon: AppRequestImages.businessVisit,
      route: '',
    ),
    RequestTypeModel(
      title: 'Passport update request',
      icon: AppRequestImages.passportUpdate,
      route: '',
    ),
    RequestTypeModel(
      title: 'Exit and return visa application',
      icon: AppRequestImages.exitAndReturnVisa,
      route: '',
    ),
    RequestTypeModel(title: 'PR Request', icon: AppRequestImages.pr, route: ''),
  ];
}
