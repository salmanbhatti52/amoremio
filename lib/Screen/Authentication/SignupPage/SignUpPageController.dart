import 'package:amoremio/Models/GetGenderModel.dart';
import 'package:amoremio/Utills/AppUrls.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController{

  RxBool isPasswordVisible= true.obs;
  RxBool checkBoxValue = false.obs;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  passwordTap(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final Rx<Position?> _currentPosition = Rx<Position?>(null);
  final Rx<String?> _currentAddress = Rx<String?>(null);

  Position? get currentPosition => _currentPosition.value;
  String? get currentAddress => _currentAddress.value;

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    try {
      final position = await Geolocator.getCurrentPosition();
      _currentPosition.value = position;
      _getAddressFromLatLng(position);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        final address = "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
        _currentAddress.value = address;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  RxString selectedDate = ''.obs;

  void setDate(String date) {
    selectedDate.value = date;
  }

  RxString selectedGender = "Select Gender".obs;

  List<String> genderType = ["Male", "Female", "Other"];
  String? selectedGenders;

  void setSelectedGender(String gender) {
    selectedGender.value = gender;
  }

  GetGenderModel getGenderModel = GetGenderModel();
  
  Future<void> fetchGenders() async {

    String apiUrl = getGender;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      final responseString = response.body;
      print("responseSignUpApi: $responseString");

      if ( getGenderModel.status == "success") {
        getGenderModel = getGenderModelFromJson(responseString);
      } else {
        print('Failed to fetch genders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      print('Failed to connect to the server.');
    }
  }


}



