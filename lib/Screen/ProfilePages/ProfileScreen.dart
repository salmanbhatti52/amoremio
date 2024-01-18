import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import '../../Utills/AppUrls.dart';
import '../../Widgets/rounded_dropdown_menu.dart';
import 'InterestTags.dart';
import 'package:get/get.dart';
import 'EditAvatorProfile.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Widgets/AppBar.dart';
import '../../Widgets/TextFields.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Small_Button.dart';
import '../../Widgets/TextFieldLabel.dart';
import '../../Resources/assets/assets.dart';
import '../../Resources/colors/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Uint8List? _image;
  File? selectedIMage;
  String base64string = '';
  String userGenderName = '';
  String address = '';
  var username = '';
  dynamic imgurl = '';
  List<dynamic> interests = [];
  late List<dynamic> interestIds;
  dynamic interestIdsJson;
  List<dynamic> interestList = [];

  int currentIndex = -1;

  // List<dynamic> imagePaths = [];
  List<Map<String, dynamic>> imagePaths = [];
  List<String> imagesavators = [];

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  TextEditingController currentAddress = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchGenders();
    getavators();
  }

  Future pickimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      selectedIMage = File(pickedImage.path);
      print(selectedIMage);
      _image = selectedIMage?.readAsBytesSync();
      base64string =
          base64.encode(_image as List<int>); //convert bytes to base64 string
      uploadprofile(base64string);
    });
    // await ImagePicker()
    //     .pickImage(source: ImageSource.gallery, imageQuality: 50)
    //     .then((value) {
    //   if (value != null) {
    //     print(File(value.path));
    //     // _cropImage(File(value.path));
    //   }
    // });
  }

  //upload avators///
  Future<void> _pickImages() async {
    // Check if the number of selected images is less than the limit (9)
    if (imagePaths.where((path) => path.isNotEmpty).length < 9) {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        // setState(() {
        //   int emptyIndex = imagePaths.indexWhere((element) => element.isEmpty);
        //   if (emptyIndex != -1) {
        //     imagePaths[emptyIndex] = {"image": pickedImage.path};
        //     currentIndex = emptyIndex;
        //   } else {
        //     imagePaths.add({"image": pickedImage.path});
        //     currentIndex = imagePaths.length - 1;
        //   }
        // });
        List<int> imageBytes = await pickedImage.readAsBytes();

        // Encode the image bytes to base64
        String base64Image = base64Encode(imageBytes);
        print('base64Image $base64Image');
        uploadavators(base64Image);
      }
    } else {
      print("You can't take more than 9 images");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You can't take more than 9 images")));
    }
  }

  String selectedGender = "Select Gender";

  List<dynamic> genderType = [];
  String? selectedGenders;
  var genderval;

  void setSelectedGender(dynamic gender) {
    setState(() {
      selectedGender = gender['name'];
    });
  }

  ////get gender/////
  Future<void> fetchGenders() async {
    String apiUrl = getGender;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      final responseString = response.body;
      var data = jsonDecode(responseString);
      String status = data['status'];
      if (status == 'success') {
        setState(() {
          genderType = data['data'];
          loaddata();
          // getuseravatars(index);
        });
      }
      print("genderApi: $genderType");
    } catch (e) {
      print('Error: $e');
      print('Failed to connect to the server.');
    }
  }

  void loaddata() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = getusersProfile;
    // try {
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {"users_customers_id": userId},
        ));
    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      print(userdetail);
      setState(() {});
      Navigator.of(context).pop();
      userNameController.text = userdetail['data']['username'];
      username = userdetail['data']['username'];
      emailController.text = userdetail['data']['email'];
      birthController.text = userdetail['data']['date_of_birth'];
      bioController.text = userdetail['data']['summary'] ?? '';
      educationController.text = userdetail['data']['education'] ?? '';
      address = userdetail['data']['location'];
      interestList = userdetail['data']['interests'] ?? '';
      imgurl = baseUrlImage + userdetail['data']['image'];

      // List<int> decodedBytes = base64.decode(data);
      // setState(() {
      //   _image = Uint8List.fromList(decodedBytes);
      //   print('image url: $_image');
      // });

      dynamic gendersId = userdetail['data']['genders_id'];

      String getGenderName(gendersId) {
        Map<String, dynamic>? gender = genderType.firstWhere(
          (g) => g['genders_id'] == gendersId,
          orElse: () => {'name': 'Unknown'},
        );
        return gender?['name'];
      }

      setState(() {
        userGenderName = getGenderName(gendersId);
      });
      // Get gender name for the user

      // Output the result
      print('User Gender: $userGenderName');
    } else {
      print(userdetail['status']);
      var errormsg = userdetail['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errormsg)));
    }
    // } catch (e) {
    //   print('error123456');
    // }
  }

  ///get date func/////
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
          "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      print('formatted date: $formattedDate');
      birthController.text = formattedDate;
    }
    // setDate(formattedDate);
  }

  var selectedDate;
  void setDate(String date) {
    selectedDate.value = date;
  }

  void editprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = editProfile;
    // print(interestIdsJson);
    try {
      var showdata = {
        "users_customers_id": userId,
        "summary": bioController.text.toString(),
        "username": userNameController.text.toString(),
        "email": emailController.text.toString(),
        "genders_id": genderval,
        "date_of_birth": birthController.text.toString(),
        "education": educationController.text.toString(),
        "verified": "No",
        "interests": interestIdsJson
      };
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(showdata));
      // print(showdata);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        // Get.to(
        //   () => MyBottomNavigationBar(),
        //   duration: const Duration(milliseconds: 350),
        //   transition: Transition.rightToLeft,
        // );
        var msg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
      } else {
        print('error');
        print(data['message']);
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error123456: $e');
    }
  }

  // void removeImage(int index) {
  //   setState(() {
  //     imagePaths.removeAt(index);
  //     imagePaths.add('');
  //     print('image remove path : $imagePaths');
  //   });
  // }
  void removeImage(int index) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    String apiUrl = deleteAvator;
    try {
      var showdata = {
        "users_customers_id": imagePaths[index]['users_customers_id'],
        "users_avatars_id": imagePaths[index]['users_avatars_id']
      };
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(showdata));
      // print(showdata);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          imagePaths.removeAt(index);
          print('image remove path : $imagePaths');
        });
        Navigator.of(context).pop();
        var msg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
      } else {
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error delete avator: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Profile",
        onTap: () {
          Get.back();
        },
      ),
      // resizeToAvoidBottomInset: false,
      body: ExploreContainer(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  // CircleAvatar(
                  //   backgroundColor: Colors.transparent,
                  //   radius: Get.height * 0.09,
                  //   backgroundImage: _image == null
                  //       ? Image.asset(ImageAssets.mediumImage).image
                  //       : MemoryImage(_image!),
                  // ),
                  Container(
                    width: Get.height * 0.18,
                    height: Get.height * 0.18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imgurl.isEmpty
                            ? NetworkImage(ImageAssets.dummyImage)
                                as ImageProvider<Object>
                            : NetworkImage(imgurl),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Get.height * 0.01,
                    right: 5,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            pickimage();
                            // Get.to(
                            //   () => const EditAvatorProfile(),
                            //   transition: Transition.rightToLeft,
                            //   duration: const Duration(milliseconds: 300),
                            // );
                          },
                          child: SvgPicture.asset(ImageAssets.iconEdit),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MyText(
                text: username,
                fontSize: 22,
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageAssets.locationBrown,
                    color: AppColor.whiteColor,
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  MyText(
                    textDecoration: TextDecoration.underline,
                    text: address,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Padding(
              //       padding: EdgeInsets.only(left: 25.0, top: 20, bottom: 10),
              //       child: MyText(
              //         text: "Album Photos (9)",
              //         fontSize: 18,
              //       ),
              //     ),
              //
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 22.0),
              //       child: Row(
              //         children: [
              //           Stack(
              //             children: [
              //               Container(
              //                 width: 103,
              //                 height: 110,
              //                 decoration: ShapeDecoration(
              //                   image: const DecorationImage(
              //                     image: AssetImage(ImageAssets.image2),
              //                     fit: BoxFit.fill,
              //                   ),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(8)),
              //                 ),
              //               ),
              //               Positioned(
              //                 top: 5,
              //                 right: 5,
              //                 child: Container(
              //                   width: 16,
              //                   height: 16,
              //                   padding: const EdgeInsets.all(2),
              //                   decoration: const ShapeDecoration(
              //                     color: AppColor.blackColor,
              //                     shape: OvalBorder(),
              //                   ),
              //                   child: Center(
              //                     child: SvgPicture.asset(ImageAssets.deleteAc),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             width: 3,
              //           ),
              //           Stack(
              //             children: [
              //               Container(
              //                 width: 103,
              //                 height: 110,
              //                 decoration: ShapeDecoration(
              //                   image: const DecorationImage(
              //                     image: AssetImage(ImageAssets.image3),
              //                     fit: BoxFit.fill,
              //                   ),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(8)),
              //                 ),
              //               ),
              //               Positioned(
              //                 top: 5,
              //                 right: 5,
              //                 child: Container(
              //                   width: 16,
              //                   height: 16,
              //                   padding: const EdgeInsets.all(2),
              //                   decoration: const ShapeDecoration(
              //                     color: AppColor.blackColor,
              //                     shape: OvalBorder(),
              //                   ),
              //                   child: Center(
              //                     child: SvgPicture.asset(ImageAssets.deleteAc),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             width: 3,
              //           ),
              //           Stack(
              //             children: [
              //               Container(
              //                 width: 103,
              //                 height: 110,
              //                 decoration: ShapeDecoration(
              //                   image: const DecorationImage(
              //                     image: AssetImage(ImageAssets.image1),
              //                     fit: BoxFit.fill,
              //                   ),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(8)),
              //                 ),
              //               ),
              //               Positioned(
              //                 top: 5,
              //                 right: 5,
              //                 child: Container(
              //                   width: 16,
              //                   height: 16,
              //                   padding: const EdgeInsets.all(2),
              //                   decoration: const ShapeDecoration(
              //                     color: AppColor.blackColor,
              //                     shape: OvalBorder(),
              //                   ),
              //                   child: Center(
              //                     child: SvgPicture.asset(ImageAssets.deleteAc),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 15,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 22.0),
              //       child: Row(
              //         children: [
              //           Stack(
              //             children: [
              //               Container(
              //                 width: 103,
              //                 height: 110,
              //                 decoration: ShapeDecoration(
              //                   image: const DecorationImage(
              //                     image: AssetImage(ImageAssets.image2),
              //                     fit: BoxFit.fill,
              //                   ),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(8)),
              //                 ),
              //               ),
              //               Positioned(
              //                 top: 5,
              //                 right: 5,
              //                 child: Container(
              //                   width: 16,
              //                   height: 16,
              //                   padding: const EdgeInsets.all(2),
              //                   decoration: const ShapeDecoration(
              //                     color: AppColor.blackColor,
              //                     shape: OvalBorder(),
              //                   ),
              //                   child: Center(
              //                     child: SvgPicture.asset(ImageAssets.deleteAc),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             width: 3,
              //           ),
              //           Stack(
              //             children: [
              //               Container(
              //                 width: 103,
              //                 height: 110,
              //                 decoration: ShapeDecoration(
              //                   image: const DecorationImage(
              //                     image: AssetImage(ImageAssets.image3),
              //                     fit: BoxFit.fill,
              //                   ),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(8)),
              //                 ),
              //               ),
              //               Positioned(
              //                 top: 5,
              //                 right: 5,
              //                 child: Container(
              //                   width: 16,
              //                   height: 16,
              //                   padding: const EdgeInsets.all(2),
              //                   decoration: const ShapeDecoration(
              //                     color: AppColor.blackColor,
              //                     shape: OvalBorder(),
              //                   ),
              //                   child: Center(
              //                     child: SvgPicture.asset(ImageAssets.deleteAc),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(
              //             width: 3,
              //           ),
              //           Stack(
              //             children: [
              //               Container(
              //                 width: 103,
              //                 height: 110,
              //                 decoration: ShapeDecoration(
              //                   image: const DecorationImage(
              //                     image: AssetImage(ImageAssets.image1),
              //                     fit: BoxFit.fill,
              //                   ),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(8)),
              //                 ),
              //               ),
              //               Positioned(
              //                 top: 5,
              //                 right: 5,
              //                 child: Container(
              //                   width: 16,
              //                   height: 16,
              //                   padding: const EdgeInsets.all(2),
              //                   decoration: const ShapeDecoration(
              //                     color: AppColor.blackColor,
              //                     shape: OvalBorder(),
              //                   ),
              //                   child: Center(
              //                     child: SvgPicture.asset(ImageAssets.deleteAc),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 15,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 22.0),
              //       child: Row(
              //         children: [
              //           Container(
              //             width: 103,
              //             height: 110,
              //             decoration: BoxDecoration(
              //               color: AppColor.hintTextColor,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: const Icon(
              //               Icons.camera_alt_rounded,
              //               color: AppColor.primaryColor,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 3,
              //           ),
              //           Container(
              //             width: 103,
              //             height: 110,
              //             decoration: BoxDecoration(
              //               color: AppColor.hintTextColor,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: const Icon(
              //               Icons.camera_alt_rounded,
              //               color: AppColor.primaryColor,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 3,
              //           ),
              //           Container(
              //             width: 103,
              //             height: 110,
              //             decoration: BoxDecoration(
              //               color: AppColor.hintTextColor,
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: const Icon(
              //               Icons.camera_alt_rounded,
              //               color: AppColor.primaryColor,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 0, top: 20, bottom: 10),
                    child: MyText(
                      text: "Album Photos (9)",
                      fontSize: 18,
                    ),
                  ),
                  Wrap(
                    spacing: 4,
                    runSpacing: 6,
                    direction: Axis.horizontal,
                    children: List.generate(
                      9,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });

                          _pickImages(); // Call the method to pick an image
                        },
                        child: Container(
                          width: 103,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColor.hintTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              // Image or camera icon
                              Align(
                                alignment: Alignment.center,
                                child: (imagePaths.length > index &&
                                        imagePaths[index].isNotEmpty)
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            8), // Border radius for the image
                                        // child: Image.file(
                                        //   File(imagePaths[index]),
                                        //   fit: BoxFit.cover,
                                        //   width: double.infinity,
                                        // ),
                                        child: Image.network(
                                            baseUrlImage +
                                                imagePaths[index]['image'],
                                            fit: BoxFit.cover,
                                            width: double.infinity),
                                      )
                                    : const Icon(
                                        Icons.camera_alt_rounded,
                                        color: AppColor.primaryColor,
                                        // color: currentIndex == index
                                        //     ? Colors.white
                                        //     : AppColor.primaryColor,
                                      ),
                              ),
                              // Delete icon (displayed only when image is not empty)
                              if (imagePaths.length > index &&
                                  imagePaths[index].isNotEmpty)
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      removeImage(index);
                                    },
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      padding: const EdgeInsets.all(2),
                                      decoration: const ShapeDecoration(
                                        color: AppColor.blackColor,
                                        shape: OvalBorder(),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                            ImageAssets.deleteAc),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.08,
                  vertical: Get.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelField(
                      text: 'Bio',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      height: Get.height * 0.08,
                      maxLine: 2,
                      controller: bioController,
                      hintText:
                          "Sed ut perspiciatis unde omnis iste natus error sit volu accusantium",
                      prefixImage: ImageAssets.newspaper,
                      keyboardType: TextInputType.text,
                      validator: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'User Name',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: userNameController,
                      hintText: "Lubana Antique",
                      prefixImage: ImageAssets.user,
                      keyboardType: TextInputType.text,
                      validator: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'Email',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "lubanaantique@gmail.com",
                      prefixImage: ImageAssets.email,
                      keyboardType: TextInputType.text,
                      validator: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'Date of birth',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: birthController,
                      hintText: "Date of birth",
                      // focusNode: focus5,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      prefixImage: ImageAssets.birthDate,
                      suffixImage: ImageAssets.calendar,
                      suffixTap: () {
                        _selectDate(context);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'Gender',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: Get.width * 0.84,
                      height: Get.height * 0.060,
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
                      child: RoundedDropdownMenu(
                          width: MediaQuery.sizeOf(context).width * 0.85,
                          hintText: userGenderName,
                          onSelected: (p0) {
                            print(p0);
                            genderval = p0['genders_id'];
                            print('$genderval');
                          },
                          dropdownMenuEntries: genderType
                              .map(
                                (dynamic value) => DropdownMenuEntry<dynamic>(
                                    value: value, label: value['name'] ?? ''),
                              )
                              .toList()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'Education',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: educationController,
                      hintText: "Graphic Designing",
                      prefixImage: ImageAssets.education,
                      keyboardType: TextInputType.text,
                      validator: null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText(
                      text: "Interests",
                      fontSize: 18,
                    ),
                    GestureDetector(
                      onTap: () async {
                        interests = await Get.to(
                              () => InterestTags(interestList: interestList),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                            ) ??
                            [];
                        setState(() {
                          if (interests.isNotEmpty) {
                            // Assuming interests is a List, you may need to adjust accordingly
                            interestList.addAll(interests);
                          }
                        });
                        print('Selected List: $interestList');
                        // Update your UI or perform any other actions with the selectedList
                        // Initialize interestIds and interestIdsJson here
                        interestIds = interestList
                            .map((interest) => (interest['interests_tags_id']))
                            .toList();
                        interestIdsJson = interestIds;
                        print('IDs: $interestIdsJson');
                      },
                      child: SvgPicture.asset(
                        ImageAssets.iconEdit,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: 4,
                      runSpacing: 6,
                      direction: Axis.horizontal,
                      children: List.generate(
                          interestList.length,
                          (index) => Container(
                                margin: EdgeInsets.only(right: 2),
                                child: SizedBox(
                                  // width: 80,
                                  child: SmallButton(
                                    width: Get.width * 0.27,
                                    height: Get.height * 0.033,
                                    textColor: const Color(0xFFEE4433),
                                    text: interestList[index]['name'],
                                    onTap: () {},
                                  ),
                                ),
                              )),
                    ),
                    // SmallButton(
                    //   width: Get.width * 0.25,
                    //   height: Get.height * 0.033,
                    //   textColor: const Color(0xFFEE4433),
                    //   text: "Photography",
                    //   onTap: () {},
                    // ),
                    // SmallButton(
                    //   width: Get.width * 0.25,
                    //   height: Get.height * 0.033,
                    //   textColor: const Color(0xFFEE4433),
                    //   text: "Film Making",
                    //   onTap: () {},
                    // ),
                    // SmallButton(
                    //   width: Get.width * 0.25,
                    //   height: Get.height * 0.033,
                    //   textColor: const Color(0xFFEE4433),
                    //   text: "Video editing",
                    //   onTap: () {},
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              LargeButton(
                text: "Save Changes",
                onTap: () {
                  editprofile();
                },
                containerColor: AppColor.whiteColor,
                gradientColor1: AppColor.whiteColor,
                gradientColor2: AppColor.whiteColor,
                borderColor: AppColor.whiteColor,
                textColor: AppColor.secondaryColor,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void uploadprofile(image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = uploadProfile;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {"users_customers_id": userId, "image": image},
          ));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Profile update successfully')));

        setState(() {
          imgurl = baseUrlImage + data['data']['image'];
        });
      } else {}
    } catch (e) {
      print('errorfound');
    }
  }

  uploadavators(String base64image) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = uploadAvatars;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
              "name": "Avatars",
              "image": base64image
            },
          ));
      // print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        Navigator.of(context).pop();
        setState(() {
          imagePaths.add(data['data']);
          print('image path aaddd: $imagePaths');
        });
      } else {}
    } catch (e) {
      print('errorfound');
    }
  }

  getavators() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = getusersavatars;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
            },
          ));
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        imagePaths = List<Map<String, dynamic>>.from(data['data']);
        print('avators total : $imagePaths');
        setState(() {});
      } else {}
    } catch (e) {
      print('errorfound in get avators $e');
    }
  }
}
