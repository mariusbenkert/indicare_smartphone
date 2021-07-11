import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:ms_project/providers/patients.dart';
import 'package:ms_project/screens/map_screen.dart';
import 'package:ms_project/style.dart';
import 'package:ms_project/widgets/patient_edit_dialog.dart';
import 'package:ms_project/widgets/patient_health_information_card.dart';
import 'package:provider/provider.dart';

class PatientDetailScreen extends StatefulWidget {
  // final String title;
  // final double price;

  final String patientId;

  PatientDetailScreen(this.patientId);

  static const routeName = '/patient-detail';

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  Map<String, dynamic> _realtimeValues = {};

  DatabaseReference _realtimeValuesRef;
  StreamSubscription<Event> _realtimeValuesSubscription;

  DatabaseError _error;

  @override
  void initState() {
    super.initState();

    _realtimeValuesRef = FirebaseDatabase.instance
        .reference()
        .child('patients')
        .child(widget.patientId)
        .child('realtimeValues');

    // _realtimeValuesRef.once().then((DataSnapshot snapshot) {
    //   // print('Connected to Patients and read ${snapshot.value}');
    // });

    _realtimeValuesSubscription =
        _realtimeValuesRef.onValue.listen((Event event) {
      if (event.snapshot.value != null) {
        setState(() {
          _error = null;
          _realtimeValues = Map<String, dynamic>.from(event.snapshot.value);
        });
      }
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      setState(() {
        _error = error;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _realtimeValuesSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<Patients>(
      context,
      listen: false,
    ).findById(widget.patientId);

    final placeholderImage = CircleAvatar(
      radius: 32.0,
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(
        patient.alias,
        style: TextStyle(
          color: Colors.white,
          fontSize: Styles.largeFontSize,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(patient.fullName),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          _showDialog(patient);
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            placeholderImage,
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(children: [
                Text(patient.fullName),
                Text(patient.email ?? '-'),
              ]),
            ),
            SizedBox(height: 24.0),
            patient.isActive
                ? Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children: [
                        if (_realtimeValues['heartRate'] != null)
                          PatientHealthInformationCard(
                            value:
                                _realtimeValues['heartRate'].toStringAsFixed(0),
                            label: 'Heartrate',
                            icon: Icons.favorite_border,
                            color: Colors.red[100],
                          ),
                        if (_realtimeValues['stepCount'] != null)
                          PatientHealthInformationCard(
                            value: _realtimeValues['stepCount'].toString(),
                            label: 'Step count',
                            icon: Icons.directions_walk_outlined,
                            color: Colors.green[100],
                          ),
                        if (_realtimeValues['activity'] != null)
                          PatientHealthInformationCard(
                            value: _realtimeValues['activity'].toString(),
                            label: 'Activity',
                            icon: Icons.local_activity_outlined,
                            color: Colors.blue[100],
                          ),
                        if (_realtimeValues['location'] != null)
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                MapScreen.routeName,
                                arguments: {
                                  'location': _realtimeValues['location'],
                                  'patientName': patient.firstName
                                },
                              );
                            },
                            child: Card(
                              color: Colors.yellow[100],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.place,
                                    size: 32.0,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "Location",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : Container(
                    height: 128.0,
                    child: Card(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.do_not_touch_outlined,
                            size: 32.0,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Realtime data deactivated',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _showDialog(dynamic patientData) async {
    await showDialog<String>(
      context: context,
      builder: (_) => PatientEditDialog(
        data: patientData,
        onSave: (patientData) {
          Provider.of<Patients>(context, listen: false).updatePatient(
              widget.patientId,
              patientData['firstName'],
              patientData['lastName'],
              patientData['email'],
              true);
        },
      ),
    );
  }
}
