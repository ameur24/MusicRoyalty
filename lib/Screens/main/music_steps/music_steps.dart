import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_royalty/Screens/main/music_steps/step_info.dart';
import 'package:music_royalty/Widgets/Texts/big_text.dart';
import 'package:music_royalty/models/music.dart';

import '../../../Utils/colors.dart';
import '../../../controllers/music_controller.dart';
import '../mymusic.dart';

class musicSteps extends GetView<MusicController> {
  final Music thisMusic;
  musicSteps(this.thisMusic, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MusicController controller = Get.find();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    //int current = 1 + controller.mu.currentStep!;
    return Scaffold(
      backgroundColor: MyColors.blackbackground1,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.to(() => const myMusic()),
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: MyColors.blackbackground1,
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
              child: SongName(screenHeight)),
          Steps(screenHeight, screenWidth, thisMusic.currentStep! + 1),
        ],
      ),
    );
  }

  Widget SongName(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenHeight * .05,
        ),
        Text(
          "Music name",
          style: TextStyle(
              fontFamily: "Exo-Medium", color: Colors.white, fontSize: 12),
        ),
        SizedBox(
          height: screenHeight * 0.005,
        ),
        Text(
          thisMusic.Title!,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: MyColors.MainYellow,
              fontFamily: 'Exo-ExtraBold',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2),
        ),
        SizedBox(
          height: screenHeight * .015,
        ),
        Text(
          "Now that you have recorded your music , here are the next steps",
          style: TextStyle(
              fontFamily: "Exo-Medium", color: Colors.white, fontSize: 14),
        ),
        SizedBox(
          height: screenHeight * .03,
        )
      ],
    );
  }

  Widget Steps(double h, w, int current) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: h * .03,
          ),
          Item(
              text: "SplitSheet",
              description: "Decide how much money each songwriter will get",
              thisStep: 1,
              current: current),
          Item(
              text: "Copyright",
              description: "Register your song's copyright",
              thisStep: 2,
              current: current),
          Item(
              text: "ISRC Code",
              description: "Get your sound recording's unique code",
              thisStep: 3,
              current: current),
          Item(
              text: "PRO",
              description: "Get set up to collect Performance Royalties",
              thisStep: 4,
              current: current),
          Item(
              text: "Distribution",
              description: "Sign up to Send your music to online stores!",
              thisStep: 5,
              current: current),
          Item(
              text: "Performance Royalties (Digital)",
              description: "Collect Digital Royalties from all over the World",
              thisStep: 6,
              current: current),
          Item(
              text: "Mechanical Royalties",
              description:
                  "Collect Mechanical Royalties from all over the World",
              thisStep: 7,
              current: current),
          Item(
              text: "Print Royalties",
              description: "Collect Royalties when your lyrics are reprinted",
              thisStep: 8,
              current: current),
          Item(
              text: "Sync Licensing",
              description: "Submit your music for exciting paid opportunities!",
              thisStep: 9,
              current: current),
          Item(
              text: "Social media and Website (optional)",
              description:
                  "Set up social media accounts and website to get a bigger fanbase",
              thisStep: 10,
              current: current),
        ],
      ),
    );
  }

  Widget Item(
      {required String text,
      description,
      required final int current,
      required final int thisStep,
      final Function? onTafp,
      final bool isSelected = false}) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
          tileColor: Colors.transparent,
          minVerticalPadding: 20,
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: current == thisStep
                    ? MyColors.MainYellow
                    : current > thisStep
                        ? MyColors.completedLine
                        : MyColors.blackbackground1,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: current > thisStep
                      ? MyColors.completedFill
                      : MyColors.blackbackground1,
                  child: Icon(
                    current > thisStep ? Icons.check : Icons.article_outlined,
                    color: current == thisStep
                        ? MyColors.MainYellow
                        : current > thisStep
                            ? Colors.black
                            : MyColors.NotCompletedStep,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Step $thisStep",
                style: TextStyle(
                    fontFamily: current >= thisStep ? 'Exo-Bold' : 'Exo',
                    fontSize: 12,
                    color: current == thisStep
                        ? MyColors.MainYellow
                        : current > thisStep
                            ? MyColors.completedFill
                            : MyColors.NotCompletedStepText),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                    fontFamily: 'Exo-Bold', fontSize: 14, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                description,
                style: TextStyle(
                    fontFamily: 'Exo', fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          onTap: () => Get.to(StepInfo(thisMusic),
              arguments: {"StepTitle": text, "id": thisStep})),
    );
  }
}
