import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifiers/theme_notifier.dart';
import 'feedback_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotificationsEnabled = true;
  bool isTwoFactorEnabled = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Information Section
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.blueAccent),
            title: Text("Account Information", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("User's Name / Email"),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Navigate to Account Information Page or show an edit dialog
            },
          ),
          Divider(),

          // Theme Toggle
          ListTile(
            leading: Icon(Icons.dark_mode, color: Colors.blueAccent),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: themeNotifier.isDarkMode,
              onChanged: (value) {
                themeNotifier.toggleTheme(value);
              },
            ),
          ),

          // Language Selector
          ListTile(
            leading: Icon(Icons.language, color: Colors.blueAccent),
            title: Text("Language"),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  if (selectedLanguage == 'English') {
                    Provider.of<ThemeNotifier>(context, listen: false).setLocale(Locale('en'));
                  } else if (selectedLanguage == 'Bangla') {
                    Provider.of<ThemeNotifier>(context, listen: false).setLocale(Locale('bn'));
                  }
                });
              },
              items: <String>['English', 'Bangla'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

          // Notifications Toggle
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blueAccent),
            title: Text("Enable Notifications"),
            trailing: Switch(
              value: isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  isNotificationsEnabled = value;
                });
              },
            ),
          ),

          // Privacy and Security Section
          Divider(),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.blueAccent),
            title: Text("Change Password"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Show Change Password dialog or navigate to a new screen
            },
          ),
          ListTile(
            leading: Icon(Icons.security, color: Colors.blueAccent),
            title: Text("Two-Factor Authentication"),
            trailing: Switch(
              value: isTwoFactorEnabled,
              onChanged: (value) {
                setState(() {
                  isTwoFactorEnabled = value;
                });
              },
            ),
          ),

          // Data Management Section
          Divider(),
          ListTile(
            leading: Icon(Icons.storage, color: Colors.blueAccent),
            title: Text("Clear Cache"),
            onTap: () {
              // Implement cache clearing functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.download, color: Colors.blueAccent),
            title: Text("Download Data"),
            onTap: () {
              // Implement data download functionality
            },
          ),

          // Feedback and Support Section
          Divider(),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.blueAccent),
            title: Text("Send Feedback"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackPage()), // Navigate to FeedbackPage
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.blueAccent),
            title: Text("Help & FAQ"),
            onTap: () {
              // Navigate to Help & FAQ page
            },
          ),

          // About Section
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.blueAccent),
            title: Text("About"),
            subtitle: Text("App Version 1.0.0"),
            onTap: () {
              // Show additional information about the app
            },
          ),
          ListTile(
            leading: Icon(Icons.policy, color: Colors.blueAccent),
            title: Text("Terms & Conditions"),
            onTap: () {
              // Open terms and conditions (could use a WebView or new screen)
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.blueAccent),
            title: Text("Privacy Policy"),
            onTap: () {
              // Open privacy policy (could use a WebView or new screen)
            },
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implement logout functionality
                },
                icon: Icon(Icons.logout),
                label: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
