// lib/events_news_page.dart

import 'package:flutter/material.dart';

class Event {
  final String title;
  final String date;
  final String description;
  final String location;
  final String image;
  bool isRSVPed;

  Event({
    required this.title,
    required this.date,
    required this.description,
    required this.location,
    required this.image,
    this.isRSVPed = false,
  });
}

class EventsNewsPage extends StatefulWidget {
  @override
  _EventsNewsPageState createState() => _EventsNewsPageState();
}

class _EventsNewsPageState extends State<EventsNewsPage> {
  List<Event> events = [
    Event(
      title: "Author Talk: J.K. Rowling",
      date: "2024-05-15",
      description:
      "Join us for an exclusive author talk with J.K. Rowling, where she'll discuss her latest works and inspirations.",
      location: "Main Hall, Central Library",
      image: "assets/jk_rowling_talk.jpeg",
    ),
    Event(
      title: "Library Workshop on Fiction Writing",
      date: "2024-06-01",
      description:
      "Enhance your fiction writing skills with our hands-on workshop led by experienced authors.",
      location: "Workshop Room A",
      image: "assets/fiction_workshop.jpeg",
    ),
    // Add more events as needed
  ];

  List<Event> filteredEvents = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredEvents = events;
  }

  void _filterEvents(String query) {
    List<Event> results = [];
    if (query.isEmpty) {
      results = events;
    } else {
      results = events
          .where((event) =>
      event.title.toLowerCase().contains(query.toLowerCase()) ||
          event.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      searchQuery = query;
      filteredEvents = results;
    });
  }

  Future<void> _refreshEvents() async {
    // Simulate a network call or database fetch
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // For demonstration, we'll just reverse the list
      events = events.reversed.toList();
      _filterEvents(searchQuery);
    });
  }

  void _toggleRSVP(int index) {
    setState(() {
      filteredEvents[index].isRSVPed = !filteredEvents[index].isRSVPed;
    });
  }

  void _removeEvent(int index) {
    setState(() {
      events.remove(filteredEvents[index]);
      _filterEvents(searchQuery);
    });
  }

  String _formatDate(String dateStr) {
    // Simple date formatting without intl
    DateTime date = DateTime.parse(dateStr);
    return "${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}";
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  void _addNewEvent() {
    // Implement functionality to add a new event
    // For demonstration, we'll add a dummy event
    setState(() {
      events.add(
        Event(
          title: "New Event ${events.length + 1}",
          date: "2024-07-0${events.length + 1}",
          description: "Description for New Event ${events.length + 1}. This is a placeholder event.",
          location: "Venue ${events.length + 1}",
          image: "assets/default_event.jpeg", // Ensure this image exists
        ),
      );
      _filterEvents(searchQuery);
    });
  }

  void _navigateToDetail(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailPage(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events & News"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              setState(() {
                events.sort((a, b) => b.date.compareTo(a.date));
                _filterEvents(searchQuery);
              });
            },
            tooltip: "Sort by Date",
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshEvents,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by title or location",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onChanged: _filterEvents,
              ),
            ),
            Expanded(
              child: filteredEvents.isEmpty
                  ? Center(
                child: Text(
                  "No events found.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  return Dismissible(
                    key: Key(event.title + event.date),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.redAccent,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _removeEvent(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${event.title} removed."),
                        ),
                      );
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
                            event.image,
                            width: 60,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 80,
                                color: Colors.grey,
                                child: Icon(Icons.event, color: Colors.white),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Location: ${event.location}\nDate: ${_formatDate(event.date)}",
                        ),
                        isThreeLine: true,
                        trailing: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                event.isRSVPed
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: event.isRSVPed
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                _toggleRSVP(index);
                              },
                              tooltip: event.isRSVPed
                                  ? "Cancel RSVP"
                                  : "RSVP",
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _navigateToDetail(event);
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
                          _navigateToDetail(event);
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
        onPressed: _addNewEvent,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        tooltip: "Add Event",
      ),
    );
  }
}

class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({required this.event});

  String _formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return "${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)}";
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Event Image
            Image.asset(
              event.image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey,
                  child: Icon(Icons.event, color: Colors.white, size: 100),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Title
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Event Description
                  Text(
                    event.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Event Location
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          event.location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Event Date
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text(
                        _formatDate(event.date),
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
                          // Implement navigation to map or other actions
                          // For example, integrate with a map widget or open in-app map
                        },
                        icon: Icon(Icons.map),
                        label: Text("View on Map"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement RSVP or other actions
                        },
                        icon: Icon(Icons.directions),
                        label: Text("Get Directions"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Additional Information
                  Text(
                    "Join us for an engaging session with ${event.title.split(':')[0]}. Don't miss out on this opportunity to interact and learn more about the event.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
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
