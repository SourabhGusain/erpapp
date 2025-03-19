import 'package:flutter/material.dart';
import 'package:erpapp/pages/home/home.controller.dart';
import 'package:erpapp/pages/home/issuedetail.view.dart';
import 'package:erpapp/pages/login/login.view.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/widgets/form.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
      onViewModelReady: (controller) {
        controller.init();
      },
      builder: (context, ctrl, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: textH1('Issue Log', color: whiteColor),
              backgroundColor: primaryColor,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(LucideIcons.logOut, color: Colors.white),
                  onPressed: () {
                    Get.toWithNoBack(context, () => const LoginPage());
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  searchBar(ctrl),
                  const SizedBox(height: 15),
                  filterSection(ctrl),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 5),
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
    );
  }

  Widget searchBar(HomeController ctrl) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search issues...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: ctrl.updateSearchQuery,
    );
  }

  Widget filterSection(HomeController ctrl) {
    return Row(
      children: [
        Expanded(
          child: filterButton(
            text: "Priority: $selectedPriority",
            icon: Icons.flag,
            onPressed: () => _showPriorityBottomSheet(ctrl),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: filterButton(
            text: "Status: $selectedStatus",
            icon: Icons.check_circle_outline,
            onPressed: () => _showStatusBottomSheet(ctrl),
          ),
        ),
      ],
    );
  }

  Widget filterButton(
      {required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text),
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
    _showBottomSheet(
      title: "Select Priority",
      options: ['All', 'Low', 'Medium', 'High', 'Critical'],
      selectedValue: selectedPriority,
      onSelected: (value) {
        setState(() {
          selectedPriority = value;
          ctrl.filterIssues(priority: selectedPriority, status: selectedStatus);
        });
      },
    );
  }

  void _showStatusBottomSheet(HomeController ctrl) {
    _showBottomSheet(
      title: "Select Status",
      options: ['All', 'Open', 'In Progress', 'Resolved', 'Closed'],
      selectedValue: selectedStatus,
      onSelected: (value) {
        setState(() {
          selectedStatus = value;
          ctrl.filterIssues(priority: selectedPriority, status: selectedStatus);
        });
      },
    );
  }

  void _showBottomSheet({
    required String title,
    required List<String> options,
    required String selectedValue,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...options.map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: option == selectedValue
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget listViewBuilder(HomeController ctrl) {
    return ListView.builder(
      itemCount: ctrl.filteredIssues.length,
      itemBuilder: (context, index) {
        final issue = ctrl.filteredIssues[index];
        return issueCard(issue);
      },
    );
  }

  Widget issueCard(issue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IssueDetailPage(issue: issue),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    issue.title[0].toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        issue.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        issue.shortDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  issue.timestamp,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
