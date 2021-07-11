import 'package:flutter/material.dart';
import 'package:ms_project/helpers/route_generator.dart';
import 'package:ms_project/providers/auth.dart';
import 'package:ms_project/providers/patients.dart';
import 'package:ms_project/screens/splash_screen.dart';
import 'package:ms_project/style.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Patients>(
          update: (ctx, auth, previousPatients) => Patients(
              auth.token,
              auth.userId,
              previousPatients == null ? [] : previousPatients.patients),
          create: null,
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'MyPatients',
          theme: Styles.themeData,
          initialRoute: SplashScreen.routeName,
          onGenerateInitialRoutes: (String routeName) => [
            RouteGenerator.generateRoute(
              RouteSettings(
                name: SplashScreen.routeName,
                arguments: {'authData': authData},
              ),
            ),
          ],
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
