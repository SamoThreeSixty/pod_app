import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pod_app/core/common/cubits/cubit/app_theme_cubit.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  String appVersion = '';

  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appVersion =
          'Version: ${packageInfo.version}, Build: ${packageInfo.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Container();
                        },
                      ),
                    );
                  },
                  child: const Text('Press me for events'),
                ),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return ListTile(
                      leading: Switch(
                        value: themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          // Trigger the toggle in ThemeCubit
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      ),
                      title: Text(themeMode == ThemeMode.dark
                          ? 'Dark Mode'
                          : 'Light Mode'),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(appVersion),
          ),
        ],
      ),
    );
  }
}
