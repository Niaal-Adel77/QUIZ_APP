import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_view.dart';
import 'answers_list_view.dart';

class AdminDashboardView extends StatefulWidget {
  @override
  _AdminDashboardViewState createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int _currentIndex = 0;

  final List<Widget> _views = [AdminView(), AnswersListView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'add_question'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'view_answers'.tr,
          ),
        ],
      ),
    );
  }
}
