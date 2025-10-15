import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/navigationbar/controller/bottom_navigationbar_controller.dart';

class BottomNavbarView extends StatelessWidget {
  BottomNavbarView({super.key});

  final BottomNavbarController controller = Get.put(BottomNavbarController());

  final List<Map<String, String>> navItems = [
    {'active': IconPath.activehomeicon, 'inactive': IconPath.deactivehomeicon},
    {
      'active': IconPath.activeinterviewicon,
      'inactive': IconPath.deactiveinterviewicon,
    },
    {
      'active': IconPath.activeprogressicon,
      'inactive': IconPath.deactiveprogressicon,
    },
    {
      'active': IconPath.activeprofileicon,
      'inactive': IconPath.deactiveprofileicon,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Obx(() => controller.getCurrentScreen())),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(79),
                  child: Material(
                    elevation: 8, // Add elevation here
                    borderRadius: BorderRadius.circular(79),
                    color: Colors.transparent, // Make Material background transparent
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFffffff),
                        borderRadius: BorderRadius.circular(79),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(navItems.length, (index) {
                          return GestureDetector(
                            onTap: () => controller.changeTab(index),
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient:
                                      controller.selectedIndex.value == index
                                          ? LinearGradient(
                                              colors: [
                                                Color(0xff37BB74),
                                                Color(0xff6a329f),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            )
                                          : null,
                                ),
                                padding: EdgeInsets.all(
                                  controller.selectedIndex.value == index
                                      ? 9
                                      : 0,
                                ),
                                child: Image.asset(
                                  controller.selectedIndex.value == index
                                      ? navItems[index]['active']!
                                      : navItems[index]['inactive']!,
                                  width: 25, 
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
