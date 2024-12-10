// lib/favorites_page.dart

import 'package:flutter/material.dart';

class FavoriteBook {
  final String title;
  final String author;
  final String description;
  final String image;
  bool isFavorite;

  FavoriteBook({
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    this.isFavorite = true,
  });
}

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<FavoriteBook> favoriteBooks = [
    FavoriteBook(
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      description:
      "A novel set in the Roaring Twenties that critiques the American Dream.",
      image: "assets/great_gatsby.jpeg",
    ),
    FavoriteBook(
      title: "To Kill a Mockingbird",
      author: "Harper Lee",
      description:
      "A story of racial injustice and moral growth in the American South.",
      image: "assets/to_kill_a_mockingbird.jpeg",
    ),
    FavoriteBook(
      title: "1984",
      author: "George Orwell",
      description:
      "A dystopian novel exploring the dangers of totalitarianism.",
      image: "assets/1984.jpeg",
    ),
    FavoriteBook(
      title: "Pride and Prejudice",
      author: "Jane Austen",
      description:
      "A romantic novel that also critiques the British class system of the early 19th century.",
      image: "assets/pride_and_prejudice.jpeg",
    ),
    FavoriteBook(
      title: "The Catcher in the Rye",
      author: "J.D. Salinger",
      description:
      "A story about teenage rebellion and angst as experienced by Holden Caulfield.",
      image: "assets/the_catcher_in_the_rye.jpeg",
    ),
  ];

  List<FavoriteBook> filteredBooks = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredBooks = favoriteBooks;
  }

  void _filterBooks(String query) {
    List<FavoriteBook> results = [];
    if (query.isEmpty) {
      results = favoriteBooks;
    } else {
      results = favoriteBooks
          .where((book) =>
      book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      searchQuery = query;
      filteredBooks = results;
    });
  }

  void _removeFromFavorites(int index) {
    setState(() {
      favoriteBooks.remove(filteredBooks[index]);
      _filterBooks(searchQuery);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${filteredBooks[index].title} removed from favorites."),
      ),
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      filteredBooks[index].isFavorite = !filteredBooks[index].isFavorite;
    });
  }

  void _navigateToDetail(FavoriteBook book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(book: book),
      ),
    );
  }

  void _addNewFavorite() {
    // Implement functionality to add a new favorite book
    // For demonstration, we'll add a dummy book
    setState(() {
      favoriteBooks.add(
        FavoriteBook(
          title: "New Book ${favoriteBooks.length + 1}",
          author: "Author ${favoriteBooks.length + 1}",
          description:
          "Description for New Book ${favoriteBooks.length + 1}. This is a placeholder book.",
          image: "assets/default_book.jpeg", // Ensure this image exists
        ),
      );
      _filterBooks(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorites"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              setState(() {
                favoriteBooks.sort((a, b) => a.title.compareTo(b.title));
                _filterBooks(searchQuery);
              });
            },
            tooltip: "Sort Alphabetically",
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by title or author",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: _filterBooks,
            ),
          ),
          // Favorites List
          Expanded(
            child: filteredBooks.isEmpty
                ? Center(
              child: Text(
                "No favorite books found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return Dismissible(
                  key: Key(book.title + book.author),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.redAccent,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _removeFromFavorites(index);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          book.image,
                          width: 50,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 50,
                              height: 80,
                              color: Colors.grey,
                              child: Icon(Icons.book, color: Colors.white),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "By ${book.author}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              book.isFavorite
                                  ? Icons.star
                                  : Icons.star_border,
                              color: book.isFavorite
                                  ? Colors.yellow
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              _toggleFavorite(index);
                            },
                            tooltip: book.isFavorite
                                ? "Unfavorite"
                                : "Favorite",
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _navigateToDetail(book);
                            },
                            child: Text("Details"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        _navigateToDetail(book);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewFavorite,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        tooltip: "Add Favorite",
      ),
    );
  }
}

class BookDetailPage extends StatelessWidget {
  final FavoriteBook book;

  BookDetailPage({required this.book});

  String _formatTitle(String title) {
    // Capitalize the first letter of each word
    return title.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_formatTitle(book.title)),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Book Image
            Image.asset(
              book.image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey,
                  child: Icon(Icons.book, color: Colors.white, size: 100),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Title
                  Text(
                    _formatTitle(book.title),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Book Author
                  Text(
                    "By ${book.author}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Book Description
                  Text(
                    book.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Additional Information
                  Row(
                    children: [
                      Icon(Icons.book, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text(
                        "Genre: Fiction",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text(
                        "Published: 1925",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement functionality like "Read Now" or "Borrow"
                        },
                        icon: Icon(Icons.book),
                        label: Text("Read Now"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement functionality like "Share"
                        },
                        icon: Icon(Icons.share),
                        label: Text("Share"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
