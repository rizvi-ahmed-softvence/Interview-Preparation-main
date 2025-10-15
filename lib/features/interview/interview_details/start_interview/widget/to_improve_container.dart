import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/controller/start_interview_controller.dart';

class ToImproveContainer extends StatelessWidget {
   ToImproveContainer({super.key});

  final StartInterviewController controller = Get.find<StartInterviewController>(); 

  @override
  Widget build(BuildContext context) {
    var length = controller.toImprove.length * 70; 
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
            Text("To Improve", 
             style: getTextStyle(
                color: Color(0xff6a329f), 
                fontSize: 20, 
                fontWeight: FontWeight.w500, 
             ),
            ), 
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: length.toDouble(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.toImprove.length,
                itemBuilder: (context, index){
                  var data = controller.toImprove[index]; 
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(data['title'],
                       style: getTextStyle(
                        color: Color(0xFF174D31), 
                                    fontSize: 14, 
                                    fontWeight: FontWeight.w400,
                       ),
                      ),
                    ),
                  ); 
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}