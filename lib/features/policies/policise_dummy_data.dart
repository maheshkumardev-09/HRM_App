import 'package:hrm_app/features/policies/policies_model.dart';

class PoliciesDummyData {
  static List<PoliciesModel> policies = [
    PoliciesModel(
      id: '1',
      title: 'Attendance Policy',
      companyName: 'Aman Al Bilad Projects Company',
      pdfUrl:
          'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    ),
    PoliciesModel(
      id: '2',
      title: 'Leave Policy',
      companyName: 'Aman Al Bilad Projects Company',
      pdfUrl: 'https://example.com/policies/leave_policy.pdf',
    ),
    PoliciesModel(
      id: '3',
      title: 'Employee Policy',
      companyName: 'Aman Al Bilad Projects Company',
      pdfUrl: 'https://example.com/policies/employee_policy.pdf',
    ),
    PoliciesModel(
      id: '4',
      title: 'Company Policy',
      companyName: 'Aman Al Bilad Projects Company',
      pdfUrl: 'https://example.com/policies/company_policy_1.pdf',
    ),
    PoliciesModel(
      id: '5',
      title: 'Company Policy',
      companyName: 'Aman Al Bilad Projects Company',
      pdfUrl: 'https://example.com/policies/company_policy_2.pdf',
    ),
    PoliciesModel(
      id: '6',
      title: 'Payroll Policy',
      companyName: 'Aman Al Bilad Projects Company',
      pdfUrl: 'https://example.com/policies/payroll_policy_1.pdf',
    ),
    PoliciesModel(
      id: '7',
      title: 'Payroll Policy',
      companyName: 'Aman Al Bilad Projects Company',
      pdfUrl: 'https://example.com/policies/payroll_policy_2.pdf',
    ),
  ];
}
