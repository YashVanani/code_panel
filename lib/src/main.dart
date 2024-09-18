import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdoodle_task/src/core/controller/code_execution_controller.dart';
import 'package:jdoodle_task/src/core/service/jdoodle_api_service.dart';
import 'package:jdoodle_task/src/ui/view/dart_pad_screen.dart';

void main() {
  Get.put(CodeExecutionController(myApiKey, myClientId));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Dart Code Executor',
      debugShowCheckedModeBanner: false,
      home: DartPadScreen(),
    );
  }
}
