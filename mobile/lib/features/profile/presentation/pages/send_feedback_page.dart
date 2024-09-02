import 'package:flutter/material.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<SendFeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.waving_hand,
                  color: Colors.orange,
                  size: 30,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Hi there, you can easily share your thoughts, ideas, and any issues you\'ve encountered.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Feedback",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: TextField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                  hintText: 'Write your feedback here...',
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  // Handle feedback submission
                  if (_feedbackController.text.isNotEmpty) {
                    // Example submission
                    print("Feedback sent: ${_feedbackController.text}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Thank you for your feedback!')),
                    );
                    _feedbackController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter some feedback.')),
                    );
                  }
                },
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
