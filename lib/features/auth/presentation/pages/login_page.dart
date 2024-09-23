import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pod_app/features/auth/presentation/pages/register_account.dart';
import 'package:pod_app/features/auth/presentation/widgets/auth_field.dart';
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
                  child: Image(
                    image: AssetImage('assets/images/3.0x/flutter_logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text("Sign in"),
              AuthField(
                hintText: 'Email',
                controller: emailController,
                icon: Icon(Icons.person),
              ),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                icon: Icon(Icons.lock),
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
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) {
                        return SignupPage();
                      },
                    ),
                  );
                },
                child: Column(
                  children: [
                    Text("Need an account? "),
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

                    if (state is AuthFailure) {
                      // Show an error dialog or message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login failed')),
                      );
                    }
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoggedIn) {
                      return Text("Logged in");
                    } else if (state is AuthFailure) {
                      return Text("Login failure");
                    }
                    // Initial or idle state UI
                    return Container(); // Show empty container or default login form
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
