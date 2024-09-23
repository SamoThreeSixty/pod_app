import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:pod_app/features/auth/data/datasources/auth_datasources.dart';
import 'package:pod_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pod_app/features/auth/data/repository/auth_repository_imp.dart';
import 'package:pod_app/features/auth/domain/repository/auth_repository.dart';
import 'package:pod_app/features/auth/domain/usecase/sign_in_with_email_password.dart';
import 'package:pod_app/features/auth/domain/usecase/sign_out.dart';
import 'package:pod_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pod_app/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final url = dotenv.env['SUPABASE_URL'];
  final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    throw Exception('Supabase environment variables are not loaded properly.');
  }

  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );

  final supabaseClient = Supabase.instance.client;

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          signInWithEmailPassword: SignInWithEmailPassword(
            AuthRepositoryImp(
              AuthRemoteDataSource(supabaseClient),
            ),
          ),
          signOut: SignOut(
            AuthRepositoryImp(
              AuthRemoteDataSource(supabaseClient),
            ),
          ),
        ),
      ),
    ],
    child: Container(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PoD Application',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
