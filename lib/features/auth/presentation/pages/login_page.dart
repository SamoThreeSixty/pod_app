import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/core/common/widgets/app_page_with_drawer.dart';
import 'package:pod_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pod_app/features/auth/presentation/pages/register_account.dart';
import 'package:pod_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:pod_app/features/delivery_list/presentation/pages/delivery_list.dart';
import 'package:pod_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authTokenController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement check logged in
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    authTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove back button in appbar.
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Form(
                key: formKey,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 150,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/3.0x/flutter_logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text("Sign in"),
              AuthField(
                hintText: 'Email',
                controller: emailController,
                icon: const Icon(Icons.person),
              ),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                icon: const Icon(Icons.lock),
                isObscureText: true,
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthSignIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) {
                        return const SignupPage();
                      },
                    ),
                  );
                },
                child: Column(
                  children: [
                    const Text("Need an account? "),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Click here.',
                        style: TextStyle(color: Colors.blueAccent.shade400),
                      ),
                    ),
                  ],
                ),
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoading) {
                    // Show the loading dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  } else if (state is AuthLoggedIn || state is AuthFailure) {
                    // Close the loading dialog if it's open
                    Navigator.of(context, rootNavigator: true).pop();

                    if (state is AuthLoggedIn) {
                      // TODO: Add a check that will make sure if the user has an associated company or not

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (builder) {
                            return PageWithDrawer(
                              title: 'PoD Application',
                              body: const DeliveryList(),
                            );
                          },
                        ),
                      );
                    }

                    if (state is AuthFailure) {
                      // Show an error dialog or message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login failed')),
                      );
                    }
                  }
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
