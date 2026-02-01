import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';
import 'stats_drawer.dart';

class AdminView extends StatelessWidget {
  final controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('admin_panel'.tr)),
      endDrawer: StatsDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'question'.tr),
              onChanged: (v) => controller.questionText.value = v,
            ),
            TextField(
              decoration: InputDecoration(labelText: '${'option'.tr} A'),
              onChanged: (v) => controller.optionA.value = v,
            ),
            TextField(
              decoration: InputDecoration(labelText: '${'option'.tr} B'),
              onChanged: (v) => controller.optionB.value = v,
            ),
            TextField(
              decoration: InputDecoration(labelText: '${'option'.tr} C'),
              onChanged: (v) => controller.optionC.value = v,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'correct_answer'.tr),
              onChanged: (v) => controller.correct.value = v,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success = await controller.sendQuestion();
                if (success) {
                  Get.snackbar(
                    'success'
                        .tr, // Note: I should add 'success' key too if not present, but for now assuming English default or fallback. Wait, I should add it.
                    'question_sent'.tr, // Similarly here.
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text('send_question'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
