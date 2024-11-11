import 'package:flutter/material.dart';

class ReadingHistoryPage extends StatelessWidget {
  final List<Map<String, String>> readingHistory = [
    {"title": "The Great Gatsby", "date": "2024-01-15"},
    {"title": "To Kill a Mockingbird", "date": "2024-02-05"},
    {"title": "1984", "date": "2024-03-10"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading History"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: readingHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(readingHistory[index]["title"]!),
            subtitle: Text("Borrowed on: ${readingHistory[index]["date"]}"),
            trailing: ElevatedButton(
              child: Text("Re-read"),
              onPressed: () {
                // Implement re-read or re-borrow functionality
              },
            ),
            onTap: () {
              // Navigate to book details page
            },
          );
        },
      ),
    );
  }
}
