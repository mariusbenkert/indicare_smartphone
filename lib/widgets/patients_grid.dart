import 'package:flutter/material.dart';
import 'package:ms_project/providers/patients.dart';
import 'package:ms_project/widgets/patient_item.dart';
import 'package:provider/provider.dart';

class PatientsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final patientsData = Provider.of<Patients>(context);
    final patients = patientsData.patients;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: patients[index],
        child: PatientItem(patient: patients[index]),
      ),
      itemCount: patients.length,
    );
  }
}
