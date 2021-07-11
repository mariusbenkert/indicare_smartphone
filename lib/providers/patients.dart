import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ms_project/providers/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Patients with ChangeNotifier {
  List<Patient> _patients = [];
  final String authToken;
  final String userId;

  Patients(this.authToken, this.userId, this._patients);

  List<Patient> get patients {
    return [..._patients];
  }

  Patient findById(String id) {
    return _patients.firstWhere((patient) => patient.id == id);
  }

  Future<void> fetchAndSetPatients([bool filterByPatient = false]) async {
    print(userId);
    final filterString = 'orderBy="caretakerId"&equalTo="$userId"';

    var urlString =
        'https://ms-project-88b21-default-rtdb.europe-west1.firebasedatabase.app/patients.json?auth=$authToken&$filterString';

    try {
      var url = Uri.parse(urlString);
      final response = await http.get(url);
      final extracedData = json.decode(response.body) as Map<String, dynamic>;

      if (extracedData == null) {
        return;
      }

      final List<Patient> loadedPatients = [];

      extracedData.forEach((patientId, patientData) {
        print("PatientID" + patientId);
        print(patientData);
        loadedPatients.add(Patient.fromMap(patientData, patientId));
      });

      _patients = loadedPatients;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addPatient(
      String firstName, String lastName, String email, String password) async {
    final urlStringSignUp =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDI3Je9hJqHzlevwdvPZW7cHDYjm8XDrMo';

    try {
      var urlSignUp = Uri.parse(urlStringSignUp);
      final responseSignUp = await http.post(
        urlSignUp,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final patientId = json.decode(responseSignUp.body)['localId'];

      final newPatient = Patient(
          firstName: firstName,
          lastName: lastName,
          email: email,
          id: patientId,
          isActive: true);

      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey('userData')) {
        return false;
      }

      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      final _userId = extractedUserData['userId'];

      final urlStringAddPatient =
          'https://ms-project-88b21-default-rtdb.europe-west1.firebasedatabase.app/patients/$patientId.json?auth=$authToken';
      var urlAddPatient = Uri.parse(urlStringAddPatient);

      final responseAddPatient = await http.put(urlAddPatient,
          body: json.encode({
            'caretakerId': _userId,
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'isActive': true
          }));

      _patients.add(newPatient);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updatePatient(String patientId, String firstName,
      String lastName, String email, bool isActive) async {
    final url =
        'https://ms-project-88b21-default-rtdb.europe-west1.firebasedatabase.app/patients/$patientId.json?auth=$authToken';

    var urlUpdatePatient = Uri.parse(url);
    await http.patch(urlUpdatePatient,
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
        }));

    final newPatient = new Patient(
        id: patientId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        isActive: isActive);

    final patientIndex =
        _patients.indexWhere((patient) => patient.id == patientId);

    print("PatienIndex: $patientIndex");
    print(_patients[patientIndex].fullName);

    _patients[patientIndex] = newPatient;
    notifyListeners();
  }

  //TODO: Implement deletePatient
  Future<void> deletePatient(String id) async {}
}
