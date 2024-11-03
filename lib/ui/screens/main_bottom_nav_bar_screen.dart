import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/complete_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import '../widgets/tm_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  @override
  int _selectedIndex = 0;
  final List<Widget>_screen = const[
    NewTaskScreen(),
    CompleteTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar() ,

      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index){
          _selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.new_label),
              label: 'New'),
          NavigationDestination(
              icon: Icon(Icons.check_box),
              label: 'Complete'),
          NavigationDestination(
              icon: Icon(Icons.close),
              label: 'Cancelled'),
          NavigationDestination(
              icon: Icon(Icons.speed_outlined),
              label: 'Progress'),
        ],
      ),
    );
  }
}

