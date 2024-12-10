// lib/locations_page.dart

import 'package:flutter/material.dart';
import 'location_detail_page.dart';

class LocationsPage extends StatelessWidget {
  // Sample static data for library locations in Dhaka, Bangladesh
  final List<Map<String, String>> _libraryLocations = [
    {
      "name": "National Library of Bangladesh",
      "description": "The largest library in Bangladesh with extensive collections.",
      "address": "Mirpur-2, Dhaka 1216, Bangladesh",
      "image": "assets/boston_public_library.jpeg"
    },
    {
      "name": "Central Public Library",
      "description": "A prominent public library located in the heart of Dhaka.",
      "address": "Gulshan Avenue, Gulshan-1, Dhaka 1212, Bangladesh",
      "image": "assets/chicago_public_library.jpeg"
    },
    {
      "name": "American International Public Library",
      "description": "Offers a wide range of books and resources for the community.",
      "address": "Banani, Dhaka 1213, Bangladesh",
      "image": "assets/la_public_library.jpeg"
    },
    {
      "name": "British Council Library",
      "description": "Provides access to a vast collection of English literature and resources.",
      "address": "House 38, Road 12, Block C, Banani, Dhaka 1213, Bangladesh",
      "image": "assets/ny_public_library.jpeg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library Locations"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _libraryLocations.length,
        itemBuilder: (context, index) {
          final location = _libraryLocations[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Column(
              children: [
                // Location Image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    location["image"]!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location Header with Icon and Name
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.blueAccent, size: 30),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              location["name"]!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Location Description
                      Text(
                        location["description"]!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 6),
                      // Location Address
                      Text(
                        location["address"]!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      SizedBox(height: 20),
                      // "View Location" Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationDetailPage(
                                  name: location["name"]!,
                                  description: location["description"]!,
                                  address: location["address"]!,
                                  image: location["image"]!,
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.map),
                          label: Text("View Location"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.blueAccent, // Updated from 'primary'
                            foregroundColor:
                            Colors.white, // Updated from 'onPrimary'
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
