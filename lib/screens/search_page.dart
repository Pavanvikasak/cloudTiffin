import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/screens/search_kitchen_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController _textController = TextEditingController();
  List<dynamic> mainDataList = [];
 // SearchModel? newSearchModel;
  // Copy Main List into New List.

  List<dynamic> newDataList = [];

  //List newDataList = List.from(mainDataList);
  @override
  void initState() {
    super.initState();

    // getServices();
  }

  onItemChanged(String value) {
    mainDataList.clear();
    SearchServices(value);
    // setState(() {
    //   newDataList = mainDataList
    //       .where((string) => string.toLowerCase().contains(value.toLowerCase()))
    //       .toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74,
        leadingWidth: 24,
        backgroundColor: Colors.transparent,
        foregroundColor: kblackcolor,
        title: Container(
          decoration: BoxDecoration(
              color: kwhiteColor,
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                    color: kblackcolor.withOpacity(0.18),
                    offset: Offset(0, 4),
                    blurRadius: 8)
              ]),
          child: TextField(
            controller: _textController,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              // contentPadding: EdgeInsets.only(left: 18),
              border: InputBorder.none,
              hintText: 'Search name or dish...',
            ),
            onChanged: onItemChanged,
          ),
        ),
        // centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kblackcolor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              // padding: EdgeInsets.(12.0),
              children: mainDataList.map((data) {
                return ListTile(
                    title: Container(
                      height: 64,
                      width: screen.width(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              width: 1, color: kblackcolor.withOpacity(0.09))),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: CachedNetworkImage(
                                imageUrl: data['image'],
                                width: 45,
                                height: 45,

                                fit: BoxFit.cover,
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                // errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(width: 35.0),
                          Text(data['name'],
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w500)),


                        ],
                      ),
                    ),
                    horizontalTitleGap: 0.0,
                    onTap: () {


                      Get.to(() => SearchKitchenPage(),
                      arguments: [{'vendor_id': data['vendor_id']}]);
                     },

                );
                }
              ).toList(),
            ),







            ),


        ],
      ),
    );
  }

 // Future<List<SearchModel>> SearchServices(String value) async {
  Future<void> SearchServices(String value) async {
    //  mainDataList.clear();
    // String? search = _textController.text;

    // var response = await http
    //     .get(Uri.parse("${Config.BASEURL}user/get_search?keyword=$value"));
    // final data = json.decode(response.body);
    //

    final prefs = await SharedPreferences.getInstance();
    String? latitude = prefs.getDouble('latitude').toString();
    String? longitude = prefs.getDouble('longitude').toString();




    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/search'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'keyword': "$value",
        'longitude': longitude,
        'latitude': latitude,
        'distance': "10",
      }),
    );
   //
    final data = json.decode(response.body);
    final List responseBody = data['SearchData'];
    print(responseBody);



    mainDataList.clear();
    mainDataList.addAll(responseBody);
    for (var i in responseBody) {
      setState(() {
        mainDataList
            .add({'id': i['id'], 'name': i['name'], 'image': i['thumbnail'],'vendor_id': i['vendor_id']});

        //   mainDataList.add({'id': i['id'], 'name': i['name']});
        //  mainDataList.add(i['name']);
      });
    }
    // setState(() {
    //   SearchModel.fromJson(mainDataList);
    // });

  //  return responseBody.map((e) => SearchModel.fromJson(mainDataList)

   // ).toList();
  }


}

