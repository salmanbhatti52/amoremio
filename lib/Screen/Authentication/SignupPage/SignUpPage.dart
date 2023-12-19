import 'package:get/get.dart';
import 'SignUpPageController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Widgets/DividerandOR.dart';
import '../SocialLogin/SocialLoginPage.dart';
import '../../../Widgets/TextFieldLabel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Widgets/TextFields.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Social_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import '../../BottomNavigationBar/BottomNavigationBar.dart';
import 'package:amoremio/Screen/Authentication/LoginPage/login_page.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  SignupController signupController = Get.put(SignupController());
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    FocusNode focus1 = FocusNode();
    FocusNode focus2 = FocusNode();
    FocusNode focus3 = FocusNode();
    FocusNode focus4 = FocusNode();
    FocusNode focus5 = FocusNode();
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
                      text: "Signup",
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 300),
                  child: const MyText(
                    text: "Hello, Create to your account",
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
                            controller: signupController.userNameController,
                            hintText: "username@gmail.com",
                            keyboardType: TextInputType.name,
                            prefixImage: ImageAssets.user,
                            focusNode: focus1,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus2);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 600),
                          child: const LabelField(
                            text: 'Email',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 700),
                          child: CustomTextFormField(
                            controller: signupController.emailController,
                            hintText: "username@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                            focusNode: focus2,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus3);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 1800),
                          child: const LabelField(
                            text: 'Password',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 900),
                          child: Obx(
                            () => CustomTextFormField(
                              controller: signupController.passwordController,
                              maxLine: signupController.isPasswordVisible.value
                                  ? 1
                                  : null,
                              suffixImageColor:
                                  signupController.isPasswordVisible.value
                                      ? null
                                      : AppColor.primaryColor,
                              hintText: "********",
                              focusNode: focus3,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus4);
                              },
                              prefixImage: ImageAssets.password,
                              suffixImage:
                                  signupController.isPasswordVisible.value
                                      ? ImageAssets.eyeOffImage
                                      : ImageAssets.eyeOnImage,
                              suffixTap: () {
                                signupController.passwordTap();
                              },
                              obscureText:
                                  signupController.isPasswordVisible.value,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 900),
                          duration: const Duration(milliseconds: 1000),
                          child: const LabelField(
                            text: "Where do you live?",
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 1000),
                          duration: const Duration(milliseconds: 1100),
                          child: Obx(
                            () => CustomTextFormField(
                              controller: signupController.currentAddress == ""
                                  ? signupController.locationController
                                  : TextEditingController(
                                      text: signupController.currentAddress),
                              hintText: "Your address here",
                              focusNode: focus4,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus5);
                              },
                              keyboardType: TextInputType.streetAddress,
                              prefixImage: ImageAssets.locationBrown,
                              suffixImage: ImageAssets.locationFill,
                              suffixTap: () {
                                signupController.getCurrentPosition(context);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 1100),
                          duration: const Duration(milliseconds: 1200),
                          child: const LabelField(
                            text: 'Date of birth',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 1200),
                          duration: const Duration(milliseconds: 1300),
                          child: Obx(
                            () => CustomTextFormField(
                              controller: TextEditingController(
                                  text: signupController.selectedDate.value),
                              hintText: "Date of birth",
                              focusNode: focus5,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              prefixImage: ImageAssets.birthDate,
                              suffixImage: ImageAssets.calendar,
                              suffixTap: () {
                                _selectDate(context);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 1300),
                          duration: const Duration(milliseconds: 1400),
                          child: const LabelField(
                            text: 'Gender',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 1400),
                          duration: const Duration(milliseconds: 1500),
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
                                  decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        ImageAssets.gender,
                                      ),
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              10.0), // Adjust the padding as needed
                                      child: SvgPicture.asset(
                                        ImageAssets.dropDown,
                                        // fit: BoxFit.fill,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: AppColor.whiteColor,
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      borderSide: BorderSide(
                                        color: AppColor.redColor,
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
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
                                  padding: const EdgeInsets.only(right: 5),
                                  borderRadius: BorderRadius.circular(12),
                                  items: signupController.genderType
                                      .map(
                                        (item) => DropdownMenuItem<String>(
                                          value: item,
                                          onTap: (){
                                            signupController.selectedGenders = null;
                                            signupController.fetchGenders();
                                          },
                                          child: Text(
                                            item,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: signupController.selectedGenders != null
                                                  ? AppColor.hintTextColor
                                                  : AppColor.blackColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  value: signupController.selectedGenders,
                                  onChanged: (value) {
                                    signupController.selectedGenders = value;
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
                  delay: const Duration(milliseconds: 1500),
                  duration: const Duration(milliseconds: 1600),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: Get.height * 0.08,
                      left: Get.width * 0.08,
                      top: Get.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: AppColor.primaryColor),
                              child: Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: AppColor.primaryColor,
                                checkColor: AppColor.whiteColor,
                                value: signupController.checkBoxValue.value,
                                onChanged: (bool? value) {
                                  signupController.checkBoxValue.value = value!;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.65,
                          child: const LabelField(
                            text:
                                ' By continuing, you are confirming that you have read and agree to our Terms and Conditions and Privacy Policy.',
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
                  delay: const Duration(milliseconds: 1600),
                  duration: const Duration(milliseconds: 1700),
                  child: LargeButton(
                    width: Get.width * 0.84,
                    height: Get.height * 0.065,
                    text: "Signup",
                    onTap: () {
                      Get.to(
                        () => MyBottomNavigationBar(),
                        duration: const Duration(milliseconds: 350),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Get.height * 0.04,
                    bottom: Get.height * 0.035,
                  ),
                  child: const DividerOR(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      text: "Google",
                      width: Get.width * 0.4,
                      height: Get.height * 0.045,
                      onTap: () {
                        Get.to(
                          () => SocialLoginPage(),
                          duration: const Duration(milliseconds: 350),
                          transition: Transition.rightToLeft,
                        );
                      },
                      borderColor: AppColor.primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SocialButton(
                      text: "Facebook",
                      textColor: AppColor.facebookColor,
                      icon: ImageAssets.facebook,
                      width: Get.width * 0.4,
                      height: Get.height * 0.045,
                      onTap: () {
                        Get.to(
                          () => SocialLoginPage(),
                          duration: const Duration(milliseconds: 350),
                          transition: Transition.rightToLeft,
                        );
                      },
                      borderColor: AppColor.facebookColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LabelField(
                      text: 'Already have an account?',
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => LoginPage(),
                          duration: const Duration(milliseconds: 350),
                          transition: Transition.upToDown,
                        );
                      },
                      child: const LabelField(
                        text: ' Login',
                        color: AppColor.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  late String formattedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      formattedDate =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
      print(formattedDate);
    }
    signupController.setDate(formattedDate);
  }
}
