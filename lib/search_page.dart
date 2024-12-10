// lib/search_page.dart

import 'package:flutter/material.dart';
import 'book_details_page.dart'; // Ensure this import points to your BookDetailsPage
import 'date_formatting.dart'; // Import the DateFormatting extension

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Controller for the search input
  final TextEditingController _searchController = TextEditingController();

  // Simulated search results; replace with actual data fetching logic
  List<Map<String, dynamic>> _searchResults = [];

  // Loading state
  bool _isLoading = false;

  // Filter and Sort options
  String _selectedGenre = 'All';
  String _selectedAuthor = 'All';
  DateTimeRange? _selectedDateRange;
  String _sortBy = 'Title';

  // Sample data for genres and authors; replace with dynamic data as needed
  final List<String> _genres = [
    'All',
    'Adventure',
    'Fantasy',
    'Science Fiction',
    'Romance',
    'Mystery'
  ];
  final List<String> _authors = [
    'All',
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Robert Brown'
  ];

  // Function to simulate search; replace with actual search logic
  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate a network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulated search results
    List<Map<String, dynamic>> results = [
      {
        'title': 'The Great Adventure',
        'author': 'John Doe',
        'description':
        'An exhilarating journey through mystical lands and compelling characters.',
        'cover': 'assets/book_placeholder.png',
        'genre': 'Adventure',
        'publicationDate': DateTime(2020, 1, 1),
        'rating': 4.5,
      },
      {
        'title': 'Flutter for Beginners',
        'author': 'Jane Smith',
        'description':
        'A comprehensive guide to building beautiful and functional mobile applications with Flutter.',
        'cover': 'assets/book_placeholder.png',
        'genre': 'Science Fiction',
        'publicationDate': DateTime(2021, 5, 15),
        'rating': 4.0,
      },
      {
        'title': 'Mystery of the Old House',
        'author': 'Alice Johnson',
        'description':
        'A gripping mystery that keeps you on the edge of your seat until the very end.',
        'cover': 'assets/book_placeholder.png',
        'genre': 'Mystery',
        'publicationDate': DateTime(2019, 8, 20),
        'rating': 4.2,
      },
      // Add more dummy data as needed
    ];

    // Apply filters
    List<Map<String, dynamic>> filteredResults = results.where((book) {
      bool matchesGenre =
          _selectedGenre == 'All' || book['genre'] == _selectedGenre;
      bool matchesAuthor =
          _selectedAuthor == 'All' || book['author'] == _selectedAuthor;
      bool matchesDate = _selectedDateRange == null ||
          (book['publicationDate'].isAfter(_selectedDateRange!.start) &&
              book['publicationDate'].isBefore(_selectedDateRange!.end));
      bool matchesQuery = book['title']
          .toLowerCase()
          .contains(query.toLowerCase()) ||
          book['author'].toLowerCase().contains(query.toLowerCase());
      return matchesGenre && matchesAuthor && matchesDate && matchesQuery;
    }).toList();

    // Apply sorting
    filteredResults.sort((a, b) {
      switch (_sortBy) {
        case 'Title':
          return a['title'].compareTo(b['title']);
        case 'Author':
          return a['author'].compareTo(b['author']);
        case 'Publication Date':
          return a['publicationDate'].compareTo(b['publicationDate']);
        case 'Rating':
          return b['rating'].compareTo(a['rating']); // Descending order
        default:
          return 0;
      }
    });

    setState(() {
      _searchResults = filteredResults;
      _isLoading = false;
    });
  }

  // Function to reset all filters
  void _resetFilters() {
    setState(() {
      _selectedGenre = 'All';
      _selectedAuthor = 'All';
      _selectedDateRange = null;
      _sortBy = 'Title';
      _searchController.clear();
      _searchResults = [];
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Widget to build each search result item
  Widget _buildSearchResultItem(Map<String, dynamic> book) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            book['cover'],
            width: 50,
            height: 80,
            fit: BoxFit.cover,
            semanticLabel: '${book['title']} cover image',
          ),
        ),
        title: Text(
          book['title'],
          style:
          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'by ${book['author']}',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing:
        Icon(Icons.arrow_forward_ios, color: Colors.grey, semanticLabel: 'View details'),
        onTap: () {
          // Navigate to BookDetailsPage with the selected book's details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(
                title: book['title'],
                author: book['author'],
                description: book['description'],
                coverImage: book['cover'],
                genre: book['genre'],
                publicationDate: book['publicationDate'],
                rating: book['rating'],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget to build the search bar with autocomplete suggestions
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        _performSearch(value);
      },
      decoration: InputDecoration(
        hintText: "Search for books",
        prefixIcon: Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            _performSearch('');
          },
        )
            : null,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding:
        EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Widget to build filter options
  Widget _buildFilters() {
    return ExpansionTile(
      title: Text("Filters",
          style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        // Genre Filter Dropdown
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: DropdownButtonFormField<String>(
            value: _selectedGenre,
            decoration: InputDecoration(
              labelText: "Genre",
              border: OutlineInputBorder(),
            ),
            items: _genres.map((genre) {
              return DropdownMenuItem(
                value: genre,
                child: Text(genre),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGenre = value!;
              });
              _performSearch(_searchController.text);
            },
          ),
        ),
        // Author Filter Dropdown
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: DropdownButtonFormField<String>(
            value: _selectedAuthor,
            decoration: InputDecoration(
              labelText: "Author",
              border: OutlineInputBorder(),
            ),
            items: _authors.map((author) {
              return DropdownMenuItem(
                value: author,
                child: Text(author),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedAuthor = value!;
              });
              _performSearch(_searchController.text);
            },
          ),
        ),
        // Publication Date Range Picker
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () async {
              DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                initialDateRange: _selectedDateRange,
              );
              if (picked != null) {
                setState(() {
                  _selectedDateRange = picked;
                });
                _performSearch(_searchController.text);
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: _selectedDateRange == null
                      ? "Publication Date Range"
                      : "${_selectedDateRange!.start.toLocal().toShortDateString()} - ${_selectedDateRange!.end.toLocal().toShortDateString()}",
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        // Clear Filters Button
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: _resetFilters,
            child: Text("Clear Filters"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, // Replaced 'primary' with 'backgroundColor'
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  // Widget to build sort options
  Widget _buildSortOptions() {
    return ExpansionTile(
      title: Text("Sort By",
          style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: DropdownButtonFormField<String>(
            value: _sortBy,
            decoration: InputDecoration(
              labelText: "Sort By",
              border: OutlineInputBorder(),
            ),
            items: ['Title', 'Author', 'Publication Date', 'Rating']
                .map((sortOption) {
              return DropdownMenuItem(
                value: sortOption,
                child: Text(sortOption),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _sortBy = value!;
              });
              _performSearch(_searchController.text);
            },
          ),
        ),
      ],
    );
  }

  // Widget to build the search results
  Widget _buildSearchResults() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_searchResults.isEmpty) {
      return Center(
        child: Text(
          "No results found.",
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return _buildSearchResultItem(_searchResults[index]);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Books"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Optionally, expand the Filters section programmatically
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            _buildFilters(),
            SizedBox(height: 10),
            _buildSortOptions(),
            SizedBox(height: 20),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }
}

// Import the DateFormatting extension
// Already imported at the top: import 'date_formatting.dart';
