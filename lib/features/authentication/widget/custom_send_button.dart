import 'package:flutter/material.dart' show Colors, ElevatedButton;
import 'package:flutter/widgets.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart' show getTextStyle;

class CustomSendButton extends StatelessWidget {
  final String text; 
  final VoidCallback? onPressed;
  const CustomSendButton({super.key, 
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Color(0xff6a329f),
                    minimumSize: Size(double.infinity, 48),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onPressed, 
                  child: Text(
                    text,
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
  }
}