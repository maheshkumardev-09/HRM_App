import 'package:hrm_app/features/documents/documents_model.dart';

class DocumentsDummyData {
  static const String _testPdf =
      'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';

  static List<DocumentsModel> documents = [
    DocumentsModel(
      id: '1',
      name: 'Customer Ledger Template.pdf',
      createdDate: DateTime(2026, 4, 5),
      downloadUrl: _testPdf,
    ),
    DocumentsModel(
      id: '2',
      name: 'Accounts Group.xlsx',
      createdDate: DateTime(2026, 4, 6),
      downloadUrl: 'https://example.com/documents/accounts_group.xlsx',
    ),
    DocumentsModel(
      id: '3',
      name: 'Contact Partner.xlsx',
      createdDate: DateTime(2026, 4, 6),
      downloadUrl: 'https://example.com/documents/contact_partner.xlsx',
    ),
    DocumentsModel(
      id: '4',
      name: 'Support Document.pdf',
      createdDate: DateTime(2026, 4, 6),
      downloadUrl: _testPdf,
    ),
    DocumentsModel(
      id: '5',
      name: 'Customer Ledger Template.pdf',
      createdDate: DateTime(2026, 4, 5),
      downloadUrl: _testPdf,
    ),
    DocumentsModel(
      id: '6',
      name: 'Accounts Group.xlsx',
      createdDate: DateTime(2026, 4, 6),
      downloadUrl: 'https://example.com/documents/accounts_group_2.xlsx',
    ),
  ];
}
