import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled23/views/stats_drawer.dart';
import '../supabase_config.dart';

class AnswersListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('student_answers'.tr)),
      endDrawer: StatsDrawer(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: SupabaseConfig.client.from('answers').select(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final answers = snapshot.data ?? [];

          if (answers.isEmpty) {
            return Center(child: Text('no_answers'.tr));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('question_id'.tr)),
                  DataColumn(label: Text('name'.tr)),
                  DataColumn(label: Text('user_answer'.tr)),
                  DataColumn(label: Text('correct'.tr)),
                ],
                rows: answers.map((answer) {
                  return DataRow(
                    cells: [
                      DataCell(Text(answer['question_id'].toString())),
                      DataCell(Text(answer['name']?.toString() ?? 'N/A')),
                      DataCell(Text(answer['user_answer'].toString())),
                      DataCell(
                        Icon(
                          answer['is_correct']
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: answer['is_correct']
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
