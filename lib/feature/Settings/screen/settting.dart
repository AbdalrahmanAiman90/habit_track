import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/feature/Auth/ui/screen/login_screen.dart';
import 'package:habit_track/feature/Auth/ui/screen/register_screen.dart';
import 'package:habit_track/feature/Settings/screen/Policy.dart';
import 'package:habit_track/feature/Settings/screen/TermsAndCondition.dart';
import 'package:habit_track/feature/Settings/widget/SettingOption.dart';
import 'package:habit_track/feature/Settings/screen/account.dart';
import 'package:habit_track/feature/Settings/screen/About.dart';
import 'package:habit_track/feature/Auth/cubit/cubit/auth_cubit.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: AppBar(
            title: const Text("Setting", style: TextStyle(fontSize: 30)),
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 40, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hello, ',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Gasser',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  // Account
                  buildSettingsOption(
                    title: 'Account',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AccountPage(),
                        ),
                      );
                    },
                  ),
                  // Notifications with a switch
                  Stack(
                    children: [
                      buildSettingsOption(
                        title: 'Notifications',
                        onTap: () {
                          // Handle any tap action if needed
                        },
                      ),
                      Positioned(
                        right: 10,
                        top: 0,
                        bottom: 0,
                        child: Switch(
                          value: _notificationsEnabled,
                          onChanged: (bool newValue) {
                            setState(() {
                              _notificationsEnabled = newValue;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  // Terms and Conditions
                  buildSettingsOption(
                    title: 'Term and Condition',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditionsPage(),
                        ),
                      );
                    },
                  ),
                  // Policy
                  buildSettingsOption(
                    title: 'Policy',
                    onTap: () {
                      // Navigate to policy
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PrivacyPolicyPage(),
                        ),
                      );
                    },
                  ),
                  // About App
                  buildSettingsOption(
                    title: 'About App',
                    onTap: () {
                      // Navigate to about app
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AboutPage(),
                        ),
                      );
                    },
                  ),
                  // Logout
                  buildSettingsOption(
                    title: 'Logout',
                    titleColor: Colors.red,
                    onTap: () {
                      context.read<AuthCubit>().logOut();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                      // Logout function
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
