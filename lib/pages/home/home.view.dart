import 'package:flutter/material.dart';
import 'package:erpapp/pages/home/home.controller.dart';
import 'package:erpapp/pages/home/issuedetail.view.dart';
import 'package:erpapp/pages/login/login.view.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/widgets/form.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/widgets.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:erpapp/models/issuelog.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:secure_application/secure_application.dart';
import 'package:erpapp/pages/manage/manage.view.dart';

class HomePage extends StatefulWidget {
  final Session session;
  const HomePage({super.key, required this.session});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedPriority = 'All';
  String selectedStatus = 'All';
  TextEditingController searchController = TextEditingController();

  final SecureApplicationController _secureController =
      SecureApplicationController(SecureApplicationState());

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final SecureApplicationController secureController =
        SecureApplicationController(SecureApplicationState());

    return SecureApplication(
      child: SecureApplicationProvider(
        child: ViewModelBuilder<HomeController>.reactive(
          viewModelBuilder: () => HomeController(),
          onViewModelReady: (controller) {
            controller.init();
            secureController.unlock();
          },
          builder: (context, ctrl, child) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: textH1('Corrttech Solutions (Issue Logs)',
                      font_size: 19, color: whiteColor),
                  backgroundColor: primaryColor,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: const Icon(LucideIcons.logOut, color: Colors.white),
                      onPressed: () async {
                        await widget.session.removeSession('loggedInUserKey');
                        await widget.session.removeSession('loggedInUser');
                        Get.toWithNoBack(
                            context, () => LoginPage(session: widget.session));
                      },
                    ),
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: Padding(
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
                bottomNavigationBar: bottomBar(
                  selectedIndex,
                  (index) {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(session: widget.session),
                          ),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ManagePage(session: widget.session),
                          ),
                        );
                        break;
                      default:
                        break;
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget searchBar(HomeController ctrl) {
    return textField(
      "Search issues...",
      controller: searchController,
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

  Widget listViewBuilder(HomeController ctrl) {
    return ListView.builder(
      itemCount: ctrl.filteredIssues.length,
      itemBuilder: (context, index) {
        final issue = ctrl.filteredIssues[index];
        return issueCard(issue);
      },
    );
  }

  Widget issueCard(Task issue) {
    return Card(
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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                child: textH1(
                  issue.title.isNotEmpty ? issue.title[0].toUpperCase() : "?",
                  color: whiteColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textH2(
                          issue.title.length > 25
                              ? "${issue.title.substring(0, 25)}..."
                              : issue.title,
                          font_size: 12,
                        ),
                        const SizedBox(width: 8),
                        subtext(
                            DateFormat('yyyy-MM-dd').format(issue.createdOn),
                            font_size: 11,
                            color: const Color.fromARGB(255, 78, 78, 78)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    subtext(
                        issue.description.length > 65
                            ? "${issue.description.substring(0, 70)}..."
                            : issue.description,
                        maxLines: 2,
                        font_size: 12,
                        color: blackColor,
                        font_weight: FontWeight.w400),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  Widget filterButton(
      {required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: textH3(text),
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
      child: textH2(message, color: Colors.grey),
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
      options: ['All', 'Open', 'In_Progress', 'Resolved', 'Closed'],
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
              }),
            ],
          ),
        );
      },
    );
  }
}
