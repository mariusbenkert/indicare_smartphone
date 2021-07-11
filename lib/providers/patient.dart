import 'dart:convert';

import 'package:flutter/material.dart';

class Patient with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isActive;

  String get alias => (firstName.isNotEmpty ? firstName[0].toUpperCase() : '');
  String get fullName => (firstName + ' ' + lastName).trim();

  Patient({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'isActive': isActive,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map, String patientId) {
    return Patient(
      id: patientId,
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      isActive: map['isActive'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());
}
