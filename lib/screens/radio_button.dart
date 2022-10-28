import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



enum SubscriptionType { Subscription1,Subscription2,Subscription3  }

class SelectSubscription extends StatefulWidget {
  const SelectSubscription({Key? key}) : super(key: key);

  @override
  State<SelectSubscription> createState() => _SelectSubscriptionState();
}

class _SelectSubscriptionState extends State<SelectSubscription> {
  SubscriptionType? _character = SubscriptionType.Subscription1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Column(
        children: <Widget>[
          SizedBox(height: screen.heigth(context)*0.2,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
           child: Container(
             decoration: BoxDecoration(
               color: Colors.grey.shade300,
               borderRadius: BorderRadius.circular(12),
               border: Border.all(color: Colors.grey.withOpacity(0.2)),
               boxShadow: [BoxShadow(
                 color: Colors.black.withOpacity(0.08),
                 blurRadius: 12,
               )]
             ),
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
               child: Row(
                 children: [
                   /// radio subscription 1
                   Radio<SubscriptionType>(activeColor: Colors.blue,
                  hoverColor: Colors.black,
                     focusColor: Colors.white,
                     value: SubscriptionType.Subscription1,
                     groupValue: _character,
                     onChanged: (SubscriptionType? value) {
                       setState(() {
                         _character = value;
                       });
                     },
                   ),
                   SizedBox(width: 24,),
                   Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                     color: Colors.white
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(left: 12,top: 24,bottom: 24,right: 46),
                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               kTextstyle(myText: "Plan Name    :  ",mySize: 12,myWeight: FontWeight.w600),
                               kTextstyle(myText: "Subscription 1",mySize: 14,myWeight: FontWeight.w600),
                             ],
                           ),
                           Row(
                             children: [
                               kTextstyle(myText: "Price                   :  ",mySize: 12,myWeight: FontWeight.w600),
                               kTextstyle(myText: "250 Rs",mySize: 14,myWeight: FontWeight.w600),
                             ],
                           ),
                           Row(
                             children: [
                               kTextstyle(myText: "Expires on     :  ",mySize: 12,myWeight: FontWeight.w600),
                               kTextstyle(myText: "24 Dec",mySize: 14,myWeight: FontWeight.w600),
                             ],
                           ),

                         ],
                       ),
                     ),
                   )

                 ],
               ),
             ),
           ),
         ),
          Padding(
           padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
           child: Container(
             decoration: BoxDecoration(
               color: Colors.grey.shade300,
               borderRadius: BorderRadius.circular(12),
               border: Border.all(color: Colors.grey.withOpacity(0.2)),
               boxShadow: [BoxShadow(
                 color: Colors.black.withOpacity(0.08),
                 blurRadius: 12,
               )]
             ),
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
               child: Row(
                 children: [
                   /// radio subscription 2=========================================
                   Radio<SubscriptionType>(activeColor: Colors.blue,
                  hoverColor: Colors.black,
                     focusColor: Colors.white,
                     value: SubscriptionType.Subscription2,
                     groupValue: _character,
                     onChanged: (SubscriptionType? value) {
                       setState(() {
                         _character = value;
                       });
                     },
                   ),
                   SizedBox(width: 24,),
                   Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                     color: Colors.white
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(left: 12,top: 24,bottom: 24,right: 46),
                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               kTextstyle(myText: "Plan Name    :  ",mySize: 12,myWeight: FontWeight.w600),
                               kTextstyle(myText: "Subscription 2",mySize: 14,myWeight: FontWeight.w600),
                             ],
                           ),
                           Row(
                             children: [
                               kTextstyle(myText: "Price                   :  ",mySize: 12,myWeight: FontWeight.w600),
                               kTextstyle(myText: "250 Rs",mySize: 14,myWeight: FontWeight.w600),
                             ],
                           ),
                           Row(
                             children: [
                               kTextstyle(myText: "Expires on     :  ",mySize: 12,myWeight: FontWeight.w600),
                               kTextstyle(myText: "24 Dec",mySize: 14,myWeight: FontWeight.w600),
                             ],
                           ),

                         ],
                       ),
                     ),
                   )

                 ],
               ),
             ),
           ),
         ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                  )]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                child: Row(
                  children: [
                    /// radio subscription 3====================================================================
                    Radio<SubscriptionType>(activeColor: Colors.blue,
                      hoverColor: Colors.black,
                      focusColor: Colors.white,
                      value: SubscriptionType.Subscription3,
                      groupValue: _character,
                      onChanged: (SubscriptionType? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    SizedBox(width: 24,),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12,top: 24,bottom: 24,right: 46),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                kTextstyle(myText: "Plan Name    :  ",mySize: 12,myWeight: FontWeight.w600),
                                kTextstyle(myText: "Subscription 3",mySize: 14,myWeight: FontWeight.w600),
                              ],
                            ),
                            Row(
                              children: [
                                kTextstyle(myText: "Price                   :  ",mySize: 12,myWeight: FontWeight.w600),
                                kTextstyle(myText: "250 Rs",mySize: 14,myWeight: FontWeight.w600),
                              ],
                            ),
                            Row(
                              children: [
                                kTextstyle(myText: "Expires on     :  ",mySize: 12,myWeight: FontWeight.w600),
                                kTextstyle(myText: "24 Dec",mySize: 14,myWeight: FontWeight.w600),
                              ],
                            ),

                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
// var kTextstyle = (
//     {final double? mySize,
//       final double? space,
//       // final double? wordspace,
//       var myWeight,
//       var myColor,
//       required String myText,
//       myDirection,
//       lines}) =>
//     Text(
//       myText,
//       maxLines: lines,
//       overflow: TextOverflow.ellipsis,
//       style: GoogleFonts.poppins(
//         // wordSpacing: wordspace ,
//           letterSpacing: space,
//           fontSize: mySize,
//           fontWeight: myWeight,
//           color: myColor),
//       textAlign: myDirection,
//     );