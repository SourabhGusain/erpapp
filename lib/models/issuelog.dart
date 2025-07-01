import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/session.dart';

class IssueLogModel {
  final List<Task> tasks;

  IssueLogModel({required this.tasks});

  factory IssueLogModel.fromJson(Map<String, dynamic> json) => IssueLogModel(
        tasks: (json['data'] as List?)?.map((e) => Task.fromJson(e)).toList() ??
            [],
      );
}

class Task {
  final int id;
  final String title, description, priority;
  String status;
  final DateTime createdOn;
  final int project, reportedBy;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.createdOn,
    required this.project,
    required this.reportedBy,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] ?? 0,
        title: json['title'] ?? 'No Title',
        description: json['description'] ?? 'No Description',
        status: json['status'] ?? 'unknown',
        priority: json['priority'] ?? 'low',
        createdOn:
            DateTime.tryParse(json['created_on'] ?? '') ?? DateTime(1970),
        project: json['project'] ?? 0,
        reportedBy: json['reported_by'] ?? 0,
      );
}

class ApiService {
  final String baseUrl = "$api_url/projects/issuelogs/";

  Future<List<Task>> fetchIssueLogs() async {
    try {
      final sessionData = await Session().getSession("usersession");
      if (sessionData == null || sessionData.isEmpty) {
        throw 'Missing session data';
      }

      final token = jsonDecode(sessionData)["token"];
      if (token == null || token.isEmpty) throw 'Missing authentication token';
      print(token);

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Token $token",
          "Content-Type": "application/json"
        },
      );
      print(response);

      if (response.statusCode == 200) {
        return IssueLogModel.fromJson(json.decode(response.body)).tasks;
      } else {
        throw 'API Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      print('❌ Error: $e');
      return [];
    }
  }
}

void main() async {
  final tasks = await ApiService().fetchIssueLogs();
  tasks.isNotEmpty
      ? tasks.forEach((task) => print(
          '🔹 Task ID: ${task.id}, 📌 Title: ${task.title}, 🟡 Status: ${task.status}'))
      : print('🚫 No issue logs found.');
}
