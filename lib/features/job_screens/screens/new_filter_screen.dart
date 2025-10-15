import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/job_screens/controller/filter_controller.dart';

class FilterScreen extends StatelessWidget {
  final controller = Get.find<FilterController>();

  FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Filter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            buildDropdown('Company', controller.companies, controller.selectedCompany),
            buildDropdown('Position', controller.positions, controller.selectedPosition),
            buildDropdown('Year', controller.years, controller.selectedYear),
            buildDropdown('Location', controller.locations, controller.selectedLocation),
            buildDropdown('Status', controller.statuses, controller.selectedStatus),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String label, RxList<String> items, RxString selectedValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF676768), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Obx(() {
            final allItems = [''].followedBy(items).toList();
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: DropdownButton<String>(
                value: selectedValue.value.isEmpty ? '' : selectedValue.value,
                isExpanded: true,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                style: const TextStyle(color: Colors.green, fontSize: 16),
                items: allItems
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item.isEmpty ? 'Any' : item),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) selectedValue.value = value;
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
