import 'package:flutter/material.dart';
import 'package:erpapp/pages/home/home.controller.dart';
import 'package:erpapp/pages/home/issuedetail.view.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/widgets/form.dart';
import 'package:erpapp/helpers/values.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedPriority = 'All';
  String selectedStatus = 'All';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeController>.reactive(
      viewModelBuilder: () => HomeController(),
      builder: (context, ctrl, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: textH1('Issue Log', color: whiteColor),
              backgroundColor: primaryColor,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  searchBar(ctrl),
                  const SizedBox(height: 15),
                  filterSection(ctrl),
                  const SizedBox(height: 15),
                  Divider(),
                  Expanded(
                    child: ctrl.filteredIssues.isEmpty
                        ? emptyState('No issues logged yet')
                        : listViewBuilder(ctrl),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      onViewModelReady: (controller) {
        controller.init();
      },
    );
  }

  Widget searchBar(HomeController ctrl) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search issues...",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: (query) {
        ctrl.updateSearchQuery(query);
      },
    );
  }

  Widget filterSection(HomeController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _showPriorityBottomSheet(ctrl),
                icon: const Icon(Icons.flag, size: 20),
                label: Text("Priority: $selectedPriority"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: blackColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: primaryColor),
                  ),
                  elevation: 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _showStatusBottomSheet(ctrl),
                icon: const Icon(Icons.check_circle_outline, size: 20),
                label: Text("Status: $selectedStatus"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: blackColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: primaryColor),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ],
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

  void _showPriorityBottomSheet(HomeController ctrl) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _buildBottomSheet(
          title: "Select Priority",
          options: ['All', 'Low', 'Medium', 'High', 'Critical'],
          selectedValue: selectedPriority,
          onSelected: (value) {
            setState(() {
              selectedPriority = value;
              ctrl.filterIssues(
                  priority: selectedPriority, status: selectedStatus);
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showStatusBottomSheet(HomeController ctrl) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _buildBottomSheet(
          title: "Select Status",
          options: ['All', 'Open', 'In Progress', 'Resolved', 'Closed'],
          selectedValue: selectedStatus,
          onSelected: (value) {
            setState(() {
              selectedStatus = value;
              ctrl.filterIssues(
                  priority: selectedPriority, status: selectedStatus);
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget _buildBottomSheet({
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Column(
            children: options.map((option) {
              return ListTile(
                title: Text(option),
                trailing: option == selectedValue
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () => onSelected(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget listViewBuilder(HomeController ctrl) {
    return ListView.builder(
      itemCount: ctrl.filteredIssues.length,
      itemBuilder: (context, index) {
        final issue = ctrl.filteredIssues[index];
        return issueCard(issue, context);
      },
    );
  }

  Widget issueCard(Issue issue, BuildContext context) {
    Color cardColor = primaryColor.withOpacity(0.8);
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          issue.isResolved ? Icons.check_circle : Icons.warning_amber,
          color: Colors.white,
          size: 36,
        ),
        title: Text(
          issue.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            issue.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IssueDetailPage(issue: issue),
            ),
          );
        },
      ),
    );
  }
}
