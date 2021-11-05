import 'package:apps_flutter/app/my_app.dart';
import 'package:apps_flutter/app/view/overview.dart';
import 'package:flutter/material.dart';

class Routes extends StatelessWidget{
  const Routes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SmartMoviesAPP(),
        '/overview': (context) => const Overview(),
      },
    );
  }
}