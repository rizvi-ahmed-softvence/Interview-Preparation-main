import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/interview/interview_details/details/view/details_view.dart' show DetailsView;
import 'package:inprep_ai/features/personalized_interviewers/controller/personalized_interviewers_controller.dart' show PersonalizedInterviewersController;
import 'package:inprep_ai/features/subscription/screen/chooseplan_screen.dart';

class PersonalizedInterviewerScreen extends StatelessWidget {
   PersonalizedInterviewerScreen({super.key});

  final PersonalizedInterviewersController controller = Get.put(PersonalizedInterviewersController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: 65,
          left: 20, 
          right: 20, 
          bottom: 20, 
        ),
        child: Column(
          children: [
            Text("Based on your profile, these are the interviews we recommend", 
             textAlign: TextAlign.center,
             style: getTextStyle(
              color: Color(0xFF212121), 
              fontSize: 20, 
              fontWeight: FontWeight.w600
             ),
            ),
            SizedBox(
              height: 20,
            ), 
            Expanded(
        
          child: ListView.builder(
         
            padding: EdgeInsets.zero,
            itemCount: controller.availableMockInterviews.length,
            itemBuilder: (context, index){
              var availablemockinterviews = controller.availableMockInterviews[index]; 
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 12,
                ),
                child: GestureDetector(
                  onTap: (){
                   
                   if(controller.isSubscribed.value){
                      Get.to(() => DetailsView(),
                     arguments: [
                      availablemockinterviews['title'], 
                      availablemockinterviews['image'], 
                      availablemockinterviews['job_titles'], 
                      
                     ]           
                    ); 
                    debugPrint("The title is ${availablemockinterviews['title']}");
                    debugPrint("The title is ${availablemockinterviews['image']}");
                    debugPrint("The title is ${availablemockinterviews['job_titles']}");
                   } else{
                    Get.to(ChooseplanScreen()); 
                   }
    
                  
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                      12
                    ),
                     child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 68,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(availablemockinterviews['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ), 
                        SizedBox(
                          width: 5,
                        ), 
                        SizedBox(
                          width: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(availablemockinterviews['title'], 
                               style: getTextStyle(
                                color: Color(0xFF212121), 
                                fontSize: 16, 
                                fontWeight: FontWeight.w500
                               ),
                              ), 
                              SizedBox(
                                height: 5,
                              ), 
                              Text("${availablemockinterviews['job_titles'].toString()} Job Titles", 
                               style: getTextStyle(
                                color: Color(0xFFAFAFAF), 
                                fontSize: 14, 
                                fontWeight: FontWeight.w400
                               ),
                              ),
                            ],
                          ),
                        ), 
                        Spacer(), 
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xff6a329f),
                          child: Center(
                            child: Icon(Icons.arrow_forward, 
                             color: Colors.white,
                            ),
                          ),
                        )
                      ],
                     ),  
                  ),
                  ),
                ),
              ); 
            }
            ),
        ),
          ],
        ),
      ),
    );
  }
}