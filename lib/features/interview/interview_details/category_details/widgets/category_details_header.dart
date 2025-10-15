import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show CircleAvatar, Colors, IconButton, Icons;
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/interview/interview_details/category_details/controller%20/category_details_controller.dart';

class CategoryDetailsHeader extends StatelessWidget {
   CategoryDetailsHeader({super.key});

  final CategoryDetailsController controller = Get.find<CategoryDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.black, 
          Color(0xFF1E7B1E), 
        ]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        
      ),
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.black.withValues(alpha:  0.3),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                   Get.back();
                  },
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(controller.img.value, 
                 height: 100,
                 width: 100,
                ),
                SizedBox(
                  height: 10,
                ), 
                Text(
                  controller.name.value, 
                 style: getTextStyle(
                  color: Colors.white, 
                  fontSize: 16, 
                  fontWeight: FontWeight.w500
                 ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}