import 'dart:async';
import 'dart:convert';

import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';

// import 'package:cloud_tiffin/model/chat_model.dart';
import 'package:cloud_tiffin/screens/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/chat_model.dart';

class ChatUiPage extends StatefulWidget {
  // ChatModel? chatModel;
  ChatUiPage({
    Key? key,
    // required this.chatModel
  }) : super(key: key);

  @override
  State<ChatUiPage> createState() => _ChatUiPageState();
}

class _ChatUiPageState extends State<ChatUiPage> {
  dynamic argumentData = Get.arguments;
  ChatModel? chatModel;
  String? name;
  String? sender_text;
  String? reciver_text;
  String? order_id;
  String? vendor_id;
  bool? isLoading;
  List chatlist = [];

  // String? _controller;
  //final List imagesList =
  final _MessageConroller = TextEditingController();
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ScrollController _controller = ScrollController();
    setState(() {
      order_id = Get.arguments[0]['order_id'];
      name = Get.arguments[1]['name'];
      vendor_id = Get.arguments[2]['vendor_id'];
      print(
          '====================================================== $vendor_id');
    });
    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) => setState(() {
      _pullRefresh();
    }));
    //  get_message();
  }

  // ScrollController _controller = ScrollController(initialScrollOffset:_controller.positions.last );
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leadingWidth: 36,
        backgroundColor: Colors.white,
        foregroundColor: kgreyColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
              onTap: () {
                 Get.to(()=> BotNav());
               // Get.back();
              },
              child: Icon(Icons.arrow_back)),
        ),
        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(

                    /// ============ accept order page se shop image daalna ==================================
                      image: AssetImage('assets/images/logo.png'))),
            ),
            SizedBox(
              width: 20,
            ),
            kTextstyle(myText: "${name}", myWeight: FontWeight.w600, mySize: 18)
          ],
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: getJobsData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _controller,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var title = snapshot.data![index]['message'];
                          var time = snapshot.data![index]['created_at'];
                          var seen = snapshot.data![index]['seen'];
                          print(
                              "============================================== $seen");
                          // var skills = snapshot.data![index]['skills'];
                          // var description = snapshot.data![index]['description'];
                          // var positions = snapshot.data![index]['positions'];
                          return Message(
                            message: title,
                            seen: seen,
                            time: time,
                          );
                        },
                      ),
                    );
                  }
                  return Container(
                    child: Center(child: Text("No Message Yet")),
                  );
                  //return CircularProgressIndicator();
                },
              ),
            ),
            InputText(context),
          ],
        ),
      ),

      // bottomSheet: InputText(context),
    );
  }
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<List<dynamic>> getJobsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('id');

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/chat_message'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$user_id",
        "vendor_id": "$vendor_id",
        "order_id": "$order_id",
      }),
    );

    final data = json.decode(response.body);
    print("///////////////chat data hello////////");
    print(data);
    //chatlist.addAll(data['Chat_data']);
    var responseBody = data['Chat_data'];

    return responseBody;
    //  return json.decode(responseBody);
  }
  Future<void> _pullRefresh() async {
    getJobsData();
    _scrollDown();
    setState(() {

    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }
  Container InputText(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: kgreyColor!.withOpacity(0.24), blurRadius: 8)
      ]),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screen.width(context) - 74,
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                decoration: BoxDecoration(
                    color: kgreyColor!.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(36)),
                child: TextFormField(
                  maxLines: null,
                  controller: _MessageConroller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    hintText: 'Write something...',
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 3,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    _MessageConroller.text.isEmpty? null:
                    send_message(_MessageConroller.text);
                  });
                },
                child: Container(
                  child: Icon(Icons.send_rounded),
                ))
          ],
        ),
      ),
    );
  }

  Future send_message(String? message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('id');
    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/chat_now'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$user_id",
        "vendor_id": "$vendor_id",
        "order_id": "$order_id",
        "message": "$message"
      }),
    );
    print(response);
    var data = jsonDecode(response.body);

    print(data);
    // If the Response Message is Matched.
    if (data['ResponseCode'] == '200') {
      _MessageConroller.text = "";
      // get_message();
      getJobsData();
      _scrollDown();
      setState(() {});

      print(data['ResponseMsg']);
    } else {
      print(data['ResponseMsg']);
    }
  }
// Future<void> get_message() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? user_id = prefs.getString('id');
//   print(user_id);
//   print(user_id);
//   setState(() {
//     isLoading = true;
//   });
//   var response = await  http.post(
//     Uri.parse('${Config.BASEURL}user/chat_message'),
//
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       "user_id": "$user_id",
//       "vendor_id": "$vendor_id",
//       "order_id": "$order_id",
//     }),
//   );
//
//
//   final data = json.decode(response.body);
//   print("///////////////chat data////////");
//  print(data);
//   //chatlist.addAll(data['Chat_data']);
//   var responseBody = data['Chat_data'];
//  // final  List responseBody = data['Chat_data'];
//    print(responseBody);
//   // for(var i in responseBody) {
//   //   setState(() {
//   //     chatlist.add({
//   //       i['message']
//   //       });
//   //   });
//   //   print("gfhgvhg $chatlist");
//   // }
//   responseBody.map((e) => ChatModel.fromJson(e)).toList();
//
//   setState(() {
//     isLoading = false;
//   });
//
// }

}

class Message extends StatefulWidget {
  final String? seen;
  final String? message;
  final String? time;

  const Message(
      {Key? key, required this.seen, required this.message, required this.time})
      : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      widget.seen == "1" ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
          child: Container(
              decoration: BoxDecoration(
                  color: widget.seen == "0"
                      ? Colors.blue.shade700
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.only(
                      topRight: widget.seen == "0"
                          ? Radius.circular(1)
                          : Radius.circular(18),
                      topLeft: widget.seen == "1"
                          ? Radius.circular(1)
                          : Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    kTextstyle(
                        myText: widget.message!,
                        myColor: widget.seen == "0" ? kwhiteColor : kblackcolor,
                        mySize: 14,
                        lines: 12),
                    kTextstyle(
                        myText: widget.time.toString().substring(11, 16),
                        mySize: 12,
                        myColor:
                        widget.seen == "0" ? kwhiteColor : kblackcolor),
                  ],
                ),
              )

            // ListTile(
            //   //  leading: Text(skills),
            //   title: kTextstyle(myText: widget.message!,mySize: 14,myColor: Colors.white,lines: 12),
            //   // subtitle: Text(
            //   //   company + '\n' + description,
            //   // ),
            //   trailing: Text(widget.time.toString().substring(11,16),style: TextStyle(fontSize: 12,color: kwhiteColor,fontWeight: FontWeight.w600),),
            // ),
          ),
        ),
      ],
    );
  }
}
