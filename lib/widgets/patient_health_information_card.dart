import 'package:flutter/material.dart';

class PatientHealthInformationCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  const PatientHealthInformationCard({
    @required this.value,
    @required this.label,
    @required this.color,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "$label: $value",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
