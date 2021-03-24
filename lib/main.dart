import 'package:flutter/material.dart';
import 'package:homeward_interview_sample_code/business_logic/providers/blog_provider.dart';
import 'package:homeward_interview_sample_code/ui/blog_list.dart';
import 'package:homeward_interview_sample_code/ui/login.dart';
import 'package:provider/provider.dart';

import 'business_logic/providers/login_provider.dart';
import 'services/utils/service_locator.dart';

void main() {
  // * Initialize GET IT Library
  setupServiceLocator();
  // * Run My App
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider()),
          ChangeNotifierProvider<BlogProvider>(
              create: (context) => BlogProvider())
        ],
        child: MaterialApp(
          title: 'Sample App',
          routes: <String, WidgetBuilder>{},
          home: WelcomePage(),
        ));
  }
}

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isUserLoggedIn(context),
        builder: (___, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null && snapshot.data!) {
            return BlogList();
          }
          return Login();
        });
  }

  // * Function To Check If User is Logged In so Go Direct to Blog List Page
  Future<bool> isUserLoggedIn(BuildContext context) async {
    final bool isLoggedIn =
        await Provider.of<LoginProvider>(context, listen: false)
            .isUserLoggedIn();
    return Future.value(isLoggedIn);
  }
}
