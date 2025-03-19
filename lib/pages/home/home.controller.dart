import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/helpers/api.dart';
import 'package:erpapp/models/issuelog.dart';

class HomeController extends BaseViewModel {
  List<Task> issues = [];
  List<Task> filteredIssues = [];
  String searchQuery = "";

  /// Initialize and fetch issues
  Future<void> init() async {
    await fetchIssues();
  }

  /// Fetch issues from API
  Future<void> fetchIssues() async {
    setBusy(true);
    ApiService apiService = ApiService();

    try {
      IssueLogModel? issueLogModel = await apiService.fetchIssueLogs();

      if (issueLogModel != null && issueLogModel.data.isNotEmpty) {
        issues = List<Task>.from(issueLogModel.data);
        filteredIssues = List.from(issues);
      } else {
        debugPrint("⚠️ No issue logs found.");
      }
    } catch (e) {
      debugPrint("❌ Exception in fetchIssues: $e");
    }

    setBusy(false);
    notifyListeners();
  }

  /// Update search query and filter issues
  void updateSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    filterIssues();
  }

  /// Filter issues based on priority, status, and search query
  void filterIssues({String priority = "All", String status = "All"}) {
    filteredIssues = issues.where((issue) {
      bool matchesPriority = priority == "All" ||
          issue.priority.toLowerCase() == priority.toLowerCase();
      bool matchesStatus =
          status == "All" || issue.status.toLowerCase() == status.toLowerCase();
      bool matchesSearch =
          issue.description.toLowerCase().contains(searchQuery);
      return matchesPriority && matchesStatus && matchesSearch;
    }).toList();

    notifyListeners();
  }

  /// Get color based on priority level
  Color getColorBasedOnPriority(String priority) {
    switch (priority.toLowerCase()) {
      case "low":
        return Colors.green.shade300;
      case "medium":
        return Colors.orange.shade300;
      case "high":
        return Colors.red.shade300;
      case "critical":
        return Colors.red.shade700;
      default:
        return Colors.blue.shade300;
    }
  }

  /// Show issue details and allow resolving it
  void viewIssue(BuildContext context, Task issue) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(issue.description),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Priority: ${issue.priority}"),
              Text("Status: ${issue.status}"),
              Text("Reported: ${issue.createdOn.toString()}",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
          actions: [
            if (issue.status != "Resolved")
              TextButton(
                onPressed: () {
                  issue.status = "Resolved";
                  notifyListeners();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("✅ Issue marked as Resolved!")),
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
