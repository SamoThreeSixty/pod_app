import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/core/common/widgets/app_settings.dart';
import 'package:pod_app/core/common/widgets/connectivity_state.dart';
import 'package:pod_app/core/usecase/auth/presentation/bloc/auth_bloc.dart';
import 'package:pod_app/core/usecase/auth/presentation/pages/login_page.dart';
import 'package:pod_app/features/delivery_list/presentation/pages/delivery_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageWithDrawer extends StatefulWidget {
  PageWithDrawer({super.key, required this.title, required this.body});

  final String title;
  Widget body;

  @override
  State<PageWithDrawer> createState() => _PageWithDrawerState();
}

class MenuOptions {
  final String option;
  final String route;
  final Icon icon;
  final Widget widget;
  MenuOptions({
    required this.option,
    required this.route,
    required this.icon,
    required this.widget,
  });
}

class _PageWithDrawerState extends State<PageWithDrawer> {
  int currentIndex = 0;

  SharedPreferences? sharedPreferences;

  Future getSharedPreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences = pref; // Store the preferences after fetching them
    });
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  final List<MenuOptions> menuOptions = [
    MenuOptions(
      option: 'Deliveries',
      route: 'deliveries',
      icon: const Icon(Icons.drive_eta),
      widget: const DeliveryList(),
    ),
    MenuOptions(
      option: 'Download Orders',
      route: 'download_orders',
      widget: Container(),
      icon: const Icon(Icons.download),
    ),
    MenuOptions(
      option: 'View Cache',
      route: 'view_cache',
      widget: Container(),
      icon: const Icon(Icons.cached),
    ),
    MenuOptions(
      option: 'Image Upload',
      route: 'image_upload',
      widget: Container(),
      icon: const Icon(Icons.upload),
    ),
  ];

  final bool themeProvider = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // this prevents the default leading for AppBar
        title: Row(
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            Expanded(
              child: Center(
                child: Text(widget.title),
              ),
            ),
            const ConnectivityState()
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            child: Text(
                              'PoD Device',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoggedIn) {
                            final String email = state.user.email!;

                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    email,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ]);
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuOptions.length,
                itemBuilder: (context, index) {
                  final option = menuOptions[index];

                  return ListTile(
                    selected: currentIndex == index,
                    leading: option.icon,
                    title: Text(option.option),
                    onTap: () {
                      // TODO: Add routing
                      setState(() {
                        currentIndex = index;
                        widget.body = option.widget;
                      });
                    },
                  );
                },
              ),
            ),
            ListTile(
              title: const Text('settings'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AppSettings(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: const Icon(Icons.logout),
              onTap: () {
                // Reset the dropbox access token when signed out
                sharedPreferences!.remove('dropbox_access_token');

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const LoginPage(), // Replace with your page widget
                  ),
                );

                context.read<AuthBloc>().add(
                      AuthSignOut(),
                    );

                final authState = context.read<AuthBloc>().state;
                if (authState is AuthLoggedIn) {
                  print("Current token: $authState");
                } else {
                  print("Token is not available.");
                }
              },
            ),
          ],
        ),
      ),
      body: widget.body,
    );
  }
}
