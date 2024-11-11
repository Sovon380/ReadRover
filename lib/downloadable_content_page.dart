import 'package:flutter/material.dart';

class DownloadableContentPage extends StatelessWidget {
  final List<String> downloadedBooks = [
    "The Great Gatsby",
    "1984",
    "Moby Dick",
    "War and Peace",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloaded Books"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: downloadedBooks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(downloadedBooks[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                // Implement delete download functionality
              },
            ),
            onTap: () {
              // Open book for offline reading
            },
          );
        },
      ),
    );
  }
}
