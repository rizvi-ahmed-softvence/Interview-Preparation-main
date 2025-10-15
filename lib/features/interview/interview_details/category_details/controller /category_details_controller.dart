import 'package:get/get.dart';

class CategoryDetailsController extends GetxController {
  var title = ''.obs;
  var description = ''.obs;
  var name = ''.obs;
  var img = ''.obs;
  var duration = 0.obs;
  var difficulty = ''.obs;
  var questionType = ''.obs;
  var id = ''.obs;
  var interviewId = ''.obs;

  var whatToExpect = <String>[].obs;

  // ✅ Track selected items
  var selectedExpectations = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as List<dynamic>;

    name.value = args[0];
    img.value = args[1];
    duration.value = args[2];
    description.value = args[3];
    whatToExpect.value = (args[4] as List?)!.map((e) => e.toString()).toList();
    id.value = args[5];
    interviewId.value = args[6];
    difficulty.value = "Beginner";
    questionType.value = "Multiple Choice";


    // selectedExpectations is empty initially
  }

  // Optional: Toggle selection logic
  void toggleSelection(String item) {
    if (selectedExpectations.contains(item)) {
      selectedExpectations.remove(item);
    } else {
      selectedExpectations.add(item);
    }
  }
}
