import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';
import 'result_view.dart';
import 'stats_drawer.dart';

class QuestionView extends StatelessWidget {
  final controller = Get.find<QuestionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final q = controller.question.value;
      if (q == null) {
        return const Scaffold(body: Center(child: Text('No question')));
      }

      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(title: Text('question'.tr)),
          drawer: StatsDrawer(),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple.shade50, Colors.white],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        q.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...q.options.map(
                    (o) => Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: controller.selected.value == o
                              ? Colors.deepPurple
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: RadioListTile(
                        activeColor: Colors.deepPurple,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          o,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: controller.selected.value == o
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        value: o,
                        groupValue: controller.selected.value,
                        onChanged: (v) =>
                            controller.selected.value = v.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: controller.selected.value.isEmpty
                          ? null
                          : () {
                              controller.submit();
                              Get.off(() => ResultView());
                            },
                      child: Text(
                        'submit'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
