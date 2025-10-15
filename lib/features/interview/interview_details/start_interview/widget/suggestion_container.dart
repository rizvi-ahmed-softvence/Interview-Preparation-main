import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

class SuggestionContainer extends StatelessWidget {
  const SuggestionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFC1E9D4), 
        borderRadius: BorderRadius.circular(16)
      ),
      child: Padding(
        padding: EdgeInsets.all(12), 
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Suggestions", 
             style: getTextStyle(
                color: Color(0xff6a329f), 
                fontSize: 20, 
                fontWeight: FontWeight.w500, 
             ),
            ), 
            SizedBox(
              height: 5,
            ),
            Text('After the interview, consider practicing your body language further. While you did well with eye contact and an open posture, try to keep your arms relaxed at your sides to avoid any defensive vibes. Additionally, you might want to work on your gestures to emphasize your points more effectively. Keep up the great work!',
             textAlign: TextAlign.justify,
             style: getTextStyle(
              color: Color(0xFF174D31), 
              fontSize: 14, 
              fontWeight: FontWeight.w400,
             ),
            )
          ],
        ),
      ),
    );
  }
}