import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

class StartMockInterviewContainer extends StatelessWidget {
  final VoidCallback onTap; 
  const StartMockInterviewContainer({super.key,
   required this.onTap
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xff6a329f), 
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24, 
            vertical: 13,
          ), 
          child: Row(
            children: [
              Text("Start Mock Interview", 
               style: getTextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.w500, 
                fontSize: 16
               ),
              
              ), 
              SizedBox(
                width: 10,
              ), 
              Icon(Icons.play_arrow, 
               color: Colors.white,
               size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}