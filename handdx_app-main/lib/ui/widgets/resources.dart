import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          _launchURL();
        },
        child: Text(
          "Visit Our Sources",
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
      ),
    );
  }

    _launchURL() async {
    const url = 'https://www.assh.org/handcare/conditions#/+/0/title_na_str/asc/'; 
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
