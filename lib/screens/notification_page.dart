import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:flutter/material.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leadingWidth: 36,
        backgroundColor: kredColor,
        title: kTextstyle(myText: "Notifications",mySize: 18,myWeight: FontWeight.w600),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: kTextstyle(myText: "You have no notifications yet",mySize: 18))
        ],

      ),    );
  }
}