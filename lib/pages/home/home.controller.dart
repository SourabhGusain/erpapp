import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Issue {
  final String title;
  final String shortDescription;
  final String longDescription;
  final String timestamp;
  final String priority;
  String status;
  bool isResolved;

  Issue({
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.timestamp,
    required this.priority,
    required this.status,
    required this.isResolved,
  });
}

class HomeController extends BaseViewModel {
  List<Issue> issues = [
    Issue(
      title: "Authentication Error",
      shortDescription: "Users unable to log in with correct credentials.",
      longDescription:
          "Many users have reported that they are unable to log in despite entering the correct credentials. This issue appears to be affecting multiple accounts across different regions. We suspect a backend authentication failure or an expired token issue that needs further investigation.",
      timestamp: "10:45 AM",
      priority: "High",
      status: "Open",
      isResolved: false,
    ),
    Issue(
      title: "UI Overlap in Dark Mode",
      shortDescription: "Some text elements overlap in dark mode view.",
      longDescription:
          "In dark mode, some text elements are overlapping with icons, making it difficult to read. This issue occurs particularly in the settings and notification sections, causing usability challenges. A CSS or Flutter UI fix is required to address the problem.",
      timestamp: "Yesterday",
      priority: "Medium",
      status: "In Progress",
      isResolved: false,
    ),
    Issue(
      title: "App Freezing Issue",
      shortDescription: "App freezes when switching between tabs rapidly.",
      longDescription:
          "Users have reported that when they quickly switch between tabs, the app becomes unresponsive for several seconds. This issue is more frequent on older devices with less memory. A memory management optimization might be needed to improve performance.",
      timestamp: "Mar 16",
      priority: "Critical",
      status: "Open",
      isResolved: false,
    ),
    Issue(
      title: "Notification Delay",
      shortDescription: "Push notifications are delayed by 5-10 minutes.",
      longDescription:
          "Push notifications for new messages and alerts are getting delayed by 5 to 10 minutes. The issue seems to be intermittent and may be related to the background refresh settings. Logs indicate a delay in fetching notification data from the server.",
      timestamp: "Mar 14",
      priority: "Low",
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
          issue.shortDescription.toLowerCase().contains(searchQuery);
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
              Text(issue.longDescription),
              const SizedBox(height: 10),
              Text("Priority: ${issue.priority}"),
              Text("Status: ${issue.status}"),
              Text("Reported: ${issue.timestamp}",
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
