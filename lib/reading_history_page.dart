// lib/reading_history_page.dart

import 'package:flutter/material.dart';
import 'location_detail_page.dart';

class ReadingHistoryEntry {
  final String title;
  final String author;
  final String description;
  final String address;
  final DateTime borrowedDate;
  final String image;
  bool isFavorite;

  ReadingHistoryEntry({
    required this.title,
    required this.author,
    required this.description,
    required this.address,
    required this.borrowedDate,
    required this.image,
    this.isFavorite = false,
  });
}

class ReadingHistoryPage extends StatefulWidget {
  @override
  _ReadingHistoryPageState createState() => _ReadingHistoryPageState();
}

class _ReadingHistoryPageState extends State<ReadingHistoryPage> {
  List<ReadingHistoryEntry> readingHistory = [
    ReadingHistoryEntry(
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      description:
      "A novel set in the Roaring Twenties that critiques the American Dream.",
      address: "Scribner's, New York, NY",
      borrowedDate: DateTime(2024, 1, 15),
      image: "assets/great_gatsby.jpeg",
    ),
    ReadingHistoryEntry(
      title: "To Kill a Mockingbird",
      author: "Harper Lee",
      description:
      "A story of racial injustice and moral growth in the American South.",
      address: "J.B. Lippincott & Co., Philadelphia, PA",
      borrowedDate: DateTime(2024, 2, 5),
      image: "assets/to_kill_a_mocking_bird.jpeg",
    ),
    ReadingHistoryEntry(
      title: "1984",
      author: "George Orwell",
      description:
      "A dystopian novel exploring the dangers of totalitarianism.",
      address: "Secker & Warburg, London, UK",
      borrowedDate: DateTime(2024, 3, 10),
      image: "assets/1984.jpeg",
    ),
  ];

  List<ReadingHistoryEntry> filteredHistory = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredHistory = readingHistory;
  }

  void _filterHistory(String query) {
    List<ReadingHistoryEntry> results = [];
    if (query.isEmpty) {
      results = readingHistory;
    } else {
      results = readingHistory
          .where((entry) =>
      entry.title.toLowerCase().contains(query.toLowerCase()) ||
          entry.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      searchQuery = query;
      filteredHistory = results;
    });
  }

  Future<void> _refreshHistory() async {
    // Simulate a network call or database fetch
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // For demonstration, we'll just reverse the list
      readingHistory = readingHistory.reversed.toList();
      _filterHistory(searchQuery);
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      filteredHistory[index].isFavorite = !filteredHistory[index].isFavorite;
    });
  }

  void _removeEntry(int index) {
    setState(() {
      readingHistory.remove(filteredHistory[index]);
      _filterHistory(searchQuery);
    });
  }

  String _formatDate(DateTime date) {
    // Simple date formatting without intl
    return "${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}";
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  void _addNewEntry() {
    // Implement functionality to add a new reading history entry
    // For demonstration, we'll add a dummy entry
    setState(() {
      readingHistory.add(
        ReadingHistoryEntry(
          title: "New Book ${readingHistory.length + 1}",
          author: "Author ${readingHistory.length + 1}",
          description: "Description for New Book ${readingHistory.length + 1}",
          address: "Publisher Address ${readingHistory.length + 1}",
          borrowedDate: DateTime.now(),
          image: "assets/default_book.jpeg", // Ensure this image exists
        ),
      );
      _filterHistory(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading History"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              setState(() {
                readingHistory.sort((a, b) => b.borrowedDate.compareTo(a.borrowedDate));
                _filterHistory(searchQuery);
              });
            },
            tooltip: "Sort by Date",
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshHistory,
        child: Column(
          children: [
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
                onChanged: _filterHistory,
              ),
            ),
            Expanded(
              child: filteredHistory.isEmpty
                  ? Center(
                child: Text(
                  "No books found.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: filteredHistory.length,
                itemBuilder: (context, index) {
                  final entry = filteredHistory[index];
                  return Dismissible(
                    key: Key(entry.title + entry.borrowedDate.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.redAccent,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _removeEntry(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${entry.title} removed from history."),
                        ),
                      );
                    },
                    child: Card(
                      margin:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            entry.image,
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
                          entry.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "By ${entry.author}\nBorrowed on: ${_formatDate(entry.borrowedDate)}",
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                entry.isFavorite
                                    ? Icons.star
                                    : Icons.star_border,
                                color: entry.isFavorite
                                    ? Colors.yellow
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                _toggleFavorite(index);
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationDetailPage(
                                      name: entry.title,
                                      description: entry.description,
                                      address: entry.address,
                                      image: entry.image,
                                    ),
                                  ),
                                );
                              },
                              child: Text("Re-read"),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationDetailPage(
                                name: entry.title,
                                description: entry.description,
                                address: entry.address,
                                image: entry.image,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewEntry,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        tooltip: "Add Book",
      ),
    );
  }
}
