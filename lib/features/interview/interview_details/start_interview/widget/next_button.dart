import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onTap; 
  const NextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: Color(0xff6a329f), 
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Next Question",
               style: getTextStyle(
                color: Colors.white, 
                fontSize: 16, 
               ),
              ), 
              SizedBox(
                width: 5,
              ), 
              Icon(Icons.arrow_forward, 
               color: Colors.white,
               )
            ],
          ),
        ),
      ),
    );
  }
}