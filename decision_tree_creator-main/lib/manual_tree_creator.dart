import 'package:decision_tree_creator/tree_creator.dart';

class ManualTreeCreator {
  ManualTreeCreator._(); //Private constructor since this is utility class

  static createHandPainTree() async {
    String shortTreeName = "Hand Pain";
    String longTreeName = "General Hand Pain";
    String treePictureUrl = "https://i.imgur.com/zQ0k4JJ.jpg";
    String treeDescription = "General hand pain.";

    String question1 = "History of Previous Surgery?";
    String question3 = "Pain near Volar(palm side) base of finger?";
    String question4 =
        "Fever, puncture wound, drainage or other signs/symptoms" +
            "to suggest infection?";
    String question6 =
        "Pain with range of motion of specific joint or whole finger?";
    String question7 =
        "Palpable thick curls in finger/palm or nodules in palm?";
    String question9 =
        "Resting flexed posture of finger, swelling of whole finger" +
            " or pain with palpation of palm side of finger";
    String question11 =
        "Catching,clicking, or locking of finger with active range" +
            " of motion?";

    final treeId = await TreeCreator.createTree(
      shortTreeName: shortTreeName,
      longTreeName: longTreeName,
      treeDescription: treeDescription,
      pictureUrl: treePictureUrl,
    );
    String node1ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question1,
    );
    await TreeCreator.setRootNode(treeId: treeId, rootNodeId: node1ID);
    String node2ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      parentNodeId: node1ID,
      parentOptionText: "Yes",
      result: "Switch To Painful Hardware",
    );
    String node3ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question3,
      parentNodeId: node1ID,
      parentOptionText: "No",
    );
    String node4ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question4,
      parentNodeId: node3ID,
      parentOptionText: "Yes",
    );
    String node5ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      parentNodeId: node3ID,
      parentOptionText: "No",
      result: "Consider other etiologics",
    );
    String node6ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question6,
      parentNodeId: node4ID,
      parentOptionText: "Yes",
    );
    String node7ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question7,
      parentNodeId: node4ID,
      parentOptionText: "No",
    );
    String node8ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      parentNodeId: node6ID,
      parentOptionText: "Specific Joint",
      result: "Possible septic interphalangal unit or metacarpophalangal joint",
    );
    String node9ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question9,
      parentNodeId: node6ID,
      parentOptionText: "Whole Finger",
    );
    String node10ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node7ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely Dupuytren's contracture",
    );
    String node11ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question11,
      parentNodeId: node7ID,
      parentOptionText: "No",
    );
    await TreeCreator.linkAdditionalNodes(
      parentTreeId: treeId,
      parentNodeId: node9ID,
      childTreeId: treeId,
      childNodeId: node8ID,
      parentOptionText: "No",
    );
    String node12ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node9ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Pyogenic (suppurative) flexor tenosynovitis",
    );
    String node13ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node11ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely Trigger Finger",
    );
    String node14ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node11ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Possible Trigger Finger",
    );
  }

  static createPainfulHardwareTree() async {
    const shortTreeName = "General Pain";
    const longTreeName = "Pain in hand or arm";
    const treeDescription = "ArmPain|ElbowPain|ForearmPain|WristPain|HandPain";
    const treePictureUrl = "https://i.imgur.com/B7JidFB.jpg";

    String question1 = "History of Previous Surgery?";
    String question2 =
        "Happen suddenly with fall collision, accident, or other trauma?";
    String question5 =
        "Instability on physical exam or fracture, hardware failure, or loosening on radiographs?";
    String question7 =
        "Prosthetic joint in place (e.g. total shoulder replacement or total wrist replacement)?";
    String question9 =
        "Greater than 1 year since surgery and any previous fractures are healed?";

    final treeId = await TreeCreator.createTree(
      shortTreeName: shortTreeName,
      longTreeName: longTreeName,
      treeDescription: treeDescription,
      pictureUrl: treePictureUrl,
    );

    String node1ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question1,
    );
    await TreeCreator.setRootNode(treeId: treeId, rootNodeId: node1ID);
    String node2ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question2,
      parentNodeId: node1ID,
      parentOptionText: "Yes",
    );
    String node3ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node1ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Consider other etiologics",
    );
    String node4ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node2ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "SwitchToHandFractureTrauma",
    );
    String node5ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question5,
      parentNodeId: node2ID,
      parentOptionText: "No",
    );
    String node6ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node5ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely peri-implant fracture or hardware failure",
    );
    String node7ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question7,
      parentNodeId: node5ID,
      parentOptionText: "No",
    );
    String node8ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node7ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Possible prosthetic joint infection",
    );
    String node9ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question9,
      parentNodeId: node7ID,
      parentOptionText: "No",
    );
    String node10ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node9ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely late painful hardware",
    );
    String node11ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node9ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Painful -> Likely early hardware",
    );
  }

  static createThumbOrRadialWristPainTree() async {
    const shortTreeName = "Thumb or Wrist Pain";
    const longTreeName = "Thumb or Radial Wrist Pain";
    const treeDescription = "Pain on the thumb or wrist.";
    const pictureUrl = "https://i.imgur.com/XqwmxLQ.jpg";

    String question1 = "History of Previous Surgery?";
    String question3 = "Pain at thumb or radial side of wrist?";
    String question5 =
        "Happen suddenly with fall, collision,accident or other trauma?";
    String question7 =
        "Unable to flex thumb suddenly and no active thumb flexion?";
    String question9 =
        "Unable to extend thumb suddenly and no active thumb extension?";
    String question11 =
        "Feeling of instability at thumb and laxity of thumb with passive radial deviation of thumb?";
    String question13 =
        "Visible or palpable mass on thumb, other fingers, hand, or wrist?";
    String question15 = "Where is the tenderness?";
    String question18 =
        "Pain reproduced with passive thumb/wrist ulnar deviation?";
    String question21 =
        "Pain with axial loading of thumb and radiographs of thumb show carpometacarpal arthritis?";

    final treeId = await TreeCreator.createTree(
      shortTreeName: shortTreeName,
      longTreeName: longTreeName,
      treeDescription: treeDescription,
      pictureUrl: pictureUrl,
    );
    String node1ID = await TreeCreator.createTreeNode(
        treeId: treeId, isResult: false, question: question1);
    await TreeCreator.setRootNode(treeId: treeId, rootNodeId: node1ID);
    String node2ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node1ID,
      parentOptionText: "Yes",
      pictureUrl: pictureUrl,
      result: "Use painful hardware decision tree",
    );
    String node3ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question3,
      parentNodeId: node1ID,
      parentOptionText: "No",
    );
    String node4ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node3ID,
      parentOptionText: "No",
      pictureUrl: pictureUrl,
      result: "Consider other etiologies",
    );
    String node5ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question5,
      parentNodeId: node3ID,
      parentOptionText: "Yes",
    );
    String node6ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node5ID,
      parentOptionText: "Yes",
      pictureUrl: pictureUrl,
      result: "Use hand trauma/fracture diagnosis tree",
    );
    String node7ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question7,
      parentNodeId: node5ID,
      parentOptionText: "No",
    );
    String node8ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node7ID,
      parentOptionText: "Yes",
      pictureUrl: pictureUrl,
      result: "Possible thumb flexor tendon rupture",
    );
    String node9ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question9,
      parentNodeId: node7ID,
      parentOptionText: "No",
    );
    String node10ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node9ID,
      parentOptionText: "Yes",
      pictureUrl: pictureUrl,
      result: "Possible thumb extensor tendon rupture",
    );
    String node11ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question11,
      parentNodeId: node9ID,
      parentOptionText: "No",
    );
    String node12ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node11ID,
      parentOptionText: "Yes",
      pictureUrl: pictureUrl,
      result: "Possible UCL tear of thumb",
    );
    String node13ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question13,
      parentNodeId: node11ID,
      parentOptionText: "No",
    );
    String node14ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node13ID,
      parentOptionText: "Yes",
      pictureUrl: pictureUrl,
      result: "Use mucuous/ganglion cyst diagnosis tree",
    );
    String node15ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question15,
      parentNodeId: node13ID,
      parentOptionText: "No",
    );
    String node16ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node15ID,
      parentOptionText: "At wrist flexor tendon",
      pictureUrl: pictureUrl,
      result: "Likely flexor carpi radialis tendonitis",
    );
    String node17ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node15ID,
      parentOptionText: "At volar(palm side) base of thumb",
      pictureUrl: pictureUrl,
      result: "Use Trigger Finger diagnosis tree",
    );
    String node18ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question18,
      parentNodeId: node15ID,
      parentOptionText: "At radial side of wrist",
    );
    String node19ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node18ID,
      parentOptionText: "Yes",
      pictureUrl: pictureUrl,
      result: "Likely De Quervain's syndrome",
    );
    String node20ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node18ID,
      parentOptionText: "No",
      pictureUrl: pictureUrl,
      result: "Possibly De Quervain's syndrome",
    );
    String node21ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question21,
      parentNodeId: node15ID,
      parentOptionText: "Globally in base thumb",
    );
    String node22ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node21ID,
      parentOptionText: "Yes",
      pictureUrl: pictureUrl,
      result: "Likely CMC CA",
    );
    String node23ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node21ID,
      parentOptionText: "No",
      pictureUrl: pictureUrl,
      result: "Consider other etiologics",
    );
  }

  static createWristPainTree() async {
    const shortTreeName = "Pain with Trauma";
    const longTreeName = "Hand or Wrist Pain with Trauma";
    const treeDescription = "Hand or wrist pain with trauma.";
    const pictureUrl = "https://i.imgur.com/HCPyPMx.jpg";

    String question1 =
        "Happen suddenly with fall, collision, accident or other trauma?";
    String question2 = "Where is the pain?";
    String question3 = "Pain or tenderness at which location?";
    String question4 = "Which finger region is affected?";
    String question5 = "Which wrist region is affected?";

    final treeId = await TreeCreator.createTree(
      shortTreeName: shortTreeName,
      longTreeName: longTreeName,
      treeDescription: treeDescription,
      pictureUrl: pictureUrl,
    );
    String node1ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question1,
    );
    await TreeCreator.setRootNode(treeId: treeId, rootNodeId: node1ID);
    String node2ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question2,
      parentNodeId: node1ID,
      parentOptionText: "Yes",
    );
    String node3ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node1ID,
      parentOptionText: "No",
      pictureUrl: pictureUrl,
      result: "Consider degenerative etiology",
    );
    String node4ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question3,
      parentNodeId: node2ID,
      parentOptionText: "Thumb",
    );
    String node5ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question3,
      parentNodeId: node2ID,
      parentOptionText: "Index finger",
    );
    await TreeCreator.linkAdditionalNodes(
      parentTreeId: treeId,
      parentNodeId: node2ID,
      childTreeId: treeId,
      childNodeId: node5ID,
      parentOptionText: "Middle finger",
    );
    await TreeCreator.linkAdditionalNodes(
      parentTreeId: treeId,
      parentNodeId: node2ID,
      childTreeId: treeId,
      childNodeId: node5ID,
      parentOptionText: "Ring finger",
    );
    await TreeCreator.linkAdditionalNodes(
      parentTreeId: treeId,
      parentNodeId: node2ID,
      childTreeId: treeId,
      childNodeId: node5ID,
      parentOptionText: "Small finger",
    );
    String node6ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question4,
      parentNodeId: node2ID,
      parentOptionText: "Between fingers and wrist",
    );
    String node7ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question5,
      parentNodeId: node2ID,
      parentOptionText: "Wrist",
    );
    String node8ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node4ID,
      parentOptionText: "Distal to Interphalangeal Joint",
      pictureUrl: pictureUrl,
      result: "Likely thumb distal phalange fracture",
    );
    String node9ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node4ID,
      parentOptionText: "At interphalangeal joint",
      pictureUrl: pictureUrl,
      result: "Likely thumb interphalangeal joint dislocation",
    );
    String node10ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node4ID,
      parentOptionText:
          "Between interphalangeal joint and metacarpophalangeal joint",
      pictureUrl: pictureUrl,
      result: "Likely thumb proximal phalanx fracture",
    );
    String node11ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node4ID,
      parentOptionText: "At metacarpophalangeal joint",
      pictureUrl: pictureUrl,
      result: "Likely thumb metacarpophalangeal joint dislocation",
    );
    String node12ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node4ID,
      parentOptionText:
          "Between metacarpophalangeal joint and carpometacarpal joint",
      pictureUrl: pictureUrl,
      result: "Likely thumb metacarpal fracture",
    );
    String node13ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node5ID,
      parentOptionText: "Distal to DIP joint",
      pictureUrl: pictureUrl,
      result: "Likely distal phalanx fracture",
    );
    String node14ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node5ID,
      parentOptionText: "At DIP joint",
      pictureUrl: pictureUrl,
      result: "Likely DIP joint dislocation",
    );
    String node15ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node5ID,
      parentOptionText: "Between DIP joint and PIP joint",
      pictureUrl: pictureUrl,
      result: "Likely middle phalanx fracture",
    );
    String node16ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node5ID,
      parentOptionText: "At PIP joint",
      pictureUrl: pictureUrl,
      result: "Likely PIP joint dislocation",
    );
    String node17ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node5ID,
      parentOptionText: "Between PIP joint and MCP joint",
      pictureUrl: pictureUrl,
      result: "Likely proximal phalanx fracture",
    );
    String node18ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node5ID,
      parentOptionText: "At metacarpophalangeal joint",
      pictureUrl: pictureUrl,
      result: "Likely  metacarpophalangeal joint dislocation",
    );
    String node19ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node6ID,
      parentOptionText: "Inline with index finger or middle finger",
      pictureUrl: pictureUrl,
      result: "Likely  metacarpal fracture at index or middle finger",
    );
    String node20ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node6ID,
      parentOptionText: "Inline with ring finger or small finger",
      pictureUrl: pictureUrl,
      result: "Likely  metacarpal fracture at ring or small finger",
    );
    String node21ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node7ID,
      parentOptionText: "Near base of thumb at anatomical snuffbox",
      pictureUrl: pictureUrl,
      result: "Likely  scaphoid fracture",
    );
    String node22ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node7ID,
      parentOptionText: "At distal ulnar",
      pictureUrl: pictureUrl,
      result: "Likely  distal ulna fracture",
    );
    String node23ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node7ID,
      parentOptionText: "At distal radius",
      pictureUrl: pictureUrl,
      result: "Likely  distal radius fracture",
    );
    String node24ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node7ID,
      parentOptionText: "Other region of wrist",
      pictureUrl: pictureUrl,
      result: "Likely  carpal bone fracture or dislocation",
    );
  }

  static createHandNumbnessTree() async {
    const shortTreeName = "Hand Numbness";
    const longTreeName = "Hand Numbness";
    const treeDescription = "Hand numbness.";
    const treePictureUrl = "https://i.imgur.com/ub0k7fh.jpg";

    String question1 = "Where is it numb?";

    String question2 = "Worse with flexion of wrist? or Worse at night?";
    String question3 =
        "Numbness reproduces with compression of volar wrist with wrist flexion?";

    String question7 = "Numb on dorsal + volar hand or just volar hand?";
    String question8 =
        "Numbness reproduced with compression of medial elbow with elbow flexion?";
    String question11 = "Weakened pinch/grasp compared to otherside?";

    String question14 =
        "Pain radiates down arm and pain comes from neck, while pain is reproduced with neck flexion toward affected side?";

    String question17 =
        "History of Diabetes Mellitus, Alcohol Abuse, or Vitamin Deficiency?";

    String question20 = "Worse with cold or stress?";

    final treeId = await TreeCreator.createTree(
      shortTreeName: shortTreeName,
      longTreeName: longTreeName,
      treeDescription: treeDescription,
      pictureUrl: treePictureUrl,
    );

    String node1ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question1,
    );
    await TreeCreator.setRootNode(treeId: treeId, rootNodeId: node1ID);

    String node2ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question2,
      parentNodeId: node1ID,
      parentOptionText: "Thumb, Index Finger, and/or Middle Finger",
    );
    String node3ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question3,
      parentNodeId: node2ID,
      parentOptionText: "Yes",
    );
    String node4ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node2ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Go to question 3",
    );
    String node5ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node3ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely Carpal Tunnel Syndrome",
    );
    String node6ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node3ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Possible Carpal Tunnel Syndrome",
    );

    String node7ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question7,
      parentNodeId: node1ID,
      parentOptionText:
          "Ring Finger <-and/or-> Small Finger (Focus more on Small Finger)",
    );
    String node8ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question8,
      parentNodeId: node7ID,
      parentOptionText: "Yes",
    );
    String node9ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node8ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely Cubital Tunnel Syndrome",
    );
    String node10ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node8ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Possible Cubital Tunnel Syndrome",
    );
    String node11ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question11,
      parentNodeId: node7ID,
      parentOptionText: "No, dorsal alone",
    );
    String node12ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node11ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely Ulnar Tunnel Syndrome",
    );
    String node13ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node11ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Possible Ulnar Tunnel Syndrome",
    );

    String node14ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question14,
      parentNodeId: node1ID,
      parentOptionText:
          "Thumb, Large Finger, or small Finger alone +/- going up foreaarm and/or neck",
    );
    String node15ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node14ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely Cervical Spine Radiculopathy",
    );
    String node16ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node14ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Possible Cervical Spine Radiculopathy",
    );

    String node17ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question17,
      parentNodeId: node1ID,
      parentOptionText: "Numb in entire hand and +/- going forearm",
    );
    String node18ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node17ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely Peripheral Neuropathy",
    );
    String node19ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node17ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Go to question 3",
    );

    String node20ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: false,
      question: question20,
      parentNodeId: node1ID,
      parentOptionText: "All my fingers, but mostly at tips",
    );
    String node21ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node20ID,
      parentOptionText: "Yes",
      pictureUrl: "",
      result: "Likely Raynaud's Syndrome",
    );
    String node22ID = await TreeCreator.createTreeNode(
      treeId: treeId,
      isResult: true,
      question: "",
      parentNodeId: node20ID,
      parentOptionText: "No",
      pictureUrl: "",
      result: "Go to question 4",
    );
  }
}
