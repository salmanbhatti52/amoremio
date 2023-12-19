import 'package:get/get.dart';
import 'SocialLoginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:animate_do/animate_do.dart';
import '../../../Widgets/TextFieldLabel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Widgets/TextFields.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import '../../BottomNavigationBar/BottomNavigationBar.dart';


// ignore: must_be_immutable
class SocialLoginPage extends StatelessWidget {
  SocialLoginPage({Key? key}) : super(key: key);

  SocialLoginController socialLoginController = Get.put(SocialLoginController());
  final formKey = GlobalKey<FormState>();
  List<String> genderType = ["Male", "Female", "Other"];
  String? selectedGender;


  @override
  Widget build(BuildContext context) {
    FocusNode focus1 = FocusNode();
    FocusNode focus2 = FocusNode();
    FocusNode focus3 = FocusNode();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInDown(
                  delay: const Duration(milliseconds: 100),
                  duration: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * 0.07,
                      bottom: Get.height * 0.02,
                    ),
                    child: const MyText(
                      text: "Get Started",
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 300),
                  child: const MyText(
                    text: "Hello, You need to fulfil the info to get\nstarted with us! ",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.brownColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.065,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.08,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInLeft(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 400),
                          child: const LabelField(
                            text: 'User Name',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 400),
                          duration: const Duration(milliseconds: 500),
                          child: CustomTextFormField(
                            controller: socialLoginController.userNameController,
                            hintText: "username@gmail.com",
                            focusNode: focus1,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(focus2);
                            },
                            keyboardType: TextInputType.name,
                            prefixImage: ImageAssets.user,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 600),
                          child: const LabelField(
                            text: 'Where do you live?',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 700),
                          child: Obx(() => CustomTextFormField(
                            controller: socialLoginController.currentAddress == ""
                                ? socialLoginController.locationController
                                : TextEditingController(text: socialLoginController.currentAddress),
                            hintText: "Your address here",
                            focusNode: focus2,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(focus3);
                            },
                            keyboardType: TextInputType.streetAddress,
                            prefixImage: ImageAssets.locationBrown,
                            suffixImage: ImageAssets.locationFill,
                            suffixTap: (){
                              socialLoginController.getCurrentPosition(context);
                            },
                          ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 800),
                          child: const LabelField(
                            text: 'Date of birth',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 900),
                          child: CustomTextFormField(
                            controller: TextEditingController(text: socialLoginController.selectedDate.value),
                            hintText: "Date of birth",
                            focusNode: focus3,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            prefixImage: ImageAssets.birthDate,
                            suffixImage: ImageAssets.calendar,
                            suffixTap: (){
                              _selectDate(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 900),
                          duration: const Duration(milliseconds: 1000),
                          child: const LabelField(
                            text: 'Gender',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 1000),
                          duration: const Duration(milliseconds: 1100),
                          child: Container(
                            width: Get.width * 0.9,
                            height: Get.height * 0.055,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 24,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  // icon: SvgPicture.asset(ImageAssets.dropDown,),
                                  iconSize: 0,
                                  decoration:  InputDecoration(
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(left: 10.0), // Adjust the padding as needed
                                      child: SvgPicture.asset(
                                        ImageAssets.dropDown,
                                        // fit: BoxFit.fill,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    prefixIcon: IconButton(onPressed: (){}, icon: SvgPicture.asset(ImageAssets.gender,),),
                                    filled: true,
                                    fillColor: AppColor.whiteColor,
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide(
                                        color: AppColor.redColor,
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                    ),
                                    hintText: 'Select Gender',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: AppColor.hintTextColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    errorStyle: const TextStyle(
                                      color: AppColor.redColor,
                                      fontSize: 10,
                                      fontFamily: 'Inter-Bold',
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                      right: 5),
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  items: genderType
                                      .map(
                                        (item) => DropdownMenuItem<
                                        String>(
                                      value: item,
                                      onTap: selectedGender = null ,
                                      child: Text(
                                        item,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: selectedGender != null ? AppColor.hintTextColor : AppColor.blackColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                  value: selectedGender,
                                  onChanged: (value) {
                                    selectedGender = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1100),
                  duration: const Duration(milliseconds: 1200),
                  child:  Padding(
                    padding: EdgeInsets.only(
                      bottom: Get.height * 0.08,
                      left: Get.width * 0.08,
                      top: Get.height * 0.01,
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() =>  Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Theme(
                            data: ThemeData(unselectedWidgetColor: AppColor.primaryColor),
                            child: Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              activeColor: AppColor.primaryColor,
                              checkColor: AppColor.whiteColor,
                              value: socialLoginController.checkBoxValue.value,
                              onChanged: (bool? value) {
                                socialLoginController.checkBoxValue.value = value!;
                              },
                            ),
                          ),
                        ),
                        ),
                        SizedBox(
                          width: Get.width * 0.65,
                          child: const LabelField(
                            text: ' By continuing, you are confirming that you have read and agree to our Terms and Conditions and Privacy Policy.',
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w400,
                            align: TextAlign.left,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1200),
                  duration: const Duration(milliseconds: 1300),
                  child: LargeButton(
                    width: Get.width * 0.84,
                    height: Get.height * 0.065,
                    text: "Login",
                    onTap: () {
                      Get.to(
                            () => MyBottomNavigationBar(),
                        duration: const Duration(milliseconds: 350),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                ),
                SizedBox(height: Get.height * 0.02,),
               ],
            ),
          ),
        ),
      ),
    );
  }
  // ignore: prefer_typing_uninitialized_variables
  late final formattedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      formattedDate = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
    }
    socialLoginController.setDate(formattedDate);
  }
}
