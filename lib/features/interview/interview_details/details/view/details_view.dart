import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/interview/interview_details/details/controller/details_controller.dart';
import 'package:inprep_ai/features/interview/interview_details/details/widgets/category_list.dart' show CategoryList;
import 'package:inprep_ai/features/interview/interview_details/details/widgets/header.dart' show Header;

class DetailsView extends StatelessWidget {
   DetailsView({super.key});

  final DetailsController controller = Get.put(DetailsController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(), 
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16, 
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.title.value, 
                     style: getTextStyle(
                      color: Color(0xFF212121), 
                      fontSize: 20, 
                      fontWeight: FontWeight.w500
                     ),
                    ), 
                   SizedBox(
                    height: 5,
                   ), 
                    Text("${controller.positions.value.toString()} Positions", 
                     style: getTextStyle(
                      color: Color(0xFFAFAFAF), 
                      fontSize: 14, 
                      fontWeight: FontWeight.w400
                     ),
                    ),
                    SizedBox(
                      height: 30,
                    ), 
                    Text(
                      "Description", 
                     style: getTextStyle(
                      color: Color(0xFF212121), 
                      fontSize: 18, 
                      fontWeight: FontWeight.w500
                     ),
                    ), 
                    SizedBox(
                      height: 10,
                    ), 
                    Text(controller.description.value, 
                    textAlign: TextAlign.justify,
                     style: getTextStyle(
                      color: Color(0xFF676768), 
                      fontSize: 14, 
                      fontWeight: FontWeight.w400
                     ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CategoryList(), 
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}