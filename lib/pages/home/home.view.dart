import 'package:flutter/material.dart';
import 'package:erpapp/pages/home/home.controller.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/widgets/form.dart';
import 'package:erpapp/widgets/form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeController>.reactive(
      viewModelBuilder: () => HomeController(),
      builder: (context, ctrl, child) {
        return Scaffold(
          appBar: AppBar(
            title: textH1('Issue Log'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // showSearch(
                  //   context: context,
                  //   delegate: IssueSearchDelegate(ctrl),
                  // );
                },
              ),
            ],
          ),
          body: ctrl.issues.isEmpty
              ? emptyState('No issues logged yet')
              : listViewBuilder(ctrl),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => ctrl.addIssue(context),
            icon: const Icon(Icons.add),
            label: const Text("New Issue"),
            backgroundColor: Colors.blueAccent,
          ),
        );
      },
      onViewModelReady: (controller) {
        controller.init();
      },
    );
  }

  Widget textH1(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Widget emptyState(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget listViewBuilder(HomeController ctrl) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: ctrl.issues.length,
        itemBuilder: (context, index) {
          final issue = ctrl.issues[index];
          return issueCard(issue, ctrl, context);
        },
      ),
    );
  }

  Widget issueCard(issue, HomeController ctrl, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(
          issue.isResolved ? Icons.check_circle : Icons.warning_amber,
          color: issue.isResolved ? Colors.green : Colors.red,
          size: 32,
        ),
        title: Text(
          issue.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            issue.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        trailing: statusIndicator(issue),
        onTap: () => ctrl.viewIssue(context, issue),
      ),
    );
  }

  Widget statusIndicator(issue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          issue.timestamp,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: issue.isResolved
                ? Colors.green.withOpacity(0.2)
                : Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            issue.isResolved ? 'Resolved' : 'Pending',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: issue.isResolved ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
