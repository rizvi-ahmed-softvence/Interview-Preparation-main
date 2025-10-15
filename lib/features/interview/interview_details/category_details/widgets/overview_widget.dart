import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

class OverviewWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final void Function(String?)? onChanged;
  final String? selectedValue;

  const OverviewWidget({
    super.key,
    required this.title,
    required this.description,
    this.isDropdown = false,
    this.dropdownItems,
    this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: Color(0xFFEBF8F1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(
              title,
              style: getTextStyle(
                color: Color(0xff6a329f),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            isDropdown
                ? DropdownButton<String>(
                    value: selectedValue,
                    isExpanded: true,
                    underline: SizedBox(),
                    style: getTextStyle(
                      color: Color(0xFF676768),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    dropdownColor: Color(0xFFEBF8F1),
                    icon: Icon(Icons.keyboard_arrow_down, color: Color(0xff6a329f)),
                    items: dropdownItems?.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  )
                : Text(
                    description,
                    style: getTextStyle(
                      color: Color(0xFF676768),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
