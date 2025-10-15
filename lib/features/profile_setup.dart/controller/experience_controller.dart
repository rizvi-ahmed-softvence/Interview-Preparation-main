import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/profile_screen/model/country_model.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/country_controller.dart';
import 'package:uuid/uuid.dart';


class ExperienceFormControllers {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController employerNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController responsibilitiesController =
      TextEditingController();
  final ExperienceController experienceController = ExperienceController();

  final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);

  final CountryModel countryModel = CountryModel(
    initialCountry: CountryPickerUtils.getCountryByIsoCode('GB'),
  );
  late final CountryController countryController;

  ExperienceFormControllers() {
    countryController = CountryController(
      model: countryModel,
      onCountryUpdated: () {},
    );
  }

  void dispose() {
    jobTitleController.dispose();
    employerNameController.dispose();
    cityController.dispose();
    responsibilitiesController.dispose();
  }
}
class ExperienceController extends GetxController {
  // Start date
  var selectDate = 'DD.MM.YYYY'.obs;
  void updateStartDate(String date) {
    selectDate.value = date;
  }

  // End date
  var selectDate1 = 'DD.MM.YYYY'.obs;
  void updateEndDate(String date) {
    selectDate1.value = date;
  }
  var experienceForms = <String>[].obs;
  var formControllers = <String, ExperienceFormControllers>{}.obs;
  var selectedSkills = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    addNewExperienceForm();
  }

  void addNewExperienceForm() {
    final newFormId = const Uuid().v4();
    experienceForms.add(newFormId);
    formControllers[newFormId] = ExperienceFormControllers();
  }

  void removeExperienceForm(String formId) {
    if (experienceForms.length > 1) {
      experienceForms.remove(formId);
      formControllers[formId]?.dispose();
      formControllers.remove(formId);
    }
  }

  void addSkill(String skill) {
    selectedSkills.add(skill);
  }

  void removeSkill(String skill) {
    selectedSkills.remove(skill);
  }
}