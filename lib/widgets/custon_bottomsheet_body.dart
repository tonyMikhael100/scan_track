import 'package:flutter/material.dart';
import 'package:scan_track/utils/colors_data.dart';
import 'package:scan_track/widgets/custom_elevated_button.dart';
import 'package:scan_track/widgets/custom_text_filed.dart';

class CustomBottomSheetBody extends StatelessWidget {
  const CustomBottomSheetBody({
    super.key,
    required this.height,
    required this.firtTextField,
    required this.SecondTextField,
    required this.width,
    required this.buttonText,
    required this.firstHintText,
    required this.secondHintText,
    required this.onPressed,
  });

  final double height;
  final TextEditingController firtTextField;
  final TextEditingController SecondTextField;
  final String firstHintText;
  final String secondHintText;
  final double width;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      width: double.infinity,
      height: height,
      child: Column(
        children: [
          CustomTextField(
            controller: firtTextField,
            hintText: firstHintText,
            onChanged: (value) {
              firtTextField.text = value;
            },
            isEnable: true,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: SecondTextField,
            hintText: secondHintText,
            onChanged: (value) {
              SecondTextField.text = value;
            },
            isEnable: true,
          ),
          SizedBox(
            height: 20,
          ),
          CustomElevatedButton(
            width: width,
            text: buttonText,
            bgColor: ColorsData.primaryColor,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
