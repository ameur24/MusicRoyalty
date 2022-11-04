import 'package:music_royalty/models/itemmodel.dart';

class itemmodeldummy {
  static final List<itemmodel> itemmodelslist = <itemmodel>[
    itemmodel(
      text: "SplitSheet",
      description: "Decide how much money each songwriter will get",
      thisStep: 1,
    ),
    itemmodel(
      text: "Copyright",
      description: "Register your song's copyright",
      thisStep: 2,
    ),
    itemmodel(
      text: "ISRC Code",
      description: "Get your sound recording's unique code",
      thisStep: 3,
    ),
    itemmodel(
      text: "PRO",
      description: "Get set up to collect Performance Royalties",
      thisStep: 4,
    ),
    itemmodel(
      text: "Distribution",
      description: "Sign up to Send your music to online stores!",
      thisStep: 5,
    ),
    itemmodel(
      text: "Performance Royalties (Digital)",
      description: "Collect Digital Royalties from all over the World",
      thisStep: 6,
    ),
    itemmodel(
      text: "Mechanical Royalties",
      description: "Collect Mechanical Royalties from all over the World",
      thisStep: 7,
    ),
    itemmodel(
      text: "Print Royalties",
      description: "Collect Royalties when your lyrics are reprinted",
      thisStep: 8,
    ),
    itemmodel(
      text: "Sync Licensing",
      description: "Submit your music for exciting paid opportunities!",
      thisStep: 9,
    ),
    itemmodel(
      text: "Social media and Website (optional)",
      description:
          "Set up social media accounts and website to get a bigger fanbase",
      thisStep: 10,
    )
  ];
}
