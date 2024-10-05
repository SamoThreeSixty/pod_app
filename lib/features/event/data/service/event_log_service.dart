import 'package:flutter_dotenv/flutter_dotenv.dart';

class EventLogService {
  final String baseUrl = dotenv.env['ONEFIT_BASE_URL']!;

  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}

class AuthService {
  final String baseUrl = dotenv.env['ONEFIT_BASE_URL']!;
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
