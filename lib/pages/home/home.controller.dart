import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Issue {
  final String title;
  final String description;
  final String timestamp;
  final String priority;
  String status;
  bool isResolved;

  Issue({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.priority,
    required this.status,
    required this.isResolved,
  });
}

class HomeController extends BaseViewModel {
  List<Issue> issues = [
    Issue(
      title: "Login Page Crash",
      description: "App crashes when wrong credentials are entered.",
      timestamp: "Mar 16, 2025",
      priority: "High",
      status: "Open",
      isResolved: false,
    ),
    Issue(
      title: "Dark Mode UI Glitch",
      description: "Text is unreadable in some sections.",
      timestamp: "Mar 15, 2025",
      priority: "Medium",
      status: "In Progress",
      isResolved: false,
    ),
    Issue(
      title: "Slow Performance on Dashboard",
      description: "Dashboard takes too long to load statistics.",
      timestamp: "Mar 14, 2025",
      priority: "Critical",
      status: "Resolved",
      isResolved: true,
    ),
  ];

  List<Issue> filteredIssues = [];
  String searchQuery = "";

  void init() {
    filteredIssues = List.from(issues);
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    filterIssues();
  }

  void filterIssues({String priority = "All", String status = "All"}) {
    filteredIssues = issues.where((issue) {
      bool matchesPriority = priority == "All" || issue.priority == priority;
      bool matchesStatus = status == "All" || issue.status == status;
      bool matchesSearch = issue.title.toLowerCase().contains(searchQuery) ||
          issue.description.toLowerCase().contains(searchQuery);
      return matchesPriority && matchesStatus && matchesSearch;
    }).toList();
    notifyListeners();
  }

  Color getColorBasedOnPriority(String priority) {
    switch (priority) {
      case "Low":
        return Colors.green.shade300;
      case "Medium":
        return Colors.orange.shade300;
      case "High":
        return Colors.red.shade300;
      case "Critical":
        return Colors.red.shade700;
      default:
        return Colors.blue.shade300;
    }
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
              Text("Priority: ${issue.priority}"),
              Text("Status: ${issue.status}"),
              Text("Reported on: ${issue.timestamp}",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          actions: [
            if (!issue.isResolved)
              TextButton(
                onPressed: () {
                  issue.isResolved = true;
                  issue.status = "Resolved";
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
