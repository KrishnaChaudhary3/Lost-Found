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
import 'pages/chat_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/splash': (context) => const SplashPage(),
  '/login': (context) => const LoginPage(),
  '/signup': (context) => const SignUpPage(),
  '/forgot': (context) => ForgotPasswordPage(),
  '/home': (context) => const HomePage(),
  '/search': (context) => const SearchPage(),
  '/profile': (context) => const ProfilePage(),
  '/settings': (context) => const SettingsPage(),
  '/messages': (context) => const MessagesPage(),
  '/report': (context) => const ReportItemPage(),
  '/viewItem': (context) => const ViewItemPage(),
  '/chat': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return ChatPage(
      otherUserId: args['userId']!,
      otherUserName: args['name']!,
    );
  },
};
