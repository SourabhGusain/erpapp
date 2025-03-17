import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/pages/home/home.controller.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/widgets/form.dart';

class IssueDetailPage extends StatelessWidget {
  final Issue issue;

  const IssueDetailPage({Key? key, required this.issue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeController>.reactive(
      viewModelBuilder: () => HomeController(),
      onModelReady: (model) {
        model.issues = [
          Issue(
            title: "Login Failure",
            description:
                "Users cannot log in with correct credentials. This issue has been reported multiple times, and it seems to affect all user roles. Troubleshooting steps include checking network settings and verifying backend authentication logs.",
            timestamp: "Mar 17, 2025",
            priority: "High",
            status: "Open",
            isResolved: false,
          ),
          Issue(
            title: "UI Glitch on Dashboard",
            description:
                "Some elements overlap on smaller screens, causing usability issues. Users have reported difficulties in accessing menu options, especially on mobile devices. A responsive design fix is required to ensure smooth navigation.",
            timestamp: "Mar 16, 2025",
            priority: "Medium",
            status: "In Progress",
            isResolved: false,
          ),
          Issue(
            title: "Payment Gateway Error",
            description:
                "Transactions fail intermittently, leading to incomplete orders and frustrated customers. The error appears to be caused by inconsistent API responses from the payment provider. Debugging logs indicate potential timeout issues.",
            timestamp: "Mar 15, 2025",
            priority: "Critical",
            status: "Open",
            isResolved: false,
          ),
        ];
        model.notifyListeners();
      },
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: whiteColor),
                onPressed: () => Navigator.pop(context),
              ),
              title: textH1(issue.title, color: whiteColor),
              backgroundColor: primaryColor,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textH1("Description", font_size: 24, color: Colors.black87),
                  SizedBox(height: 8),
                  textH2(issue.description,
                      font_size: 18, color: Colors.black54),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.priority_high,
                          size: 28,
                          color: model.getColorBasedOnPriority(issue.priority)),
                      SizedBox(width: 10),
                      textH2("Priority: ${issue.priority}",
                          font_size: 18,
                          color: model.getColorBasedOnPriority(issue.priority)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.flag, size: 28, color: Colors.blueGrey),
                      SizedBox(width: 10),
                      textH2("Status: ${issue.status}", font_size: 18),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 28, color: Colors.grey),
                      SizedBox(width: 10),
                      subtext("Reported on: ${issue.timestamp}",
                          font_size: 16, color: Colors.grey.shade700),
                    ],
                  ),
                  Spacer(),
                  if (!issue.isResolved)
                    Center(
                      child: darkButton(
                        textH2("Mark as Resolved",
                            font_size: 18, color: whiteColor),
                        primary: Colors.green,
                        onPressed: () => model.viewIssue(context, issue),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
