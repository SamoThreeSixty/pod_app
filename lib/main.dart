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
import 'package:pod_app/features/delivery_list/data/datasources/delivery_remote_datasource.dart';
import 'package:pod_app/features/delivery_list/data/repository/delivery_list_repository_imp.dart';
import 'package:pod_app/features/delivery_list/domain/repository/delivery_header_repository.dart';
import 'package:pod_app/features/delivery_list/domain/usecases/get_all_delivery_headers.dart';
import 'package:pod_app/features/delivery_list/presentation/bloc/delivery_list_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final url = dotenv.env['SUPABASE_URL'];
  final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    throw Exception('Supabase environment variables are not loaded properly.');
  }

  final supabaseClient = SupabaseClient(url, anonKey);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            signInWithEmailPassword: SignInWithEmailPassword(
              AuthRepositoryImp(
                AuthRemoteDataSourceImp(supabaseClient),
              ),
            ),
            signOut: SignOut(
              AuthRepositoryImp(
                AuthRemoteDataSourceImp(supabaseClient),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => DeliveryListBloc(
            getAllDeliveryList: GetAllDeliveryHeaders(
              DeliveryListRepositoryImp(
                DeliveryListRemoteDataSource(supabaseClient),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
