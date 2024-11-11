import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Wrap the fields with a Form widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We value your feedback!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Name Field
              Text("Name"),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null; // Valid input
                },
              ),
              SizedBox(height: 16),

              // Email Field
              Text("Email"),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your email",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Basic email validation
                  String pattern = r'^[^@]+@[^@]+\.[^@]+';
                  RegExp regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null; // Valid input
                },
              ),
              SizedBox(height: 16),

              // Message Field
              Text("Message"),
              TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your feedback or issue",
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null; // Valid input
                },
              ),
              SizedBox(height: 16),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate the form
                    if (_formKey.currentState!.validate()) {
                      _submitFeedback();
                    }
                  },
                  child: Text("Submit Feedback"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitFeedback() {
    // Here, you can implement the logic to send feedback, such as:
    String name = nameController.text;
    String email = emailController.text;
    String message = messageController.text;

    // For now, you can just print to the console
    print("Name: $name");
    print("Email: $email");
    print("Message: $message");

    // Clear the fields after submission
    nameController.clear();
    emailController.clear();
    messageController.clear();

    // Show a confirmation message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Feedback submitted! Thank you!")),
    );
  }
}
