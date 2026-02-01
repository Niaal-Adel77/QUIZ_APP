import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled23/views/login_view.dart';
import 'settings_view.dart';
import '../controllers/question_controller.dart';

class StatsDrawer extends StatelessWidget {
  final controller = Get.find<QuestionController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(
        () => ListView(
          children: [
            DrawerHeader(child: Text('statistics'.tr)),
            ListTile(
              title: Text('${'correct'.tr}: ${controller.correctCount.value}'),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
            ListTile(
              title: Text('${'wrong'.tr}: ${controller.wrongCount.value}'),
              trailing: Icon(Icons.error, color: Colors.red),
            ),
            ListTile(
              title: Text(
                '${'answered'.tr}: ${controller.answeredQuestions.length}',
              ),
              trailing: Icon(Icons.question_mark, color: Colors.blue),
            ),
            ListTile(
              title: Text('settings'.tr),
              trailing: Icon(Icons.settings, color: Colors.grey),
              onTap: () {
                Get.to(() => SettingsView());
              },
            ),
            ListTile(
              title: Text('Exit'.tr),
              trailing: Icon(Icons.logout, color: Colors.red),
              onTap: () {
                Get.offAll(() => LoginView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
