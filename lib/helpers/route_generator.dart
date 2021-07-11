import 'package:flutter/material.dart';
import 'package:ms_project/screens/map_screen.dart';
import 'package:ms_project/screens/profile_screen.dart';

import '../screens/patient_detail_screen.dart';
import '../screens/patient_overview_screen.dart';
import '../screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments as Map;

    switch (settings.name) {
      case SplashScreen.routeName:
        if (args == null || args['authData'] == null) {
          break;
        }

        return MaterialPageRoute(
          builder: (_) => SplashScreen(authData: args['authData']),
        );

      case ProfileScreen.routeName:
        // if (args == null || args['authData'] == null) {
        //   break;
        // }

        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      case PatientDetailScreen.routeName:
        if (args == null || args['patientId'] == null) {
          break;
        }

        return MaterialPageRoute(
            builder: (_) => PatientDetailScreen(args['patientId']));

      case MapScreen.routeName:
        if (args == null || args['location'] == null) {
          break;
        }

        return MaterialPageRoute(
            builder: (_) => MapScreen(args['location'], args['patientName']));

      case PatientsOverviewScreen.routeName:
      default:
        return MaterialPageRoute(builder: (_) => PatientsOverviewScreen());
    }
  }
}
