import 'package:flutter/material.dart';
import 'package:ms_project/providers/patient.dart';
import 'package:ms_project/screens/patient_detail_screen.dart';
import 'package:ms_project/style.dart';

class PatientItem extends StatelessWidget {
  final Patient patient;

  PatientItem({@required this.patient});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Styles.textColorPrimary,
      fontSize: 16.0,
    );

    final placeholderImage = CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(
        patient.alias,
        style: TextStyle(
          color: Colors.white,
          fontSize: Styles.largeFontSize,
        ),
      ),
    );

    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                PatientDetailScreen.routeName,
                arguments: {'patientId': patient.id},
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  placeholderImage,
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "${patient.firstName}",
                    style: textStyle,
                  ),
                  Text(
                    "${patient.lastName}",
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
