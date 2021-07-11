import 'package:flutter/material.dart';
import 'package:ms_project/providers/patients.dart';
import 'package:ms_project/screens/app_drawer.dart';
import 'package:ms_project/widgets/patient_edit_dialog.dart';
import 'package:ms_project/widgets/patients_grid.dart';
import 'package:provider/provider.dart';

class PatientsOverviewScreen extends StatefulWidget {
  static const routeName = '/patient-overview';

  @override
  _PatientsOverviewScreenState createState() => _PatientsOverviewScreenState();
}

class _PatientsOverviewScreenState extends State<PatientsOverviewScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Patients>(context).fetchAndSetPatients().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patientenübersicht'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PatientsGrid(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (_) => PatientEditDialog(
        onSave: (patientData) {
          Provider.of<Patients>(context, listen: false).addPatient(
            patientData['firstName'],
            patientData['lastName'],
            patientData['email'],
            patientData['password'],
          );
        },
      ),
    );
  }
}
