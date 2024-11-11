import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'wishlist_page.dart';
import 'locations_page.dart';
import 'book_details_page.dart';
import 'search_page.dart';
import 'notifications_page.dart';
import 'settings_page.dart';
import 'favourites_page.dart';
import 'reading_history_page.dart';
import 'events_news_page.dart';
import 'downloadable_content_page.dart';
import 'book_categories_page.dart';

class MainNavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Calculate crossAxisCount based on screen width for responsiveness
    int crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 3;

    return Scaffold(
      appBar: AppBar(
        title: Text("Explore ReadRover"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: navigationItems.length,
          itemBuilder: (context, index) {
            return _buildNavigationCard(
              context,
              icon: navigationItems[index]['icon'] as IconData,
              label: navigationItems[index]['label'] as String,
              color: navigationItems[index]['color'] as Color,
              page: navigationItems[index]['page'] as Widget,
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
        required Widget page,
      }) {
    return GestureDetector(
      onTap: () {
        // Navigate to the selected page with error handling
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to open $label')),
          );
        });
      },
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Navigation items list with unique colors and pages
final List<Map<String, dynamic>> navigationItems = [
  {
    'icon': Icons.favorite,
    'label': "Wishlist",
    'color': Colors.pinkAccent,
    'page': WishlistPage(),
  },
  {
    'icon': Icons.location_on,
    'label': "Library Locations",
    'color': Colors.green,
    'page': LocationsPage(),
  },
  {
    'icon': Icons.book,
    'label': "Book Details",
    'color': Colors.orange,
    'page': BookDetailsPage(),
  },
  {
    'icon': Icons.search,
    'label': "Search Books",
    'color': Colors.blue,
    'page': SearchPage(),
  },
  {
    'icon': Icons.notifications,
    'label': "Notifications",
    'color': Colors.red,
    'page': NotificationsPage(),
  },
  {
    'icon': Icons.settings,
    'label': "Settings",
    'color': Colors.grey,
    'page': SettingsPage(),
  },
  {
    'icon': Icons.person,
    'label': "My Profile",
    'color': Colors.purple,
    'page': ProfilePage(),
  },
  {
    'icon': Icons.star,
    'label': "Favorites",
    'color': Colors.amber,
    'page': FavoritesPage(),
  },
  {
    'icon': Icons.history,
    'label': "Reading History",
    'color': Colors.cyan,
    'page': ReadingHistoryPage(),
  },
  {
    'icon': Icons.event,
    'label': "Events & News",
    'color': Colors.teal,
    'page': EventsNewsPage(),
  },
  {
    'icon': Icons.download,
    'label': "Downloaded Content",
    'color': Colors.indigo,
    'page': DownloadableContentPage(),
  },
  {
    'icon': Icons.category,
    'label': "Book Categories",
    'color': Colors.brown,
    'page': BookCategoriesPage(),
  },
];
