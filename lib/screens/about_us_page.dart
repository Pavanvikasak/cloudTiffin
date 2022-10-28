import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:cloud_tiffin/screens/contact_us_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: kredColor,
        title: kTextstyle(myText: "About us"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24),
              child: kTextstyle(myText: """Delivering the future of""", mySize: 18, myColor: kgreyColor, myWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 0),
              child: kTextstyle(myText: """Tiffin Providers""", mySize: 18, myColor: kredColor, myWeight: FontWeight.w600),
            ),
            Divider(),
            Container(
              height: screen.heigth(context) * 0.22,
              width: screen.width(context) * 8,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/del.jpg'), fit: BoxFit.cover)),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kTextstyle(myText: 'Who we are ?', mySize: 16, myWeight: FontWeight.w600),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: kTextstyle(
                        lines: 15,
                        myText:
                        """Cloud Tiffin is a company that connects people with the best of their neighborhoods across the India . We enable local businesses to meet consumer's needs of ease and convenience and in turn,we generate new ways for people to earn, work and live. By building the last-mile logistics infrastructure for local Food providers , we’re fulfilling our mission to grow and empower local Tiffin providers.""",
                        mySize: 12,
                        myColor: kgreyColor,
                        myWeight: FontWeight.w500),
                  ),
                  Divider(),
                  kTextstyle(myText: 'Technology meets transformation', mySize: 16, myWeight: FontWeight.w600),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: kTextstyle(
                        lines: 15,
                        myText:
                        """Cloud Tiffin  introduced a new model for online Food & Tiffin home delivery. Today, we offer retail enablement solutions , regional and national tiffin providers are across the india. Our intuitive is simple solutions for Local kitchens , customers, brands and restaurants , they are transforming through our platform. """,
                        mySize: 12,
                        myColor: kgreyColor,
                        myWeight: FontWeight.w500),
                  ),
                  Divider(),
                  kTextstyle(myText: ' For Customers', mySize: 16, myWeight: FontWeight.w600),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      children: [
                        Container(
                          height: screen.heigth(context) * 0.1,
                          width: screen.width(context) * .2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(image: AssetImage('assets/images/cus.jpg'), fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: kTextstyle(
                              lines: 15,
                              myText:
                              """With thousands of restaurants, Tiffin providers and more at your fingertips, Cloud Tiffin delivers the best of your neighborhood on-demand.""",
                              mySize: 12,
                              myColor: kgreyColor,
                              myWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    width: screen.width(context),
                    child: Column(
                      children: [
                        Container(
                          height: screen.heigth(context) * 0.1,
                          width: screen.width(context) * .2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(image: AssetImage('assets/images/logo.png'), fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    width: screen.width(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            kTextstyle(myText: "To know more about us :", mySize: 12, myWeight: FontWeight.w600),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ContactUsPage());
                                },
                                child: kTextstyle(myText: " Click here", mySize: 12, myWeight: FontWeight.w600, myColor: kgreenColor)),
                          ],
                        ),
                        kTextstyle(myText: "or"),
                        kTextstyle(myText: "Visit our website : www.cloudtiffin.com", mySize: 12, myWeight: FontWeight.w600),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
