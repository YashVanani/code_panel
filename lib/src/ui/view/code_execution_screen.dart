import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdoodle_task/src/core/controller/code_execution_controller.dart';
import 'package:jdoodle_task/src/ui/utils/app_color.dart';
import 'package:jdoodle_task/src/ui/utils/app_string.dart';

class CodeExecutionScreen extends StatelessWidget {
  const CodeExecutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CodeExecutionController controller = Get.find<CodeExecutionController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(AppStrings.runString, style: TextStyle(color: AppColors.whiteColor)),
          backgroundColor: AppColors.blackColor,
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          actions: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: !controller.isLoading.value
                      ? () => controller.sendCode(controller.codeController.text, 'dart')
                      : null,
                  icon: const Icon(Icons.play_arrow, size: 35, color: AppColors.redColor),
                ),
              );
            })
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: AppColors.redColor, fontSize: 16),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.blueGreyColor.withOpacity(.23),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Text(
                            controller.output.value,
                            style: const TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
