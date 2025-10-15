import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/job_screens/models/all_jobs_model.dart';
import 'filter_controller.dart';

class JobsController extends GetxController {
  var jobsmodel = <AllJobsModel>[].obs;
  var filteredJobs = <AllJobsModel>[].obs;
  var isLoading = true.obs;

  final searchController = TextEditingController();

  final FilterController filterController = Get.put(FilterController());

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> alljobs() async {
    final url = Urls.alljob;

    try {
      isLoading(true);
      EasyLoading.show(status: "Fetching Jobs...");

      // Retrieve the access token using SharedPreferencesHelper
      String? accessToken = await SharedPreferencesHelper.getAccessToken();
      debugPrint("Access token retrieved: $accessToken");

      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError("Access token is missing. Please login again.");
        debugPrint("Access token is null or empty.");
        return;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': accessToken},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        jobsmodel.value =
            data.map((item) => AllJobsModel.fromJson(item)).toList();
        filteredJobs.assignAll(jobsmodel);

        filterController.setFiltersFromJobs(jobsmodel);
      }
    } catch (error) {
      debugPrint('Error: $error');
    } finally {
      isLoading(false);
      EasyLoading.dismiss();
    }
  }

  void filterJobs(String query) {
    if (query.isEmpty) {
      filteredJobs.assignAll(jobsmodel);
    } else {
      filteredJobs.assignAll(
        jobsmodel.where(
          (job) =>
              (job.title?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (job.company?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (job.location?.toLowerCase().contains(query.toLowerCase()) ??
                  false),
        ),
      );
    }
  }

  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    alljobs();

    // Listen to search input changes and apply combined filtering
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      applyFilters();
    });

    // Listen to changes in any filter and apply combined filtering
    ever(filterController.selectedCompany, (_) => applyFilters());
    ever(filterController.selectedPosition, (_) => applyFilters());
    ever(filterController.selectedYear, (_) => applyFilters());
    ever(filterController.selectedLocation, (_) => applyFilters());
    ever(filterController.selectedStatus, (_) => applyFilters());
  }

  // ... your existing alljobs() code remains the same ...

  void applyFilters() {
    final fc = filterController;
    final query = searchQuery.value.toLowerCase();

    filteredJobs.value =
        jobsmodel.where((job) {
          // Filter by search query (in title, company or location)
          final matchesSearch =
              query.isEmpty ||
              (job.title?.toLowerCase().contains(query) ?? false) ||
              (job.company?.toLowerCase().contains(query) ?? false) ||
              (job.location?.toLowerCase().contains(query) ?? false);

          // Filter by each selected filter if any
          final matchCompany =
              fc.selectedCompany.value.isEmpty ||
              job.company == fc.selectedCompany.value;
          final matchPosition =
              fc.selectedPosition.value.isEmpty ||
              job.title == fc.selectedPosition.value;
          final matchYear =
              fc.selectedYear.value.isEmpty ||
              (job.createdAt != null &&
                  job.createdAt!.startsWith(fc.selectedYear.value));
          final matchLocation =
              fc.selectedLocation.value.isEmpty ||
              job.location == fc.selectedLocation.value;
          final matchStatus =
              fc.selectedStatus.value.isEmpty ||
              (fc.selectedStatus.value == 'Applied'
                  ? (job.isApplied ?? false)
                  : !(job.isApplied ?? false));

          return matchesSearch &&
              matchCompany &&
              matchPosition &&
              matchYear &&
              matchLocation &&
              matchStatus;
        }).toList();
  }
}
