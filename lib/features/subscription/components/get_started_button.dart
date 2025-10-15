import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap; 
  const GetStartedButton({super.key,
   required this.title, 
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:  Color(0xff6a329f),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 13.5
          ), 
          child: Center(
            child: Text(title, 
             style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
             ),
            ),
          ),
          
          ),
      ),
    ); 
  }
}