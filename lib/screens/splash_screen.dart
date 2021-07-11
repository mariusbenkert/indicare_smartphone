import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'patient_overview_screen.dart';

class SplashScreen extends StatelessWidget {
  final authData;

  SplashScreen({this.authData});

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return authData.isAuth
        ? PatientsOverviewScreen()
        : FutureBuilder(
            future: authData.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
                authResultSnapshot.connectionState == ConnectionState.waiting
                    ? Scaffold(
                        body: Center(
                          child: Text('Loading...'),
                        ),
                      )
                    : AuthScreen(),
          );
  }
}
