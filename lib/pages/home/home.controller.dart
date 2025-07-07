import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/models/issuelog.dart';

class HomeController extends BaseViewModel {
  List<Task> issues = [];
  List<Task> filteredIssues = [];
  String searchQuery = "";

  Future<void> init() async {
    await fetchIssues();
  }

  Future<void> fetchIssues() async {
    setBusy(true);
    try {
      ApiService apiService = ApiService();
      List<Task> fetchedIssues = await apiService.fetchIssueLogs();

      if (fetchedIssues.isNotEmpty) {
        issues = fetchedIssues;
        filterIssues(); // Auto-filter on fetch
      } else {
        debugPrint("⚠️ No issues found.");
        issues.clear();
        filteredIssues.clear();
      }
    } catch (e) {
      debugPrint("❌ Error fetching issues: $e");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query.trim().toLowerCase();
    filterIssues();
  }

  filterIssues({String priority = "All", String status = "All"}) {
    print("Filtering issues with:");
    print("Priority: $priority");
    print("Status: $status");
    print("Search Query: $searchQuery");

    filteredIssues = issues.where((issue) {
      bool matchesPriority = priority == "All" ||
          issue.priority.toLowerCase() == priority.toLowerCase();
      bool matchesStatus =
          status == "All" || issue.status.toLowerCase() == status.toLowerCase();
      bool matchesSearch = searchQuery.isEmpty ||
          issue.description.toLowerCase().contains(searchQuery);

      return matchesPriority && matchesStatus && matchesSearch;
    }).toList();

    print("Filtered Issues Count: ${filteredIssues.length}");

    notifyListeners();
  }

  Color getColorBasedOnPriority(String priority) {
    return {
          "low": Colors.green.shade300,
          "medium": Colors.orange.shade300,
          "high": Colors.red.shade300,
          "critical": Colors.red.shade700,
        }[priority.toLowerCase()] ??
        Colors.blue.shade300;
  }

  /// Mark issue as resolved
  void markIssueResolved(Task issue) {
    issue.status = "Resolved";
    notifyListeners();
  }
}
