import 'package:hrm_app/features/crm/models/lead_note_model.dart';

class LeadModel {
  final String id;
  final String leadName;
  final String customerName;
  final double expectedRevenue;
  final String email;
  final String phoneNumber;
  final String description;
  final String stage;
  final DateTime createdDate;
  final List<LeadNoteModel> history;

  LeadModel({
    required this.id,
    required this.leadName,
    required this.customerName,
    required this.expectedRevenue,
    required this.email,
    required this.phoneNumber,
    required this.description,
    required this.stage,
    required this.createdDate,
    this.history = const [],
  });

  LeadModel copyWith({
    String? leadName,
    String? customerName,
    double? expectedRevenue,
    String? email,
    String? phoneNumber,
    String? description,
    String? stage,
    List<LeadNoteModel>? history,
  }) {
    return LeadModel(
      id: id,
      leadName: leadName ?? this.leadName,
      customerName: customerName ?? this.customerName,
      expectedRevenue: expectedRevenue ?? this.expectedRevenue,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
      stage: stage ?? this.stage,
      createdDate: createdDate,
      history: history ?? this.history,
    );
  }

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'] ?? '',
      leadName: json['leadName'] ?? '',
      customerName: json['customerName'] ?? '',
      expectedRevenue: (json['expectedRevenue'] ?? 0).toDouble(),
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      description: json['description'] ?? '',
      stage: json['stage'] ?? 'New',
      createdDate:
          DateTime.tryParse(json['createdDate'] ?? '') ?? DateTime.now(),
      history: json['history'] != null
          ? (json['history'] as List)
                .map((e) => LeadNoteModel.fromJson(e))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leadName': leadName,
      'customerName': customerName,
      'expectedRevenue': expectedRevenue,
      'email': email,
      'phoneNumber': phoneNumber,
      'description': description,
      'stage': stage,
      'createdDate': createdDate.toIso8601String(),
      'history': history.map((e) => e.toJson()).toList(),
    };
  }
}
