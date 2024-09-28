import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pod_app/features/auth/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageWithDrawer extends StatefulWidget {
  const PageWithDrawer({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  State<PageWithDrawer> createState() => _PageWithDrawerState();
}

class MenuOptions {
  final String option;
  final String route;
  final Icon icon;
  MenuOptions({required this.option, required this.route, required this.icon});
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
        icon: const Icon(Icons.drive_eta)),
    MenuOptions(
        option: 'Download Orders',
        route: 'download_orders',
        icon: const Icon(Icons.download)),
    MenuOptions(
        option: 'View Cache',
        route: 'view_cache',
        icon: const Icon(Icons.cached)),
    MenuOptions(
        option: 'Image Upload',
        route: 'image_upload',
        icon: const Icon(Icons.upload)),
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
            const Icon(Icons.account_circle)
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const SizedBox(
              child: DrawerHeader(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Sam Bradshaw',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('sam@logma.co.uk',
                              style: TextStyle(color: Colors.white)),
                        ],
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
                    builder: (context) => Container(),
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
