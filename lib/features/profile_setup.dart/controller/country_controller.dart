import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:inprep_ai/features/profile_screen/model/country_model.dart';

class CountryController {
  final CountryModel model;
  final VoidCallback onCountryUpdated;

  CountryController({required this.model, required this.onCountryUpdated});

  void openCountryPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.blue),
        child: CountryPickerDialog(
          titlePadding: EdgeInsets.all(8.0),
          isSearchable: false,
          title: Text('Select Country'),
          onValuePicked: (Country country) {
            model.updateCountry(country);
            onCountryUpdated();
          },
          itemBuilder: (Country country) {
            return Row(
              children: [
                CountryPickerUtils.getDefaultFlagImage(country),
                SizedBox(width: 8.0),
                Expanded(child: Text(country.name)),
              ],
            );
          },
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('GB'),
            CountryPickerUtils.getCountryByIsoCode('US'),
            CountryPickerUtils.getCountryByIsoCode('CA'),
            CountryPickerUtils.getCountryByIsoCode('AU'),
          ],
        ),
      ),
    );
  }
}