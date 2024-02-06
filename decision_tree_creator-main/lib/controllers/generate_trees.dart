import 'package:decision_tree_creator/manual_tree_creator.dart';
import 'package:decision_tree_creator/tree_creator.dart';

class GenerateTrees {
  static Future<bool> generate() async {
    if (!(await TreeCreator.isAdmin())) {
      return false;
    }
    ManualTreeCreator.createHandNumbnessTree();
    ManualTreeCreator.createHandPainTree();
    ManualTreeCreator.createPainfulHardwareTree();
    ManualTreeCreator.createThumbOrRadialWristPainTree();
    ManualTreeCreator.createWristPainTree();
    return true;
  }
}
