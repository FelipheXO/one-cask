import 'dart:convert';

import 'package:app/components/customButton.dart';
import 'package:app/components/customTextField.dart';
import 'package:app/models/acconts.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/globa.dart';
import 'package:app/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> sumit() async {
    isLoading = true;
    setState(() {});

    try {
      final shared = await SharedPreferences.getInstance();
      http.Response response = await http
          .get(Uri.parse(AppGlobal.login))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['record'];
        List<Accounts> data =
            jsonData.map((item) => Accounts.fromJson(item)).toList();
        for (var x in data) {
          if (x.email == _emailController.text &&
              x.password == _passwordController.text) {
            shared.setString(AppStorage.login, jsonEncode(x.toJson()));
            WidgetsBinding.instance.addPostFrameCallback((_) {
              GoRouter.of(context).go('/bottomNavigation');
            });
            isLoading = false;
            setState(() {});
            return;
          }
        }

        Fluttertoast.showToast(
            msg: "incorrect email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      //
      print(e);
    }
    isLoading = false;
    setState(() {});
  }

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Sign in ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              CustomTextField(
                label: 'Email',
                hintText: 'email@email.com',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                obscureText: obscure,
                onObscure: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                label: 'Password',
                hintText: 'Enter your password',
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                isLoading: isLoading,
                text: 'Continue',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sumit();
                  }
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Cant't sign in?",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      //
                    },
                    child: const Text(
                      "Recover password",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
