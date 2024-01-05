import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Resources/assets/assets.dart';
import '../Resources/colors/colors.dart';

final kRoundedWhiteBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(40),
  borderSide: const BorderSide(
    color: Colors.white,
    width: 1,
  ),
);
final kRoundedActiveBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(40),
  borderSide: const BorderSide(
    color: Colors.blue,
    width: 1,
  ),
);

final kTextFieldBoxDecoration = BoxDecoration(
  boxShadow: const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.14),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 0),
    )
  ],
  color: Colors.white,
  borderRadius: BorderRadius.circular(40),
);
final TextStyle kTextFieldInputStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: AppColor.hintTextColor,
);
final TextStyle kTextFieldHintStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: AppColor.hintTextColor,
);
final kDropDownMenuInputDecoration = InputDecorationTheme(
  constraints: BoxConstraints(maxHeight: 46),
  contentPadding: EdgeInsets.only(left: 14),
  // border: kRoundedWhiteBorderStyle,
  // enabledBorder: kRoundedWhiteBorderStyle,
  // focusedBorder: kRoundedActiveBorderStyle,
  fillColor: Colors.white,
  labelStyle: kTextFieldInputStyle,
  filled: true,
  hintStyle: kTextFieldHintStyle,
);
final kDropDownMenuStyle = MenuStyle(
  backgroundColor: MaterialStateProperty.all(Colors.white),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(15)),
  ),
);

class RoundedDropdownMenu extends StatelessWidget {
  const RoundedDropdownMenu(
      {super.key,
      required this.onSelected,
      required this.dropdownMenuEntries,
      required this.hintText,
      // required this.leadingIconName,
      this.initialSelection,
      this.width});
  final Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<Object?>> dropdownMenuEntries;
  // final String leadingIconName;
  final String hintText;
  final double? width;
  final Object? initialSelection;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTextFieldBoxDecoration,
      child: DropdownMenu(
        menuHeight: 150,
        textStyle: kTextFieldInputStyle,
        hintText: hintText,
        trailingIcon: SvgPicture.asset(
          ImageAssets.dropDown,
        ),
        leadingIcon: SvgPicture.asset(
          ImageAssets.gender,
          fit: BoxFit.scaleDown,
        ),
        inputDecorationTheme: kDropDownMenuInputDecoration,
        menuStyle: kDropDownMenuStyle,
        width: width,
        initialSelection: initialSelection,
        onSelected: onSelected,
        dropdownMenuEntries: dropdownMenuEntries,
      ),
    );
  }
}
