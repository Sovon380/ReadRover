import 'package:flutter/material.dart';

class LocationsPage extends StatelessWidget {
  // Sample static data for library locations
  final List<Map<String, String>> _libraryLocations = [
    {
      "name": "New York Public Library",
      "description": "Main branch in Midtown Manhattan, NYC",
      "address": "476 5th Ave, New York, NY 10018"
    },
    {
      "name": "Los Angeles Public Library",
      "description": "Located in the heart of downtown LA",
      "address": "630 W 5th St, Los Angeles, CA 90071"
    },
    {
      "name": "Chicago Public Library",
      "description": "Main branch with extensive archives",
      "address": "400 S State St, Chicago, IL 60605"
    },
    {
      "name": "Boston Public Library",
      "description": "Historic library in Copley Square",
      "address": "700 Boylston St, Boston, MA 02116"
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
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blueAccent, size: 30),
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
                  Text(
                    location["description"]!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    location["address"]!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
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
