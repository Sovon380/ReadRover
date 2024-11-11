import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  // Sample data for wishlist items
  final List<Map<String, String>> _wishlistItems = [
    {
      "title": "The Great Gatsby",
      "author": "F. Scott Fitzgerald",
      "description": "A classic novel set in the Jazz Age, exploring themes of wealth and society."
    },
    {
      "title": "To Kill a Mockingbird",
      "author": "Harper Lee",
      "description": "A profound story of racial injustice in the Deep South, seen through a child's eyes."
    },
    {
      "title": "1984",
      "author": "George Orwell",
      "description": "A dystopian novel presenting a nightmarish vision of a totalitarian regime."
    },
    {
      "title": "Pride and Prejudice",
      "author": "Jane Austen",
      "description": "A romantic novel that also offers a critique of the British class system."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlist"),
        backgroundColor: Colors.blueAccent,
      ),
      body: _wishlistItems.isEmpty
          ? Center(
        child: Text(
          "Your wishlist is empty",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _wishlistItems.length,
        itemBuilder: (context, index) {
          final item = _wishlistItems[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.book, color: Colors.blueAccent, size: 30),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item["title"]!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Author: ${item["author"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item["description"]!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton.icon(
                      onPressed: () {
                        // Action for removing item from wishlist
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${item["title"]} removed from wishlist")),
                        );
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                      label: Text(
                        "Remove",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
