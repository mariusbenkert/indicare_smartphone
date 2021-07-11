import 'package:flutter/material.dart';
import 'package:ms_project/widgets/login_fields.dart';

typedef void OnSaveCallback(dynamic patient);

class PatientEditDialog extends StatefulWidget {
  final OnSaveCallback onSave;
  final dynamic data;

  PatientEditDialog({@required this.onSave, this.data});

  @override
  _PatientEditDialogState createState() => _PatientEditDialogState();
}

class _PatientEditDialogState extends State<PatientEditDialog> {
  final GlobalKey<FormState> _formKeyPatient = GlobalKey();

  Map<String, String> _patientData = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(
          widget.data != null
              ? 'Edit ${widget.data.fullName}'
              : 'Create patient',
        ),
        contentPadding: const EdgeInsets.all(16.0),
        content: Form(
          key: _formKeyPatient,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  keyboardType: TextInputType.name,
                  initialValue:
                      widget.data != null ? widget.data.firstName : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Invalid First Name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _patientData['firstName'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  keyboardType: TextInputType.name,
                  initialValue: widget.data != null ? widget.data.lastName : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Invalid Last Name!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _patientData['lastName'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: widget.data != null ? widget.data.email : '',
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _patientData['email'] = value;
                  },
                ),
                if (widget.data == null)
                  PasswordField(
                    labelText: 'Password',
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Invalid Password!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _patientData['password'] = value;
                    },
                  ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              if (!_formKeyPatient.currentState.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please check your inputs again!'),
                  ),
                );
                return;
              }
              _formKeyPatient.currentState.save();

              print(_patientData.toString());
              widget.onSave(_patientData);

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
