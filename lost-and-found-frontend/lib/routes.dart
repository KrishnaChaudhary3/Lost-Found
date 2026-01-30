import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/messages_page.dart';
import 'pages/report_item_page.dart';
import 'pages/view_item_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/splash': (context) => SplashPage(),
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignUpPage(),
  '/forgot': (context) => ForgotPasswordPage(),
  '/home': (context) => HomePage(),
  '/search': (context) => SearchPage(),
  '/profile': (context) => ProfilePage(),
  '/settings': (context) => SettingsPage(),
  '/messages': (context) => MessagesPage(),
  '/report': (context) => ReportItemPage(),
  '/viewItem': (context) => ViewItemPage(),
};
