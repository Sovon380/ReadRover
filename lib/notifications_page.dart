import 'package:flutter/material.dart';

class Notification {
  final String title;
  final String description;
  final DateTime timestamp;

  Notification({required this.title, required this.description, required this.timestamp});
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Notification> notifications = [
    Notification(
      title: "New Book Available!",
      description: "Check out the latest additions to our library.",
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    Notification(
      title: "Reading Challenge!",
      description: "Join our reading challenge for a chance to win prizes.",
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
    ),
    Notification(
      title: "Upcoming Event",
      description: "Don't miss our book signing event next week!",
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          DropdownButton<String>(
            value: selectedFilter,
            icon: Icon(Icons.filter_list),
            onChanged: (String? newValue) {
              setState(() {
                selectedFilter = newValue!;
                // Implement filtering logic based on selectedFilter
              });
            },
            items: <String>['All', 'Unread', 'Important']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
        child: Text("No new notifications", style: TextStyle(fontSize: 18)),
      )
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(notification.title),
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Notification dismissed")),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              elevation: 4.0,
              child: ListTile(
                leading: Icon(Icons.notifications, color: Colors.blue),
                title: Text(notification.title, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(notification.description),
                trailing: Text(
                  _formatTimestamp(notification.timestamp),
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationDetailPage(notification: notification)),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final timeAgo = DateTime.now().difference(timestamp);
    if (timeAgo.inMinutes < 60) {
      return '${timeAgo.inMinutes} min ago';
    } else if (timeAgo.inHours < 24) {
      return '${timeAgo.inHours} hr ago';
    } else {
      return '${timeAgo.inDays} day${timeAgo.inDays > 1 ? 's' : ''} ago';
    }
  }
}

class NotificationDetailPage extends StatelessWidget {
  final Notification notification;

  NotificationDetailPage({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(_formatTimestamp(notification.timestamp), style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            Text(notification.description, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final timeAgo = DateTime.now().difference(timestamp);
    if (timeAgo.inMinutes < 60) {
      return '${timeAgo.inMinutes} min ago';
    } else if (timeAgo.inHours < 24) {
      return '${timeAgo.inHours} hr ago';
    } else {
      return '${timeAgo.inDays} day${timeAgo.inDays > 1 ? 's' : ''} ago';
    }
  }
}
