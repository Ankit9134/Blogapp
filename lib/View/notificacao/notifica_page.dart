import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.branco,
        body: const Center(
          child: Text('Notificação'),
        )
    );
  }
}

