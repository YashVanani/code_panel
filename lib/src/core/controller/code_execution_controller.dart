import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/dart.dart';
import 'package:jdoodle_task/src/core/service/jdoodle_api_service.dart';
final text = '''
void main() {
  var x = 10;
  var y = 25;
  var z = x + y;
  
  print('x + y = \$z');
}
''';

class CodeExecutionController extends GetxController {
  final CodeController codeController;
  final JDoodleApiService apiService;
  var output = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  CodeExecutionController(String clientId, String apiKey)
      : codeController = CodeController(
    text: text,
    language: dart,
    namedSectionParser: const BracketsStartEndNamedSectionParser(),
  ),
        apiService = JDoodleApiService(clientId, apiKey);

  Future<void> sendCode(String code, String language) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await apiService.sendCode(code, language);
      output.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}

