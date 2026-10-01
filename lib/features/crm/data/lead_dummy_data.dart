import 'package:hrm_app/features/crm/models/lead_model.dart';

class LeadDummyData {
  static List<LeadModel> leads = [
    LeadModel(
      id: '1',
      leadName: 'Website Development',
      customerName: 'Ahmed Khan',
      expectedRevenue: 85000.0,
      email: 'ahmed@example.com',
      phoneNumber: '+923001234567',
      description:
          'Customer needs a responsive business website.\n'
          'They want Home, About, Services, and Contact pages.\n'
          'The project should be completed within 3 weeks.',
      stage: 'New',
      createdDate: DateTime(2026, 9, 10),
    ),

    LeadModel(
      id: '2',
      leadName: 'Mobile App Development',
      customerName: 'Asad Ali',
      expectedRevenue: 150000.0,
      email: 'asad@example.com',
      phoneNumber: '+923111234567',
      description:
          'Customer is interested in a Flutter mobile application.\n'
          'The app will include authentication and user profiles.\n'
          'Firebase will be used for backend services.',
      stage: 'Qualified',
      createdDate: DateTime(2026, 9, 12),
    ),

    LeadModel(
      id: '3',
      leadName: 'E-Commerce App',
      customerName: 'Bilal Ahmed',
      expectedRevenue: 220000.0,
      email: 'bilal@example.com',
      phoneNumber: '+923221234567',
      description:
          'Customer wants an e-commerce application for their business.\n'
          'Required features include products, cart, checkout, and orders.\n'
          'They also need an admin panel for managing products.',
      stage: 'Sent Proposal',
      createdDate: DateTime(2026, 9, 15),
    ),

    LeadModel(
      id: '4',
      leadName: 'HR Management System',
      customerName: 'Hassan Raza',
      expectedRevenue: 300000.0,
      email: 'hassan@example.com',
      phoneNumber: '+923331234567',
      description:
          'Company needs an internal HR management system.\n'
          'The system should manage employees, attendance, and leaves.\n'
          'Payroll and employee reports may be added in the next phase.',
      stage: 'Won',
      createdDate: DateTime(2026, 9, 18),
    ),

    LeadModel(
      id: '5',
      leadName: 'Property Management App',
      customerName: 'Usman Sheikh',
      expectedRevenue: 175000.0,
      email: 'usman@example.com',
      phoneNumber: '+923451234567',
      description:
          'Customer wants a property listing and management application.\n'
          'Users should be able to search and view available properties.\n'
          'Property owners should be able to add and manage their listings.',
      stage: 'New',
      createdDate: DateTime(2026, 9, 20),
    ),
  ];
}
