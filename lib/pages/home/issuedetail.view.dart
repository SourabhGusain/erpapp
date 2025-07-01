import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/pages/home/home.controller.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/models/issuelog.dart';
import 'package:intl/intl.dart';
import 'package:erpapp/widgets/form.dart';

class IssueDetailPage extends StatelessWidget {
  final issue;
  const IssueDetailPage({super.key, required this.issue});

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
              title: textH1(issue.title ?? 'Issue Details', color: whiteColor),
              backgroundColor: primaryColor,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(issue),
                    const Divider(height: 30, thickness: 1),
                    textH2(issue.description ?? "No description available",
                        font_weight: FontWeight.w400, font_size: 15),
                    const SizedBox(height: 20),
                    _buildIssueDetails(issue, model),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(issue) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: textH1(
            (issue.title?.isNotEmpty ?? false)
                ? issue.title![0].toUpperCase()
                : "?",
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textH1(issue.title ?? "Unknown Issue"),
              const SizedBox(height: 4),
              subtext(
                "Reported on: ${issue.createdOn != null ? DateFormat('yyyy-MM-dd HH:mm').format(issue.createdOn!) : 'Unknown'}",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIssueDetails(issue, HomeController model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          icon: Icons.priority_high,
          text: "Priority: ${issue.priority?.toUpperCase() ?? 'Low'}",
          color: model.getColorBasedOnPriority(issue.priority ?? "low"),
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
          icon: Icons.flag,
          text: "Status: ${_formatStatus(issue.status)}",
          color: Colors.blueGrey,
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(width: 10),
        textH2(text, color: color),
      ],
    );
  }

  String _formatStatus(String? status) {
    switch (status) {
      case "in_progress":
        return "In Progress";
      case "resolved":
        return "Resolved";
      case "open":
        return "Open";
      default:
        return "Unknown";
    }
  }
}
