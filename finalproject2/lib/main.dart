import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository/login_repo.dart';
import 'views/login/login_page.dart';
import 'views/setting_page.dart';

//hi rahma :)👵🕵️‍♀️
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => loginn(Dio()), // Create an instance of the AuthenticationProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Booking Hotels',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),


      ),
    );
  }
}
