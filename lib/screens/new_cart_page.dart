import 'dart:convert';

import 'package:cloud_tiffin/controllers/cart_controller.dart';
import 'package:cloud_tiffin/model/cart_models.dart';
import 'package:cloud_tiffin/screens/OrderFailed.dart';
import 'package:cloud_tiffin/screens/bottom_navigation.dart';
import 'package:cloud_tiffin/screens/thankyou_page.dart';
import 'package:cloud_tiffin/service/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
//import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../helper/colors.dart';
import '../helper/theme.dart';

class NewCartPage extends StatefulWidget {
  const NewCartPage({Key? key}) : super(key: key);

  @override
  _NewCartPageState createState() => _NewCartPageState();
}

class _NewCartPageState extends State<NewCartPage> {
  Razorpay? _razorpay;
  List<CartModel> allCaretList = [];
  double totalPrice = 0;
  String? delivery_typeController = '';
  static String? deliveryTypeNote;
  String? deliveryArea;
  String? _radioVal;
  bool _isLoading = false;
  String payAmount = "100";
  bool? isLoading = false;
  String Timenow = DateFormat.yMMMd().format(DateTime.now());
  String? user_id;
  String? price;
  String? qty;
  String? address;
  String? vendorid;
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool inDistance = false;
  final Distance distance = const Distance();
  TextEditingController _deliverAddress = TextEditingController();
  @override
  void initState() {
    _get_session();
    getAndSetData();
    // print("Hello Venodr ${allCaretList.first.vendor_id}");
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //  openCheckout();
    super.initState();
  }

  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  Future<void> _get_session() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      user_id = prefs.getString('id');
      address = prefs.getString('address');
      isLoading = true;
    });
  }

  void openCheckout() async {
    var options = {
      'key': "1wwq",
      'amount': int.parse(payAmount) * 100, // 100 * 100,
      'name': "User",
      'description': "Appointment",
      'prefill': {'contact': "+911234567890", 'email': "medicmantra@gmail.com"},
      "notify": {"sms": true, "email": true},
      "method": {
        "netbanking": true,
        "card": true,
        "wallet": false,
        'upi': true,
      },
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    //ToastMsg.showToastMsg("Payment success, please don't press back button");
    _handleSendData();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //     toastLength: Toast.LENGTH_SHORT);
    //  ToastMsg.showToastMsg("Payment error");
    setState(() {
      _isLoading = false;
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
    //  ToastMsg.showToastMsg("Something went wrong");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool check = false;
        if (check == false) {
          Get.off(() => BotNav());
        }
        return check;
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(72),
            child: AppBar(
              shadowColor: kblackcolor.withOpacity(0.3),
              elevation: 1,
              backgroundColor: kwhiteColor,
              foregroundColor: kblackcolor,
              centerTitle: true,
              title: Container(
                height: 92,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              // title: kTextstyle(
              //     myText: 'Cart List', mySize: 18, myWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: kwhiteColor,
          // bottomSheet: allCaretList.length !=0 ?InkWell(
          //   onTap: (){
          //     if(isVisible==true) {
          //       if (_formKey.currentState!.validate()) {
          //         place_order();
          //       } else {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(
          //               content: Text('Please enter delivery address')),
          //         );
          //       }
          //     }else{
          //       if (_radioVal=='2') {
          //         place_order();
          //       }else{
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(
          //               content: Text('Please Select Delivery Type')),
          //         );
          //       }
          //     }
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          //     child: Container(
          //       alignment: Alignment.center,
          //       height: 48,
          //       width: double.maxFinite,
          //       decoration: BoxDecoration(
          //         color: Colors.red,
          //         borderRadius: BorderRadius.circular(36),
          //       ),
          //       child: kTextstyle(
          //           myText: 'Checkout : \u{20B9}$totalPrice',
          //           myColor: kwhiteColor,
          //           mySize: 16,
          //           myWeight: FontWeight.w600),
          //     ),
          //   ),
          // ):Container(),

          body: SingleChildScrollView(
            child: Column(
              //clipBehavior: Clip.none,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height,
                  // decoration: IBoxDecoration.upperBoxDecoration(),
                  // child: _isLoading==true?Center(
                  //   child: CircularProgressIndicator(
                  //     strokeWidth: 6, color: kredColor,
                  //   ),
                  // ): buildContent(),
                  child: buildContent(),
                ),
                SizedBox(
                  height: 20,
                ),
                allCaretList.length != 0
                    ? inDistance == false
                        ? Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kgreenColor.withOpacity(0.1),
                                border:
                                    Border.all(width: 1, color: kgreenColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  kTextstyle(
                                      myText: " Note  :   ",
                                      mySize: 12,
                                      myColor: kgreenColor,
                                      myWeight: FontWeight.w600),
                                  kTextstyle(
                                      myColor: kgreenColor,
                                      myText: "out of delivery area",
                                      mySize: 12,
                                      myWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kgreenColor.withOpacity(0.1),
                                border:
                                    Border.all(width: 1, color: kgreenColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  kTextstyle(
                                      myText: " Note  :   ",
                                      mySize: 12,
                                      myColor: kgreenColor,
                                      myWeight: FontWeight.w600),
                                  kTextstyle(
                                      myColor: kgreenColor,
                                      myText: (deliveryTypeNote == '1')
                                          ? "Home delivery is available from kitchen "
                                          : (deliveryTypeNote == '2')
                                              ? " Take Away From Kitchen "
                                              : " Both ",
                                      mySize: 12,
                                      myWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                          )
                    : Container(),
                allCaretList.length != 0
                    ? inDistance == false
                        ? Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: "2",
                                    groupValue: delivery_typeController,
                                    activeColor: kgreenColor,
                                    hoverColor: kgreyColor,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        delivery_typeController = value;
                                        _radioVal = value;
                                        isVisible = false;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Takeaway from kitchen',
                                  ),
                                ],
                              ),

                              SizedBox(height: 12.0),

                              // Row(
                              //   children: [
                              //     Radio(
                              //       value: "Third",
                              //       groupValue: delivery_typeController,
                              //       focusColor: Colors.grey,
                              //       activeColor: Colors.grey,
                              //       hoverColor: Colors.grey,
                              //       onChanged: (dynamic value) {
                              //         setState(() {
                              //           delivery_typeController = value;
                              //         });
                              //       },
                              //     ),
                              //     Text(
                              //       'both',
                              //       // style: theme.textTheme.subtitle1,
                              //     ),
                              //   ],
                              // ),
                            ],
                          )
                        : deliveryTypeNote.toString() == '2'
                            ? Container()
                            : Row(
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        value: '1',
                                        groupValue: delivery_typeController,
                                        focusColor: kgreyColor,
                                        activeColor: kgreenColor,
                                        hoverColor: kgreyColor,
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            delivery_typeController = value;
                                            _radioVal = value;
                                            isVisible = true;
                                          });
                                        },
                                      ),
                                      Text(
                                        'Home Delivery',
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 12.0),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "2",
                                        groupValue: delivery_typeController,
                                        activeColor: kgreenColor,
                                        hoverColor: kgreyColor,
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            delivery_typeController = value;
                                            _radioVal = value;
                                            isVisible = false;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Takeaway from kitchen',
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 12.0),

                                  // Row(
                                  //   children: [
                                  //     Radio(
                                  //       value: "Third",
                                  //       groupValue: delivery_typeController,
                                  //       focusColor: Colors.grey,
                                  //       activeColor: Colors.grey,
                                  //       hoverColor: Colors.grey,
                                  //       onChanged: (dynamic value) {
                                  //         setState(() {
                                  //           delivery_typeController = value;
                                  //         });
                                  //       },
                                  //     ),
                                  //     Text(
                                  //       'both',
                                  //       // style: theme.textTheme.subtitle1,
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              )
                    : Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.26),
                        child: Column(
                          children: [
                            Icon(
                              FontAwesome.shopping_cart,
                              size: 56,
                              color: kredColor,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Center(
                                child: kTextstyle(
                                    space: 1,
                                    myText: "No Product in your Cart",
                                    myWeight: FontWeight.w600,
                                    mySize: 16)),
                          ],
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      child: Visibility(
                        visible: isVisible,
                        child: TextFormField(
                          controller: _deliverAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Delivery Address',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter delivery address';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                allCaretList.length != 0
                    ? InkWell(
                        onTap: () {
                          if (isVisible == true) {
                            if (_formKey.currentState!.validate()) {
                              place_order();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Please enter delivery address')),
                              );
                            }
                          } else {
                            if (_radioVal == '2') {
                              place_order();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Please Select Delivery Type')),
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 18),
                          child: Container(
                            alignment: Alignment.center,
                            height: 48,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(36),
                            ),
                            child: kTextstyle(
                                myText: 'Checkout : \u{20B9}$totalPrice',
                                myColor: kwhiteColor,
                                mySize: 16,
                                myWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          )),
    );
  }

  void getAndSetData() async {
    setState(() {
      _isLoading = true;
    });
    final res = await CartService.getData();
    print(res);
    if (res.isNotEmpty) {
      setState(() {
        allCaretList = res;
      });
      for (int i = 0; i < allCaretList.length; i++) {
        setState(() {
          totalPrice += double.parse(allCaretList[i].total_price.toString());
          vendorid = allCaretList[i].vendor_id.toString();
        });
      }
      Deliverytypeapi(vendorid);
    }
    print("Total Price: $totalPrice");
    setState(() {
      _isLoading = false;
    });
  }

  buildContent() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: allCaretList.length,
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  color: kgreyColor?.withOpacity(0.018),
                  // borderRadius: BorderRadius.circular(0),
                  border: Border.symmetric(
                      horizontal: BorderSide(
                          width: 1, color: klightgreyColor.withOpacity(0.12)))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 106,
                      width: 56,
                      decoration: BoxDecoration(
                          color: kwhiteColor,
                          border: Border.all(width: 2, color: kwhiteColor),
                          image: DecorationImage(
                              image: NetworkImage(allCaretList[index].image!),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: kblackcolor.withOpacity(0.2),
                              blurRadius: 4,
                            )
                          ]),
                    ),
                    SizedBox(
                      width: 24,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kTextstyle(
                              myText: allCaretList[index].name!,
                              mySize: 14,
                              myWeight: FontWeight.w600,
                              myColor: kgreyColor),
                          Row(
                            children: [
                              Icon(
                                FontAwesome5Solid.rupee_sign,
                                size: 14,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 2),
                                child: kTextstyle(
                                    myText: "${allCaretList[index].price}",
                                    mySize: 14,
                                    myWeight: FontWeight.w600,
                                    myColor: Colors.red.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        kTextstyle(myText: "Qty:"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: kTextstyle(
                              myText: "${allCaretList[index].qty}",
                              mySize: 14,
                              myWeight: FontWeight.w600,
                              myColor: Colors.red.shade700),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      children: [
                        kTextstyle(
                            myText: "Sub Total",
                            mySize: 12,
                            myWeight: FontWeight.w500),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: kTextstyle(
                              myText:
                                  "${int.parse(allCaretList[index].total_price!)}",
                              //  "${productTotalPrice(int.parse(data.price!), int.parse(data.qty!))}",
                              mySize: 14,
                              myWeight: FontWeight.w600,
                              myColor: Colors.red.shade700),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 24,
                    ),

                    // Total_Pricef()
                    //  Text("${TotalPricef(int.parse(allCaretList[index].total_price!) )}",style: TextStyle(fontSize: 1))
                    //Text("${TotalPricef(int.parse(data.price!),int.parse(data.qty!) )}",style: TextStyle(fontSize: 1))
                    //
                    InkWell(
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          final res = await CartService.DeleteData(
                              productId: allCaretList[index].product_id ?? "",
                              vendorId: allCaretList[index].vendor_id ?? "");
                          setState(() {
                            _isLoading = false;
                          });
                          setState(() {
                            setState(() {
                              allCaretList.removeAt(index);
                            });
                            totalPrice = 0;
                            for (int i = 0; i < allCaretList.length; i++) {
                              setState(() {
                                totalPrice += double.parse(
                                    allCaretList[i].total_price.toString());
                                vendorid = allCaretList[i].vendor_id.toString();
                              });
                            }
                          });
                          CartController cartController = Get.find(tag: "cart");
                          cartController.getData();
                        },
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: kredColor,
                        ))
                  ],
                ),
              ));
        });
  }

  Future place_order() async {
    //await  Future.delayed(const Duration(seconds: 2));

    CircularProgressIndicator(
      strokeWidth: 6,
      color: kredColor,
    );
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoading = true;
    });

    // addressController.clear();

    String? user_id = prefs.getString('id');
    String? address = prefs.getString('address');

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/place_order'),
      // Uri.parse('https://thesoftwareplanet.com/blossom/flutter_api/user/fiverbookService'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': "$user_id",
        'vendor_id': "$vendorid",
        'total_price': '$totalPrice',
        'address': '$address',
        'delivery_type': '${_deliverAddress.text}',
        'order_date': Timenow.toString()
      }),
    );
    print(response.body);
    var data = jsonDecode(response.body);

    print(data);
    // If the Response Message is Matched.
    if (data['ResponseCode'] == '200') {
      setState(() {
        isLoading = false;
      });

      //toast(data['ResponseMsg']);
      double? lat = prefs.getDouble('latitude');
      double? lng = prefs.getDouble('longitude');
      String? address = prefs.getString("address");

      // Navigate to Home & Sending Email to Next Screen.
      Get.offAll(ThankYouPage());
      // Navigator.pushNamed(context, '/HomePage');
    } else {
      Fluttertoast.showToast(msg: "${data['ResponseMsg']}");
      //toast(data['ResponseMsg']);
      Get.offAll(OrderFailedPage());
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> Deliverytypeapi(vendorid) async {
    print(
        "$vendorid ===================================================================================================================");

    var response = await http.post(
      Uri.parse('${Config.BASEURL}user/getVendorDeliveryType'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"vendor_id": "$vendorid"}),
    );

    final data = json.decode(response.body);
    //  print(data);
    final List responseBody = data['Vendors'];
    print(
        "${responseBody[0]['delivery_type']}             bodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    setState(() {
      deliveryTypeNote = responseBody[0]['delivery_type'];
      deliveryArea = responseBody[0]['delivery_area'];
      String? latitude = responseBody[0]['latitude'];
      String? longitude = responseBody[0]['longitude'];
      print("delivery type get.............");
      print("delivery type get............. $deliveryArea");
      print("delivery type get............. $latitude");
      print("delivery type get............. $longitude");
      distanceCalculator(double.parse(latitude!), double.parse(longitude!),
          double.parse(deliveryArea!));

      print(deliveryTypeNote);
    });
  }

  distanceCalculator(double lat2, double long2, double Distance) async {
    final prefs = await SharedPreferences.getInstance();
    String? latitude = prefs.getDouble('latitude').toString();
    String? longitude = prefs.getDouble('longitude').toString();
    double lat1 = double.parse(latitude);
    double long1 = double.parse(longitude);

    final double km = distance.as(
        LengthUnit.Kilometer, LatLng(lat1, long1), LatLng(lat2, long2));

    print(" calulate km $km");
    print("distance  $Distance");
    if (km <= Distance) {
      print(true);
      // status=true;
      setState(() {
        inDistance = true;
      });
      print(inDistance);
      // return inDistance;
    } else {
      // status=false;
      setState(() {
        inDistance = false;
      });
      print(inDistance);
      // print(false);
      //  return inDistance;
    }
  }

  void _handleSendData() async {
    setState(() {
      _isLoading = true;
    });
    await CartService.DeleteAllData();
    CartController cartController = Get.find(tag: "cart");
    cartController.getData();

    setState(() {
      allCaretList.clear();
      totalPrice = 0;

      _isLoading = false;
    });
  }
}
