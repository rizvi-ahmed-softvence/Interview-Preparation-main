import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/interview/interview_details/details/controller/details_controller.dart';

class Header extends StatelessWidget {
  Header({super.key});

  final DetailsController controller = Get.find<DetailsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(controller.image.value),
          fit: BoxFit.cover,
        ),
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
              backgroundColor: Colors.black.withValues(alpha:0.3),
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
       
        ],
      ),
    );
  }
}
