import 'package:apps_flutter/app/view/overview.dart';
import 'package:flutter/material.dart';

import 'app/my_app.dart';

void main() => runApp(
    MaterialApp(
      title: 'Named Routes Smart Movies',
      initialRoute: '/',
      routes: {
        '/': (context) =>  SmartMoviesAPP(),
        '/overview': (context) => Overview(),
      },
    )
);



