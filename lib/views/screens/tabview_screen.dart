import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:resonate/controllers/auth_state_controller.dart';
import 'package:resonate/controllers/create_room_controller.dart';
import 'package:resonate/controllers/pair_chat_controller.dart';
import 'package:resonate/controllers/tabview_controller.dart';
import 'package:resonate/views/screens/discussions_screen.dart';
import 'package:resonate/views/screens/home_screen.dart';
import 'package:resonate/views/widgets/profile_avatar.dart';

import '../../controllers/email_verify_controller.dart';
import '../../utils/colors.dart';
import '../widgets/pair_chat_dialog.dart';
import 'create_room_screen.dart';

class TabViewScreen extends StatelessWidget {
  final TabViewController controller = Get.put<TabViewController>(TabViewController());
  final AuthStateController authStateController = Get.put<AuthStateController>(AuthStateController());
  final EmailVerifyController emailverifycontroller = Get.find<EmailVerifyController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            toolbarHeight: (0.068 * Get.width + 0.034 * Get.height),
            automaticallyImplyLeading: false,
            title: Text(
              "Resonate",
              style: TextStyle(color: Colors.amber, fontSize: 0.0315 * Get.width + 0.01582 * Get.height),
            ),
            centerTitle: false,
            elevation: 10,
            backgroundColor: const Color.fromRGBO(17, 17, 20, 1),
            actions: [
              profileAvatar(context),
            ],
          ),
          floatingActionButton: (controller.getIndex() != 2)
              ? SpeedDial(
                  icon: Icons.add,
                  activeIcon: Icons.close,
                  backgroundColor: AppColor.yellowColor,
                  elevation: 8.0,
                  spacing: 10,
                  spaceBetweenChildren: 6,
                  animationCurve: Curves.elasticInOut,
                  children: [
                    SpeedDialChild(
                      child: const Icon(Icons.multitrack_audio),
                      foregroundColor: AppColor.yellowColor,
                      label: "Audio Room",
                      onTap: () async {
                        await Get.delete<CreateRoomController>();
                        controller.setIndex(2);
                      },
                    ),
                    SpeedDialChild(
                      child: const Icon(Icons.people_alt_rounded),
                      foregroundColor: AppColor.yellowColor,
                      label: "Pair Chat",
                      onTap: () {
                        Get.put<PairChatController>(PairChatController());
                        buildPairChatDialog();
                      },
                    ),
                  ],
                )
              : FloatingActionButton(
                  onPressed: () async {
                    await Get.find<CreateRoomController>().createRoom();
                  },
                  backgroundColor: AppColor.yellowColor,
                  child: const Icon(Icons.done)),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            height: 0.034 * Get.height + 0.068 * Get.width,
            backgroundColor: Colors.transparent,
            activeColor: Colors.amber,
            inactiveColor: Colors.amber.withOpacity(0.5),
            splashColor: Colors.black,
            shadow: const Shadow(color: Color.fromRGBO(17, 17, 20, 1)),
            iconSize: 0.01825 * Get.height + 0.0364 * Get.width,
            icons: const [
              Icons.home_outlined,
              // Icons.person_outline, // move to the appbar and replaced with discussions icon
              Icons.chat_rounded
            ],
            notchMargin: 0.009722 * Get.width + 0.00486 * Get.height,
            activeIndex: controller.getIndex(),
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: (index) => controller.setIndex(index),
          ),
          body: (controller.getIndex() == 0)
              ? HomeScreen()
              : (controller.getIndex() == 2)
                  ? CreateRoomScreen()
                  : const DiscussionScreen(),
        ));
  }
}
