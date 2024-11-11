import 'package:flutter/material.dart';

class BookCategoriesPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"name": "Fiction", "icon": "assets/icons/fiction.jpeg"},
    {"name": "Non-Fiction", "icon": "assets/icons/nonfiction.jpeg"},
    {"name": "Science", "icon": "assets/icons/science.jpeg"},
    {"name": "History", "icon": "assets/icons/history.jpeg"},
    // Add more categories here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Categories"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryCard(
              context,
              categories[index]["name"]!,
              categories[index]["icon"]!,
            );
          },
        ),
      ),
    );
  }

  // Helper method to build each category card
  Widget _buildCategoryCard(BuildContext context, String categoryName, String iconPath) {
    return GestureDetector(
      onTap: () {
        // Navigate to a list of books for this category
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BooksListPage(categoryName: categoryName),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.book, size: 60, color: Colors.grey); // Placeholder icon
                },
              ),
              const SizedBox(height: 10),
              Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BooksListPage extends StatelessWidget {
  final String categoryName;

  BooksListPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Books'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text("List of $categoryName books will be displayed here."),
      ),
    );
  }
}
