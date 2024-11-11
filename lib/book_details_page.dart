import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Book Title", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Author: John Doe", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Description", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              "This is a detailed description of the book. It covers the plot, characters, and main themes.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
