import 'dart:convert';
import 'package:http/http.dart' as http;

class IssueLogModel {
  final int ok;
  final String message;
  final String error;
  final List<Task> data;

  IssueLogModel({
    required this.ok,
    required this.message,
    required this.error,
    required this.data,
  });

  factory IssueLogModel.fromJson(Map<String, dynamic> json) {
    return IssueLogModel(
      ok: json['ok'] ?? 0,
      message: json['message'] ?? '',
      error: json['error'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Task.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class Task {
  final int id;
  final String description;
  String status;
  final String priority;
  final DateTime createdOn;
  final int project;
  final int reportedBy;

  Task({
    required this.id,
    required this.description,
    required this.status,
    required this.priority,
    required this.createdOn,
    required this.project,
    required this.reportedBy,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 0,
      description: json['description'] ?? 'No Description',
      status: json['status'] ?? 'unknown',
      priority: json['priority'] ?? 'low',
      createdOn: DateTime.tryParse(json['created_on'] ?? '') ?? DateTime(1970),
      project: json['project'] ?? 0,
      reportedBy: json['reported_by'] ?? 0,
    );
  }
}

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api/projects/issuelogs/";

  Future<IssueLogModel?> fetchIssueLogs() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        return IssueLogModel.fromJson(json.decode(response.body));
      } else {
        print('⚠️ API Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    return null;
  }
}

void main() async {
  ApiService apiService = ApiService();
  IssueLogModel? issueLog = await apiService.fetchIssueLogs();

  if (issueLog != null && issueLog.data.isNotEmpty) {
    print('✅ Data fetched successfully!\n');

    for (var task in issueLog.data) {
      print('🔹 Task ID: ${task.id}');
      print('📌 Description: ${task.description}');
      print('🟡 Status: ${task.status}');
      print('🔥 Priority: ${task.priority}');
      print('🕒 Created On: ${task.createdOn}');
      print('🏗 Project ID: ${task.project}');
      print('👤 Reported By: ${task.reportedBy}');
      print('--------------------------------');
    }
  } else {
    print('🚫 No issue logs found or failed to fetch data.');
  }
}
