import 'package:app/utils/assets.dart';
import 'package:app/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final shared = await SharedPreferences.getInstance();
      Future.delayed(const Duration(seconds: 2), () async {
        if (mounted) {
          final login = shared.getString(AppStorage.login) ?? "";
          if (login.isEmpty) {
            GoRouter.of(context).go('/welcome');
          } else {
            GoRouter.of(context).go('/bottomNavigation');
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              Assets.background,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              Assets.logo,
              width: 140,
              height: 140,
            ),
          ),
        ],
      ),
    );
  }
}
