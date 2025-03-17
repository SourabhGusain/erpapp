import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Issue {
  final String title;
  final String description;
  final String timestamp;
  bool isResolved;

  Issue({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isResolved,
  });
}

class HomeController extends BaseViewModel {
  List<Issue> issues = [
    Issue(
      title: "App Crash on Login",
      description: "The app crashes when attempting to log in with an invalid password.",
      timestamp: "Mar 16, 2025",
      isResolved: false,
    ),
    Issue(
      title: "UI Bug in Dark Mode",
      description: "Some text is not visible properly in dark mode.",
      timestamp: "Mar 15, 2025",
      isResolved: true,
    ),
  ];

  void init() {}

  void addIssue(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New Issue"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                  issues.add(
                    Issue(
                      title: titleController.text,
                      description: descriptionController.text,
                      timestamp: "Mar 16, 2025", // Ideally, get current date dynamically
                      isResolved: false,
                    ),
                  );
                  notifyListeners();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Issue added successfully!")),
                  );
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void viewIssue(BuildContext context, Issue issue) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(issue.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(issue.description),
              const SizedBox(height: 10),
              Text(
                "Reported on: ${issue.timestamp}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            if (!issue.isResolved)
              TextButton(
                onPressed: () {
                  issue.isResolved = true;
                  notifyListeners();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Issue marked as Resolved!")),
                  );
                },
                child: const Text("Mark as Resolved"),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
