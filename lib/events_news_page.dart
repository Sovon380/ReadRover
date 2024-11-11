import 'package:flutter/material.dart';

class EventsNewsPage extends StatelessWidget {
  final List<Map<String, String>> events = [
    {"title": "Author Talk: J.K. Rowling", "date": "2024-05-15"},
    {"title": "Library Workshop on Fiction Writing", "date": "2024-06-01"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events & News"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index]["title"]!),
            subtitle: Text("Date: ${events[index]["date"]}"),
            trailing: ElevatedButton(
              child: Text("RSVP"),
              onPressed: () {
                // Implement RSVP functionality
              },
            ),
            onTap: () {
              // Navigate to detailed event page or show event details
            },
          );
        },
      ),
    );
  }
}
