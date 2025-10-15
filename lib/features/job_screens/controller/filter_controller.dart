import 'package:get/get.dart';
import 'package:inprep_ai/features/job_screens/models/all_jobs_model.dart';

class FilterController extends GetxController {
  var companies = <String>[].obs;
  var positions = <String>[].obs;
  var years = <String>[].obs;
  var locations = <String>[].obs;
  var statuses = <String>[].obs;

  // Start with empty (no filter selected)
  var selectedCompany = ''.obs;
  var selectedPosition = ''.obs;
  var selectedYear = ''.obs;
  var selectedLocation = ''.obs;
  var selectedStatus = ''.obs;

  void setFiltersFromJobs(List<AllJobsModel> jobs) {
    companies.value = jobs
        .map((job) => job.company ?? '')
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    positions.value = jobs
        .map((job) => job.title ?? '')
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    years.value = jobs
        .map((job) {
          if (job.createdAt == null) return '';
          return job.createdAt!.substring(0, 4); // year only
        })
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    locations.value = jobs
        .map((job) => job.location ?? '')
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    statuses.value = ['Applied', 'Not Applied'];

    // NO default selection: start empty = no filter
    selectedCompany.value = '';
    selectedPosition.value = '';
    selectedYear.value = '';
    selectedLocation.value = '';
    selectedStatus.value = '';
  }
}
