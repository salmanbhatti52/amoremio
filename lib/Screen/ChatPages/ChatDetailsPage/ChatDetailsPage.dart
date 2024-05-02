import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:amoremio/Screen/ChatPages/ChatDetailsPage/index.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utills/AppUrls.dart';
import 'MonitizeDialog.dart';
import 'package:get/get.dart';
import 'TextFieldSendMessage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ChatDetailsPage extends StatefulWidget {
  final String userId;
  const ChatDetailsPage({Key? key, required this.userId})
      : super(key: key);

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  final TextEditingController sendMessageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  String username = '';
  dynamic imgurl;
  List<dynamic> chatmessages = [];

  Uint8List? _image;
  File? selectedIMage;
  String base64string = '';
  String attachmentTpye = '';

  // late Record audioRecord;
  late AudioPlayer audioPlayer;
  // bool isrecoding = false;

  String audioPath = '';
  bool isShowingEmojiPicker = false;
  dynamic fileext;

  late Record audioRecord;
  Timer? timer;
  int _seconds = 0;
  bool _isTimerRunning = false;

  final StreamController<int> recordDurationController =
  StreamController<int>.broadcast()..add(0);

  Sink<int> get recordDurationInput => recordDurationController.sink;

  Stream<double> get amplitudeStream => audioRecord
      .onAmplitudeChanged(const Duration(milliseconds: 160))
      .map((amp) => amp.current);

  Stream<RecordState> get recordStateStream => audioRecord.onStateChanged();

  Stream<int> get recordDurationOutput => recordDurationController.stream;

  final ScrollController scrollControllers = ScrollController();
  List<double> amplitude = [];
  late StreamSubscription<double> amplitudeSubscription;
  double waveMaxHeight = 45;
  final double minimumAmp = -67;
  bool recording = false;
  FocusNode _focusNode = FocusNode();
  bool _isKeyboardOpen = false;


  final String _recordDirectoryName = "record_audio";
  String? _appDirPath;

  Future<String> get _getAppDirPath async {
    _appDirPath ??= (await getApplicationDocumentsDirectory()).path;
    return _appDirPath!;
  }

  Future<Directory> get getRecordsDirectory async {
    Directory recordDirectory =
    Directory(path.join((await _getAppDirPath), _recordDirectoryName));

    if (!(await recordDirectory.exists())) {
      await recordDirectory.create();
    }
    return recordDirectory;
  }

  Future<void> initializeAudioRecord() async {
    try {
      audioRecord = Record();
    } catch (e) {
      debugPrint('Error initializing audioRecord: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? recordPath = await audioRecord.stop();
      if (recordPath != null && recordPath.isNotEmpty) {
        setState(() {
          recording = false;
          audioPath = recordPath;
          debugPrint("audioPath $audioPath");
          uploadattachment(audioPath, 'voice');
        });
      }
    } catch (e) {
      debugPrint('error111111: $e');
    } finally {
      // Get.back();
      if (_isTimerRunning) {
        stopTimer();
      }
    }
  }

  Future<void> startRecording() async {
    try {
      final fileName = path.join((await getRecordsDirectory).path,
          'audio_${DateTime.now().millisecondsSinceEpoch}.m4a');
      if (await audioRecord.hasPermission()) {
        await audioRecord.start(
          path: fileName,
        );
        _isTimerRunning ? null : startTimer();
        recording = true;
      }
    } catch (e) {
      debugPrint('error111: $e');
    }
  }

  void startTimer() {
    if (_isTimerRunning) return;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        recordDurationInput.add(_seconds);
      });
    });

    setState(() {
      _isTimerRunning = true;
    });
  }

  void stopTimer() {
    if (!_isTimerRunning) return;

    timer?.cancel();
    setState(() {
      _seconds = 0;
      _isTimerRunning = false;
      recordDurationInput.add(0);
    });
  }

  String getFormattedTime() {
    int hours = _seconds ~/ 3600;
    int minutes = (_seconds % 3600) ~/ 60;
    int seconds = _seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeAudioRecord();
    amplitudeSubscription = amplitudeStream.listen((amp) {
      setState(() {
        amplitude.add(amp);
      });
      if (scrollControllers.positions.isNotEmpty) {
        scrollControllers.animateTo(
          scrollControllers.position.maxScrollExtent,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 175),
        );
      }
    });
    _focusNode.addListener(() {
      setState(() {
        _isKeyboardOpen = _focusNode.hasFocus;
      });
    });
    loaddata();
    fetchMessages();
    getGifts();
    audioPlayer = AudioPlayer();
    // audioRecord = Record();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    timer?.cancel();
    audioRecord.dispose();
    recordDurationController.close();
    amplitudeSubscription.cancel();
    _focusNode.dispose();
    // audioRecord.dispose();
    super.dispose();
  }

  bool isLoading = false;
  List getGift = [];

  getGifts() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = 'https://mio.eigix.net/apis/services/chat_gifts';
    http.Response response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "users_customers_id": userId,
          },
        ));
    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['data'] != null &&
              jsonResponse['data'] is List<dynamic>) {
            getGift = jsonResponse['data'];
            // parentMessage = jsonResponse['status'];
            debugPrint("getGift: $getGift");
            isLoading = false;
          } else {
            // parentMessage = jsonResponse['status'];
            // debugPrint("parentMessage: $parentMessage");
            isLoading = false;
          }
        } else {
          debugPrint("Response Bode::${response.body}");
          isLoading = false;
        }
      });
    }
  }

  void _scrollToBottom() {
    if (_listKey.currentContext != null) {
      Scrollable.ensureVisible(
        _listKey.currentContext!,
        alignment: 1.0,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  bool isEmojiVisible = false;

  void toggleEmojiPicker() {
    setState(() {
      FocusScope.of(context).unfocus();
      isEmojiVisible = !isEmojiVisible;
    });
  }

  void onEmojiSelected(Emoji emoji) {
    sendMessageController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: sendMessageController.text.length));
  }

  closekeyboard() {
    setState(() {
      if (isEmojiVisible == true) {
        isEmojiVisible = false;
      }
    });
  }

  void loaddata() async {
    String apiUrl = getusersProfile;
    // try {
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {"users_customers_id": widget.userId},
        ));
    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      print('user deail:::: $userdetail');
      setState(() {
        username = userdetail['data']['username'];
        imgurl = userdetail['data']['image'];
        // fetchMessages();
      });
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

  void onSendMessage(String text) async {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);
    print('Current time: $formattedTime');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print("userId $userId");
    print("others_users_customers_id ${widget.userId}");
    String apiUrl = sendChatmessages;
    var data = {
      "sender_id": userId,
      "message": text,
      "send_time": formattedTime,
      "message_type": "text"
    };
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "users_customers_id": userId,
            "others_users_customers_id": widget.userId,
            "message": text,
            "message_type": "text"
          },
        ));
    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      print(userdetail);
      setState(() {
        if (isEmojiVisible == true) {
          isEmojiVisible = false;
        }

        sendMessageController.clear();
        // Close the keyboard
        FocusScope.of(context).unfocus();
        chatmessages.add(data);
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOut,
        );
      });
    } else {
      print(userdetail['status']);
      var errormsg = userdetail['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errormsg)));
    }
  }

  Future pickimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    selectedIMage = File(pickedImage.path);
    print(selectedIMage);
    _image = selectedIMage?.readAsBytesSync();
    var base64Img =
        base64.encode(_image as List<int>); //convert bytes to base64 string
    uploadattachment(base64Img, 'image');
  }

  uploadattachment(base64, type) async {
    DateTime now = DateTime.now();
    attachmentTpye = type;
    base64string = base64;
    print('attachment type $attachmentTpye');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = sendChatmessages;
    try {
      var data1 = {
        "users_customers_id": userId, // sender_id
        "others_users_customers_id": widget.userId, //receiver_id
        "message": base64string,
        "message_type": "attachment",
        "attachment_type": "image"
      };
      var data2 = {
        "users_customers_id": userId, // sender_id
        "others_users_customers_id": widget.userId, //receiver_id
        "message": base64string,
        "message_type": "attachment",
        "attachment_type": "voice"
      };
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(attachmentTpye == 'image' ? data1 : data2));
      var userdetail = jsonDecode(response.body);
      print(userdetail);
      if (userdetail['status'] == 'success') {
        setState(() {
          // chatmessages.add(data);
          fetchMessages();
        });
      } else {
        print(userdetail['status']);
        var errormsg = userdetail['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error123456 $e');
    }
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      // Get the extension
      String? extension = result.files.single.extension;
      fileext = extension;
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<String> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> sendFileToApi(String base64String) async {
    print('base64String $base64String');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    String apiUrl = sendChatmessages;
    try {
      var data1 = {
        "users_customers_id": userId, // sender_id
        "others_users_customers_id": widget.userId, //receiver_id
        "message": base64string,
        "message_type": "attachment",
        "attachment_type": fileext
      };
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data1));
      var userdetail = jsonDecode(response.body);
      print(userdetail);
      if (userdetail['status'] == 'success') {
        setState(() {
          // chatmessages.add(data);
          fetchMessages();
          Navigator.of(context).pop();
        });
      } else {
        Navigator.of(context).pop();
        print(userdetail['status']);
        var errormsg = userdetail['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error123456 $e');
    }
  }

  Future<void> pickWordOrPdfFile() async {
    File? file = await pickFile();
    if (file != null) {
      String base64File = await fileToBase64(file);
      await sendFileToApi(base64File);
    }
  }

  Future<bool> requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  Future<void> downloadFile(String url, String fileName) async {
    // Request storage permissions
    bool hasPermission = await requestPermissions();
    if (!hasPermission) {
      print("Storage permission not granted");
      return;
    }

    // Get the application documents directory
    Directory dir = await getApplicationDocumentsDirectory();

    // Build the file path
    File file = File('${dir.path}/$fileName');

    try {
      // Download the file
      http.Response response = await http.get(Uri.parse(url));
      // Write the file
      await file.writeAsBytes(response.bodyBytes);
      print("File downloaded to ${file.path}");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File downloaded to ${file.path}")));
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  Widget _buildGiftDialog(BuildContext context) {
    return FadeInDown(
      child: Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              // width: Get.width * 0.9,
              height: Get.height * 0.42,
              decoration: BoxDecoration(
                color: const Color(0xff272727),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: Get.height * 0.35,
                    child: GridView.builder(
                      // padding: const EdgeInsets.symmetric(horizontal: 5),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                        childAspectRatio: 1 / 1.2,
                      ),
                      itemCount: getGift.length,
                      itemBuilder: (BuildContext context, int index) {

                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              String selectedGiftId = getGift[index]["gifts_id"];
                              sendChatGifts(selectedGiftId);
                            });
                          },
                          child: Column(
                            children: [
                              MyText(
                                text: getGift[index]["name"],
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.symmetric(vertical : 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: getGift[index]["image"] == null
                                        ? const NetworkImage(ImageAssets.dummyImage)
                                    as ImageProvider<Object>
                                        : NetworkImage(baseUrlImage + getGift[index]["image"]),
                                  ),
                                ),
                              ),
                              Container(
                                width : Get.width * 0.13,
                                height : Get.height * 0.022,
                                decoration:  BoxDecoration(
                                  color: const Color(0xff43aafd),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: MyText(text: "${getGift[index]["coins"]} Coins",
                                  fontSize: 8,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendChatGifts(String giftsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    String apiUrl = 'https://mio.eigix.net/apis/services/send_chat_gifts';
    try {
      var data1 = {
        "users_customers_id":userId,
        "others_users_customers_id":widget.userId,
        "gifts_id":giftsId,
      };
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data1));
      var userdetail = jsonDecode(response.body);
      print(userdetail);
      if (userdetail['status'] == 'successr') {
        setState(() {
          fetchMessages();
        });
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
        print(userdetail['status']);
        var errormsg = userdetail['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error123456 $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = getFormattedTime();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        title: Row(
          children: [
            // CircleAvatar(
            //   radius: 30,
            //   backgroundImage: Image.asset(ImageAssets.mediumImage).image,
            // ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imgurl == null
                      ? const NetworkImage(ImageAssets.dummyImage)
                          as ImageProvider<Object>
                      : NetworkImage(baseUrlImage + imgurl),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: username,
                  fontSize: 18,
                ),
                Row(
                  children: [
                    const MyText(
                      text: "Active Now",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF48FF08),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          // InkWell(
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       barrierColor: Colors.grey.withOpacity(0.9),
          //       barrierDismissible: false,
          //       builder: (BuildContext context) => Dialog(
          //         backgroundColor: Colors.transparent,
          //         alignment: Alignment.center,
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Container(
          //               width: Get.width * 0.8, //350,
          //               height: Get.height * 0.47, // 321,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               child: Column(
          //                 children: [
          //                   const SizedBox(
          //                     height: 10,
          //                   ),
          //                   Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         const SizedBox(),
          //                         GestureDetector(
          //                           onTap: () {
          //                             Get.back();
          //                           },
          //                           child: const Icon(
          //                             Icons.clear,
          //                             color: AppColor.blackColor,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   Image.asset(ImageAssets.gifts),
          //                   SizedBox(
          //                     height: Get.height * 0.02,
          //                   ),
          //                   const MyText(
          //                     text: "Congratulations!",
          //                     fontSize: 18,
          //                     color: AppColor.secondaryColor,
          //                   ),
          //                   SizedBox(
          //                     height: Get.height * 0.02,
          //                   ),
          //                   const Padding(
          //                     padding: EdgeInsets.symmetric(horizontal: 15.0),
          //                     child: MyText(
          //                       text: "Your Call duration was just 2 Mints",
          //                       fontWeight: FontWeight.w400,
          //                       fontSize: 14,
          //                       color: Color(0xFF727171),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: Get.height * 0.02,
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       SvgPicture.asset(ImageAssets.alarm),
          //                       const MyText(
          //                         text: " 1 Min",
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w500,
          //                         color: AppColor.blackColor,
          //                       ),
          //                       const Padding(
          //                         padding:
          //                             EdgeInsets.symmetric(horizontal: 8.0),
          //                         child: Icon(
          //                           CupertinoIcons.equal,
          //                           color: AppColor.blackColor,
          //                         ),
          //                       ),
          //                       SvgPicture.asset(ImageAssets.healthicons),
          //                       const MyText(
          //                         text: " 10 Coins ",
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w500,
          //                         color: AppColor.blackColor,
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: Get.height * 0.04,
          //                   ),
          //                   Container(
          //                     width: Get.width * 0.64,
          //                     height: Get.height * 0.065,
          //                     clipBehavior: Clip.antiAlias,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(30),
          //                       gradient: const LinearGradient(
          //                         colors: [
          //                           AppColor.primaryColor,
          //                           AppColor.secondaryColor,
          //                         ],
          //                         begin: Alignment(0.20, -0.98),
          //                         end: Alignment(-0.2, 0.98),
          //                       ),
          //                     ),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         SvgPicture.asset(
          //                           ImageAssets.healthicons,
          //                           width: 30,
          //                           height: 30,
          //                           color: AppColor.whiteColor,
          //                         ),
          //                         const SizedBox(
          //                           width: 15,
          //                         ),
          //                         const MyText(
          //                           text: "Send 20 Coins",
          //                           fontSize: 18,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          //   child: Container(
          //     width: 27,
          //     height: 17,
          //     decoration: ShapeDecoration(
          //       color: Colors.white,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(4)),
          //     ),
          //     child: const Center(
          //       child: MyText(
          //         text: "GIFTS",
          //         fontWeight: FontWeight.w700,
          //         fontSize: 8,
          //         color: AppColor.secondaryColor,
          //       ),
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              // showDialog(
              //   context: context,
              //   barrierColor: Colors.grey.withOpacity(0.9),
              //   barrierDismissible: false,
              //   builder: (BuildContext context) => FadeInDown(
              //     child: Dialog(
              //       backgroundColor: Colors.transparent,
              //       alignment: Alignment.center,
              //       child: Stack(
              //         clipBehavior: Clip.none,
              //         alignment: Alignment.topCenter,
              //         children: [
              //           Container(
              //             width: Get.width * 0.8, //350,
              //             height: Get.height * 0.50, // 321,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: Column(
              //               children: [
              //                 const SizedBox(
              //                   height: 10,
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.symmetric(
              //                       horizontal: 10.0),
              //                   child: Row(
              //                     mainAxisAlignment:
              //                     MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       const SizedBox(),
              //                       GestureDetector(
              //                         onTap: () {
              //                           Get.back();
              //                         },
              //                         child: const Icon(
              //                           Icons.clear,
              //                           color: AppColor.blackColor,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 Image.asset(ImageAssets.gifts),
              //                 SizedBox(
              //                   height: Get.height * 0.02,
              //                 ),
              //                 const MyText(
              //                   text: "Congratulations!",
              //                   fontSize: 18,
              //                   color: AppColor.secondaryColor,
              //                 ),
              //                 SizedBox(
              //                   height: Get.height * 0.02,
              //                 ),
              //                 const Padding(
              //                   padding:
              //                   EdgeInsets.symmetric(horizontal: 15.0),
              //                   child: MyText(
              //                     text:
              //                     "Your Call duration was just 2 Mints",
              //                     fontWeight: FontWeight.w400,
              //                     fontSize: 14,
              //                     color: Color(0xFF727171),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: Get.height * 0.025,
              //                 ),
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment:
              //                   CrossAxisAlignment.center,
              //                   children: [
              //                     SvgPicture.asset(ImageAssets.alarm),
              //                     const MyText(
              //                       text: " 1 Min",
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w500,
              //                       color: AppColor.blackColor,
              //                     ),
              //                     const Padding(
              //                       padding: EdgeInsets.symmetric(
              //                           horizontal: 8.0),
              //                       child: Icon(
              //                         CupertinoIcons.equal,
              //                         color: AppColor.blackColor,
              //                       ),
              //                     ),
              //                     SvgPicture.asset(ImageAssets.healthicons),
              //                     const MyText(
              //                       text: " 10 Coins ",
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w500,
              //                       color: AppColor.blackColor,
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(
              //                   height: Get.height * 0.025,
              //                 ),
              //                 Container(
              //                   width: Get.width * 0.64,
              //                   height: Get.height * 0.065,
              //                   clipBehavior: Clip.antiAlias,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(30),
              //                     gradient: const LinearGradient(
              //                       colors: [
              //                         AppColor.primaryColor,
              //                         AppColor.secondaryColor,
              //                       ],
              //                       begin: Alignment(0.20, -0.98),
              //                       end: Alignment(-0.2, 0.98),
              //                     ),
              //                   ),
              //                   child: Row(
              //                     mainAxisAlignment:
              //                     MainAxisAlignment.center,
              //                     children: [
              //                       SvgPicture.asset(
              //                         ImageAssets.healthicons,
              //                         width: 30,
              //                         height: 30,
              //                         color: AppColor.whiteColor,
              //                       ),
              //                       const SizedBox(
              //                         width: 15,
              //                       ),
              //                       const MyText(
              //                         text: "Send 20 Coins",
              //                         fontSize: 18,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // );
              showDialog(
                context: context,
                barrierColor: Colors.grey.withOpacity(0.9),
                barrierDismissible: false,
                builder: (BuildContext context) => _buildGiftDialog(context),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.85, -0.53),
                  end: Alignment(-0.85, 0.53),
                  colors: [Colors.white, Color(0xFFFFBFBF)],
                ),
                shape: OvalBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Center(child: SvgPicture.asset(ImageAssets.gift,),),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.grey.withOpacity(0.9),
                barrierDismissible: false,
                builder: (BuildContext context) => FadeInDown(
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    alignment: Alignment.center,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: Get.width * 0.8, //350,
                          height: Get.height * 0.38, // 321,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        color: AppColor.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              const MyText(
                                text: "Opps!",
                                fontSize: 18,
                                color: AppColor.secondaryColor,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              SvgPicture.asset(ImageAssets.coins),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: MyText(
                                  text:
                                      "You don’t have enough coins to make a call.",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xFF727171),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.025,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.grey.withOpacity(0.9),
                                    barrierDismissible: false,
                                    builder: (BuildContext context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            width: Get.width * 0.8, //350,
                                            height: Get.height * 0.35, // 321,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const SizedBox(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: const Icon(
                                                          Icons.clear,
                                                          color: AppColor
                                                              .blackColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                const MyText(
                                                  text: "Call Request",
                                                  fontSize: 18,
                                                  color:
                                                      AppColor.secondaryColor,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                                  child: MyText(
                                                    text:
                                                        "Do you really want to make the video call.",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color(0xFF727171),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        ImageAssets.alarm),
                                                    const MyText(
                                                      text: " 1 Min",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor.blackColor,
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      child: Icon(
                                                        CupertinoIcons.equal,
                                                        color:
                                                            AppColor.blackColor,
                                                      ),
                                                    ),
                                                    SvgPicture.asset(ImageAssets
                                                        .healthicons),
                                                    const MyText(
                                                      text: " 10 Coins ",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColor.blackColor,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: Get.width * 0.6,
                                                    height: Get.height * 0.065,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          AppColor.primaryColor,
                                                          AppColor
                                                              .secondaryColor,
                                                        ],
                                                        begin: Alignment(
                                                            0.20, -0.98),
                                                        end: Alignment(
                                                            -0.2, 0.98),
                                                      ),
                                                    ),
                                                    child: const Center(
                                                      child: MyText(
                                                        text: "Yes",
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: -28,
                                            child: Image.asset(
                                              ImageAssets.mediumImage,
                                            ),
                                          ),
                                          Positioned(
                                            top: 15,
                                            left: Get.width * 0.42,
                                            child: SvgPicture.asset(
                                              ImageAssets.video,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(
                                          () => IndexPage(),
                                    );
                                  },
                                  child: Container(
                                    width: Get.width * 0.64,
                                    height: Get.height * 0.065,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColor.primaryColor,
                                          AppColor.secondaryColor,
                                        ],
                                        begin: Alignment(0.20, -0.98),
                                        end: Alignment(-0.2, 0.98),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          ImageAssets.healthicons,
                                          width: 30,
                                          height: 30,
                                          color: AppColor.whiteColor,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const MyText(
                                          text: "Buy Coins",
                                          fontSize: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -28,
                          child: Image.asset(
                            ImageAssets.mediumImage,
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: Get.width * 0.42,
                          child: SvgPicture.asset(
                            ImageAssets.video,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              ImageAssets.video,
              color: AppColor.whiteColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 22.0, top: 50),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.17,
                        padding: const EdgeInsets.only(left: 3),
                        clipBehavior: Clip.antiAlias,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              bottomLeft: Radius.circular(13),
                              bottomRight: Radius.circular(13),
                            ),
                          ),
                        ),
                        // Customize the dialog background color
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.mute, width: 20),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const MyText(
                                    text: "Mute",
                                    color: AppColor.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //     showDialog(
                            //         context: context,
                            //         barrierColor: Colors.grey.withOpacity(0.9),
                            //         barrierDismissible: false,
                            //         builder: (BuildContext context) =>
                            //             const MonitizeDialog());
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(top: 12),
                            //     child: Row(
                            //       children: [
                            //         SvgPicture.asset(ImageAssets.dollar,
                            //             width: 20),
                            //         const SizedBox(
                            //           width: 6,
                            //         ),
                            //         const MyText(
                            //           text: "Monetize",
                            //           color: AppColor.blackColor,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w400,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.report,
                                      width: 20),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const MyText(
                                    text: "Report",
                                    color: AppColor.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.blocked,
                                      width: 20),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const MyText(
                                    text: "Block",
                                    color: AppColor.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.more_vert_rounded,
              color: AppColor.whiteColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (isEmojiVisible == true) {
            isEmojiVisible = false;
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                child: Column(
                  children: [
                    SizedBox(
                      child: ListView.builder(
                        // key: _listKey,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // controller: scrollController,
                        itemCount: chatmessages.length,
                        // reverse: true,
                        itemBuilder: (context, index) {
                          // int reverseIndex = chatmessages.length - 1 - index;
                          Map<String, dynamic> message = chatmessages[index];
                          bool isSentMessage = message['sender_id'] != widget.userId;
                          return Align(
                            alignment: isSentMessage
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: isSentMessage
                                  ? const ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 24,
                                          offset: Offset(0, 0),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    )
                                  : const ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(0.20, -0.98),
                                        end: Alignment(-0.2, 0.98),
                                        colors: [
                                          Color(0xFFDA286F),
                                          Color(0xFFEE4433)
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 24,
                                          offset: Offset(0, 0),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  message['attachment_type'] == null && message['message_type'] != "gift"
                                      ? Text(
                                          message['message'],
                                          style: TextStyle(
                                            color: isSentMessage
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        )
                                      : const SizedBox(),
                                  message['attachment_type'] == null && message['message_type'] == "gift"
                                      ? Row(
                                    children: [
                                      Image.network(
                                        baseUrlImage + message['gift_icon'],
                                        width: 40,
                                        height: 40,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: SizedBox(
                                                width: 5,
                                                height: 5,
                                                child: CircularProgressIndicator(
                                                  value:
                                                  loadingProgress.expectedTotalBytes !=
                                                      null
                                                      ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      Text(
                                        message['message'],
                                        style: TextStyle(
                                          color: isSentMessage
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                      : const SizedBox(),
                                  message['attachment_type'] == 'image'
                                      ? Image.network(
                                          baseUrlImage + message['message'],
                                          width: 100,
                                          height: 100,
                                        )
                                      : const SizedBox(),
                                  message['attachment_type'] == 'pdf'
                                      ? GestureDetector(
                                          onTap: () {
                                            downloadFile(
                                                baseUrlImage +
                                                    message['message'],
                                                'downloadedFile.pdf');
                                          },
                                          child: Image.asset(
                                            'assets/images/pdf.png',
                                            width: 100,
                                            height: 100,
                                          ),
                                        )
                                      : const SizedBox(),
                                  message['attachment_type'] == 'docx' ||
                                          message['attachment_type'] == 'docx'
                                      ? GestureDetector(
                                          onTap: () {
                                            downloadFile(
                                                baseUrlImage +
                                                    message['message'],
                                                'downloadedDocument.docx');
                                          },
                                          child: Image.asset(
                                            'assets/images/word.jpeg',
                                            width: 100,
                                            height: 100,
                                          ),
                                        )
                                      : const SizedBox(),
                                  message['attachment_type'] == 'voice'
                                      ? VoiceNotePlayer(
                                        audioUrl: baseUrlImage +
                                            message['message'],
                                      )
                                      : const SizedBox(),
                                  // const SizedBox(height: 4.0),
                                  Text(
                                    message['send_time'],
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: isSentMessage
                                            ? const Color(0xFF9C9C9C)
                                            : Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Row(
                  children: <Widget>[
                  isRecording == false ?
                    sendMessageTextFields(
                      sendMessageFormKey,
                      focusNode: _focusNode,
                      context: context,
                      sendMessageController,
                      onSendMessage: onSendMessage,
                      onCameraIconClick: pickimage,
                      scrollController: scrollController,
                      isEmojiVisible: isEmojiVisible,
                      toggleEmojiPicker: toggleEmojiPicker,
                      closekeyboard: closekeyboard,
                      pickWordOrPdfFile: pickWordOrPdfFile,
                      listKey: _listKey,
                    )
                      : SizedBox(
                height: waveMaxHeight,
                width: Get.width * 0.8,
                child: ListView.builder(
                  controller: scrollControllers,
                  itemCount: amplitude.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemExtent: 6,
                  itemBuilder: (context, index) {
                    double amplitudes =
                    amplitude[index].clamp(minimumAmp + 1, 0);
                    double ampPercentage = 1 - (amplitudes / minimumAmp).abs();
                    double waveHeight = waveMaxHeight * ampPercentage;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Center(
                        child: TweenAnimationBuilder(
                          tween: Tween(begin: 0, end: waveHeight),
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.decelerate,
                          builder: (context, animatedWaveHeight, child) {
                            return SizedBox(
                              height: animatedWaveHeight.toDouble(),
                              width: 8,
                              child: child,
                            );
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
                    const SizedBox(width: 05),
                    if(isRecording == false)
                    Visibility(
                      visible: _isKeyboardOpen || isEmojiVisible,
                      child: Container(
                        width: 40,
                        height: 40,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(31),
                        ),
                        child: FloatingActionButton(
                          onPressed: () async {
                            onSendMessage(sendMessageController.text);
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          child: const Icon(
                            Icons.send,
                            size: 25,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 05),
                    Visibility(
                      visible: !_isKeyboardOpen && !isEmojiVisible,
                      child: Container(
                        width: 48,
                        height: 48,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(31),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                             await audioRecord.hasPermission();
                          },
                          onLongPressStart: (_) async {
                            setState(() {
                              startrecording();
                              isRecording = true;
                            });
                          },
                          onLongPressEnd: (_) {
                            setState(() {
                              stoprecording();
                              isRecording = false;
                            });
                          },
                          // onPressed: () async {
                          //   _showRecordingModal(context);
                          // },
                          // backgroundColor: Colors.transparent,
                          // elevation: 0,
                          child: const Icon(
                            Icons.mic,
                            size: 30,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(isRecording == false)
            if (isEmojiVisible)
              SizedBox(
                height: 200,
                child: EmojiPicker(
                  textEditingController: sendMessageController,
                  config: Config(
                    columns: 7,
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    recentTabBehavior: RecentTabBehavior.RECENT,
                    recentsLimit: 28,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    loadingIndicator: const SizedBox.shrink(),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  fetchMessages() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(child: CircularProgressIndicator());
    //     });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');

    try {
      String apiUrl = getChatmessages;
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
              "others_users_customers_id": widget.userId
            },
          ));
      var data = jsonDecode(response.body);
      // print(data);
      if (data['status'] == 'success') {
        setState(() {
          chatmessages = data['data'];
          print(chatmessages);
          // Navigator.of(context).pop();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (scrollController.hasClients) {
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
            }
          });
        });
      } else {
        print(data['status']);
        var errormsg = data['message'];
        // Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error123456');
    }
  }
  bool isRecording = false;
  // void _showRecordingModal(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext bc) {
  //       bool isRecording = false; // Local variable to track recording state
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: <Widget>[
  //                   // Start Button
  //                   ElevatedButton.icon(
  //                     onPressed: () {
  //                       setState(() {
  //                         startrecording();
  //                         isRecording = true;
  //                       });
  //                     },
  //                     icon: const Icon(Icons.play_arrow),
  //                     label: const Text("Start"),
  //                   ),
  //                   // Stop Button
  //                   ElevatedButton.icon(
  //                     onPressed: () {
  //                       setState(() {
  //                         stoprecording();
  //                         isRecording = false;
  //                       });
  //                     },
  //                     icon: const Icon(Icons.stop),
  //                     label: const Text("Stop"),
  //                   ),
  //                 ],
  //               ),
  //               // Display the message here when recording
  //               if (isRecording)
  //                 const Padding(
  //                   padding: EdgeInsets.only(top: 20),
  //                   child: Text("Recording is in process...."),
  //                 ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  bool isrecoding = false;
  Future<void> startrecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        // Start recording to file
        await audioRecord.start();
        setState(() {
          isrecoding = true;
        });
      }
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> stoprecording() async {
    try {
      // Stop recording
      String? path = await audioRecord.stop();
      print('recording path $path');

      if (path != null) {
        // Read the file as a byte array
        final bytes = File(path).readAsBytesSync();

        // Convert the byte array to a Base64 string
        String base64String = base64Encode(bytes);
        print('Base64 String: $base64String');

        setState(() {
          isrecoding = false;
          audioPath = base64String; // Store the Base64 string
          uploadattachment(audioPath, 'voice');
        });
      }
    } catch (e) {
      print('error: $e');
    }
    // Navigator.pop(context);
  }

  Future<void> playrecording() async {
    try {
      Source urlsource = UrlSource(audioPath);
      await audioPlayer.play(urlsource);

      // Wait for 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      // Get the duration
      Duration? duration = await audioPlayer.getDuration();

      if (duration != null) {
        print('Audio duration: $duration');
      } else {
        print('Unable to retrieve audio duration.');
      }
    } catch (e) {
      print('error: $e');
    }
  }

}

class VoiceNotePlayer extends StatefulWidget {
  final String audioUrl;

  const VoiceNotePlayer({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _VoiceNotePlayerState createState() => _VoiceNotePlayerState();
}

class _VoiceNotePlayerState extends State<VoiceNotePlayer> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    debugPrint('urllll ${widget.audioUrl}');
    audioPlayer = AudioPlayer();

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() => duration = newDuration);
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() => position = newPosition);
    });

    // Listen to state changes
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        // Reset the position when playback is completed
        setState(() {
          position = Duration.zero;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      if (position == duration) {
        // Reset position if audio has finished playing
        audioPlayer.seek(Duration.zero);
      }
      await audioPlayer.play(UrlSource(widget.audioUrl));
    }
    setState(() => isPlaying = !isPlaying);
  }

  void seek(Duration newPosition) {
    audioPlayer.seek(newPosition);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.55,
      height: Get.height * 0.04,
      child: Row(
        children: [
          GestureDetector(
            onTap: togglePlayPause,
            child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              ),
          ),
          SizedBox(
            width: Get.width * 0.38,
            child: Slider(
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              onChanged: (value) {
                seek(Duration(seconds: value.toInt()));
              },
            ),
          ),
          Text(isPlaying ? formatDuration(position) : formatDuration(duration)),
          // Text(
          //     '${position.toString().split('.').first} / ${duration.toString().split('.').first}'),
        ],
      ),
    );
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  final double offsetX; // Horizontal offset
  final double offsetY; // Vertical offset (increase this value to move FAB up)

  CustomFabLocation(this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;
    double offsetYWithSnackbar = offsetY;

    // Adjust the offset if a SnackBar is visible
    if (snackBarHeight > 0) {
      offsetYWithSnackbar += snackBarHeight;
    }

    // Calculate the offset for X and Y
    final Offset offset = Offset(
        (scaffoldGeometry.scaffoldSize.width - fabWidth) / 2 + offsetX,
        contentBottom - fabHeight - offsetYWithSnackbar);
    return offset;
  }
}
