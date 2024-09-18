import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:get/get.dart';
import 'package:jdoodle_task/src/core/controller/code_execution_controller.dart';
import 'package:jdoodle_task/src/ui/utils/app_color.dart';
import 'package:jdoodle_task/src/ui/utils/app_string.dart';
import 'package:jdoodle_task/src/ui/view/code_execution_screen.dart';
import 'package:highlight/languages/dart.dart';

class DartPadScreen extends StatefulWidget {
  const DartPadScreen({super.key});

  @override
  _DartPadScreenState createState() => _DartPadScreenState();
}

class _DartPadScreenState extends State<DartPadScreen> {
  CodeExecutionController codeExecutionController = Get.find<CodeExecutionController>();

  @override
  void initState() {
    codeExecutionController.codeController.setLanguage(dart, analyzer: DartPadAnalyzer());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackSeconderColor,
        appBar: AppBar(
          title: const Text(AppStrings.dartPadString, style: TextStyle(color: AppColors.whiteColor)),
          backgroundColor: AppColors.blackColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CodeExecutionScreen()));
                  codeExecutionController.sendCode(codeExecutionController.codeController.text, 'dart');
                },
                icon: const Icon(
                  Icons.play_arrow,
                  size: 35,
                  color: AppColors.redColor,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CodeTheme(
            data: CodeThemeData(styles: monokaiSublimeTheme),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: CodeField(
                background: AppColors.blackSeconderColor,
                gutterStyle: const GutterStyle(),
                controller: codeExecutionController.codeController,
                textStyle: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  color: AppColors.whiteColor,
                ),
                cursorColor: AppColors.whiteColor,
                expands: true,
                wrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
