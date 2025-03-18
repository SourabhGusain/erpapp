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
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: whiteColor),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                issue.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: whiteColor),
              ),
              backgroundColor: primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(issue.title[0].toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              issue.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Reported on: ${issue.timestamp}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30, thickness: 1),
                  Text(
                    issue.longDescription,
                    style: const TextStyle(
                        fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.priority_high,
                        size: 24,
                        color: model.getColorBasedOnPriority(issue.priority),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Priority: ${issue.priority}",
                        style: TextStyle(
                          fontSize: 16,
                          color: model.getColorBasedOnPriority(issue.priority),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.flag, size: 24, color: Colors.blueGrey),
                      const SizedBox(width: 10),
                      Text(
                        "Status: ${issue.status}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (!issue.isResolved)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => model.viewIssue(context, issue),
                        child: const Text(
                          "Mark as Resolved",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
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
