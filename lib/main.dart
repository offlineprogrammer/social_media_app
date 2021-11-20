import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';
import 'controllers/bindings/controllers_bindings.dart';
import 'pages/loading_page.dart';
import 'services/amplify_service.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _configureAmplify();
    });
  }

  void _configureAmplify() async {
    await AmplifyService.configureAmplify();
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authenticator = Authenticator(
      child: LoadingPage(), // const Text('You are logged in!'),
    );

    return GetMaterialApp(
      initialBinding: ControllersBindings(),
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: authenticator,
      getPages: AppRoutes.routes,
    );
  }

  Scaffold _waitForAmplify() {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
