import 'package:final_project/screens/dashboard/discover/discover.dart';
import 'package:final_project/screens/dashboard/discover/event_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart';

Widget myText({text, style, textAlign}) {
  return Text(
    text,
    style: style,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
  );
}

Widget myTextField(
    {text,
    String? icon,
    bool,
    TextEditingController? controller,
    Function? validator}) {
  return Container(
    height: 45,
    child: TextFormField(
      validator: (input) => validator!(input),
      obscureText: bool,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5),
          errorStyle: TextStyle(fontSize: 0),
          hintStyle: TextStyle(
            color: AppColors.genderTextColor,
          ),
          hintText: text,
          prefixIcon: Image.asset(
            icon!,
            cacheHeight: 20,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
    ),
  );
}


Widget iconTitleContainer(
    {text,
    path,
    Function? onPress,
    bool isReadOnly = false,
    TextInputType type = TextInputType.text,
    TextEditingController? controller,
    Function? validator,
    double width = 150,
    double height = 40}) {
  return Container(
    // padding: EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 0.1, color: AppColors.genderTextColor),
    ),
    width: width,
    height: height,
    child: TextFormField(
      validator: (String? input) => validator!(input!),
      controller: controller,
      keyboardType: type,
      readOnly: isReadOnly,
      onTap: () {
        onPress!();
      },
      // style: TextStyle(
      //   fontSize: 16,
      //   fontWeight: FontWeight.w400,
      //   color: AppColors.genderTextColor,
      // ),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 0),
        contentPadding: EdgeInsets.only(top: 3),
        prefixIcon: Container(
          child: Image.asset(
            path,
            cacheHeight: 18,
          ),
        ),
        hintText: text,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.genderTextColor,
        ),
        border: isReadOnly
            ? OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffA6A6A6)),
                borderRadius: BorderRadius.circular(8))
            : OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}

Widget elevatedButton({text, Function? onpress}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.blue),
    ),
    onPressed: () {
      onpress!();
    },
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget iconWithTitle({text, Function? func, bool? isShow = true}) {
  return Row(
    children: [
      !isShow!
          ? Container()
          : Expanded(
              flex: 0,
              child: InkWell(
                onTap: () {
                  func!();
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: Get.width * 0.02,
                    top: Get.height * 0.08,
                    bottom: Get.height * 0.02,
                  ),
                  // alignment: Alignment.center,
                  width: 30,
                  height: 30,
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
      Expanded(
        flex: 6,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: Get.height * 0.056,
            // left: Get.width * 0.26,
          ),
          child: myText(
            text: text,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(''),
      )
    ],
  );
}


