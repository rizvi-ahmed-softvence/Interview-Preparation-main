import 'package:country_pickers/country.dart';
import 'package:get/get.dart';

class CountryModel {
  Rx<Country> selectedCountry;

  CountryModel({required Country initialCountry})
      : selectedCountry = initialCountry.obs;

  // Correct the getter to return the actual selected country
  get initialCountry => selectedCountry.value;

  void updateCountry(Country newCountry) {
    selectedCountry.value = newCountry;
    // print('Selected Country: ${newCountry.name}'); // Debug print
  }
}
