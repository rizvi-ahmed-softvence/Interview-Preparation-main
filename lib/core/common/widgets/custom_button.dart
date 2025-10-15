// import 'package:flutter/material.dart';
// import 'package:inprep_ai/core/common/styles/global_text_style.dart';

// class CustomButton1 extends StatelessWidget {
//   const CustomButton1({
//     super.key,
//     required this.title,
//     this.backgroundColor = Colors.red,
//     this.borderColor = Colors.green,
//     this.textStyle,
//     required this.onPress,
//     this.textcolor = Colors.yellowAccent,
//   });
//   final Color textcolor;
//   final String title;
//   final Color backgroundColor;
//   final Color? borderColor;
//   final TextStyle? textStyle;
//   final VoidCallback? onPress;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPress,
//       child: Center(
//         child: Container(
//           width: double.infinity,
//           height: 48,
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           decoration: BoxDecoration(
//             border: Border.all(color: borderColor ?? backgroundColor),
//             borderRadius: BorderRadius.circular(12),
//             color: backgroundColor,
//           ),
//           child: Center(
//             child: Text(
//               title,
//               style: getTextStyle(
//                 fontSize: 16,
//                 color: textcolor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

class CustomButton1 extends StatelessWidget {
  const CustomButton1({
    super.key,
    required this.title,
    this.backgroundColor = Colors.red,
    this.borderColor = Colors.deepPurpleAccent,
    this.textStyle,
    this.onPress,
    this.textcolor = Colors.yellowAccent,
    this.isLoading = false,
  });
  final Color textcolor;
  final String title;
  final Color backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final VoidCallback? onPress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Center(
        child: Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? backgroundColor),
            borderRadius: BorderRadius.circular(50),
            color: onPress == null ? backgroundColor.withValues(alpha:  0.5) : backgroundColor,
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    title,
                    style: getTextStyle(
                      fontSize: 16,
                      color: textcolor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}