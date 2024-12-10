// lib/book_details_page.dart

import 'package:flutter/material.dart';
import 'date_formatting.dart'; // Import the DateFormatting extension

class BookDetailsPage extends StatelessWidget {
  final String? title;
  final String? author;
  final String? description;
  final String? coverImage;
  final String? genre;
  final DateTime? publicationDate;
  final double? rating;

  // Constructor with named optional parameters
  BookDetailsPage({
    this.title,
    this.author,
    this.description,
    this.coverImage,
    this.genre,
    this.publicationDate,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? "Book Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Book Cover Image
              Center(
                child: coverImage != null
                    ? Container(
                  width: 150,
                  height: 220,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(coverImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(
                  width: 150,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.book,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Book Title and Author
              Text(
                title ?? "To Kill a Mockingbird",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                author != null ? "by $author" : "Harper Lee",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),

              // Book Information Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoColumn(Icons.category, "Genre", genre ?? "Fiction"),
                  _buildInfoColumn(
                      Icons.calendar_today,
                      "Published",
                      publicationDate != null
                          ? publicationDate!.toLocal().toShortDateString()
                          : "January, 2020"),
                  _buildInfoColumn(
                      Icons.star, "Rating", rating != null ? rating.toString() : "4.6"),
                ],
              ),
              SizedBox(height: 20),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add to Wishlist logic
                    },
                    icon: Icon(Icons.favorite_border),
                    label: Text("Wishlist"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent, // Replaced 'primary' with 'backgroundColor'
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Share logic
                    },
                    icon: Icon(Icons.share),
                    label: Text("Share"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent, // Replaced 'primary' with 'backgroundColor'
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Buy Now logic
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text("Buy Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Replaced 'primary' with 'backgroundColor'
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Description Section with Expand/Collapse
              ExpansionTile(
                title: Text(
                  "Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description ?? "No Description Available.",
                      style:
                      TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Reviews Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Reviews",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              _buildReview(
                userName: "Tamjid",
                userAvatar:
                'assets/user_placeholder.jpeg', // Ensure this asset exists
                userRating: 5.0,
                comment: "An exhilarating read! Couldn't put it down.",
              ),
              SizedBox(height: 10),
              _buildReview(
                userName: "Sudipta",
                userAvatar: 'assets/user_placeholder.jpeg',
                userRating: 4.0,
                comment: "Great story with well-developed characters.",
              ),
              SizedBox(height: 10),
              _buildReview(
                userName: "Roshid",
                userAvatar: 'assets/user_placeholder.jpeg',
                userRating: 4.5,
                comment: "Loved the world-building and the plot twists.",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build information columns
  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 28),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Helper method to build individual reviews
  Widget _buildReview({
    required String userName,
    required String userAvatar,
    required double userRating,
    required String comment,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Avatar
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(userAvatar),
          backgroundColor: Colors.blueGrey.shade200,
        ),
        SizedBox(width: 10),
        // Review Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Name and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userName,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < userRating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 5),
              // Comment
              Text(
                comment,
                style:
                TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Import the DateFormatting extension
// Already imported at the top: import 'date_formatting.dart';

