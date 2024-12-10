import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional: Implement a drawer or bottom navigation if needed
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture Section
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile_placeholder.png'), // Default profile image
                    backgroundColor: Colors.blueGrey.shade200,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: InkWell(
                      onTap: () {
                        // Logic to upload a new profile picture
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // User Information Section within a Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Sovon Mallick", // Replace with dynamic user name
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "sovon.stu2019@juniv.edu", // Replace with dynamic user email
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "+8801720510987", // Replace with dynamic phone number
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to Edit Profile screen or show a form dialog
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Edit Profile"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Updated from 'primary'
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        textStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Activity Summary Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Activity Summary",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildProfileStat(Icons.book, "Books Borrowed", "12"),
                        _buildProfileStat(Icons.favorite, "Favorites", "5"),
                        _buildProfileStat(Icons.list, "Wishlist Items", "8"),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Settings Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.notifications, color: Colors.blueAccent),
                      title: Text("Notifications"),
                      trailing: Switch(
                        value: true, // Replace with dynamic value
                        onChanged: (bool value) {
                          // Handle notification toggle
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.dark_mode, color: Colors.blueAccent),
                      title: Text("Dark Mode"),
                      trailing: Switch(
                        value: false, // Replace with dynamic value
                        onChanged: (bool value) {
                          // Handle dark mode toggle
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.lock, color: Colors.blueAccent),
                      title: Text("Privacy Settings"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to Privacy Settings
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.help, color: Colors.blueAccent),
                      title: Text("Help & Support"),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to Help & Support
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                // Implement logout functionality
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Updated from 'primary'
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create profile statistics widgets with icons
  Widget _buildProfileStat(IconData icon, String label, String count) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 28),
        SizedBox(height: 6),
        Text(
          count,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
}
