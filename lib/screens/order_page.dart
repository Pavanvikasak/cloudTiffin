
import 'package:cloud_tiffin/helper/colors.dart';
import 'package:cloud_tiffin/helper/screen_size.dart';
import 'package:cloud_tiffin/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/accepted_model.dart';
import '../model/completed_model.dart';
import '../model/pending_model.dart';
import '../model/rejected_model.dart';
import '../provider/accepted_provider.dart';
import '../provider/completed_provider.dart';
import '../provider/prnding_provider.dart';
import '../provider/rejected_provider.dart';
import '../widgets/accepted_order_card.dart';
import '../widgets/completed_order_card.dart';
import '../widgets/pending_order_card.dart';
import '../widgets/rejetcted_order_card.dart';
import 'bottom_navigation.dart';



class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool isLoading = false;
  String email = '';
  String? user_id;
  String? address;
  double? latitude;
  double? longitude;

  void initState() {
    super.initState();
    _get_session();
  }

  Future<void> _get_session() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id ??= prefs.getString('id');
      address ??= prefs.getString('address');
      latitude = prefs.getDouble('latitude');
      longitude = prefs.getDouble('longitude');
    });

    print('my id');
    print(user_id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return isLoading
    //     ? const Center(child: CircularProgressIndicator())
    //     :
    return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                leadingWidth: 36,
                backgroundColor: kredColor,
                foregroundColor: kwhiteColor,
                // leading: Container(),
                title:kTextstyle(myText: 'Order Page',myWeight: FontWeight.w600,mySize: 18),


                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: Container(
                    height: 45.0,
                    width: screen.width(context),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: kwhiteColor),
                    ),
                    child: TabBar(
                      labelPadding: EdgeInsets.only(
                        right: 1,left: 1
                      ),
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,letterSpacing: 0.8
                      ),
                      indicator: BoxDecoration(

                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 2,color: kwhiteColor),
                        color: kredColor,
                      ),
                      labelColor: kwhiteColor,
                      unselectedLabelColor: kblackcolor,
                      tabs: [
                        Tab(text: 'Pending'),
                        Tab(text: 'Accepted'),
                        Tab(text: 'Completed'),
                        Tab(text: 'Cancelled'),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  NextTab(),
                  AcceptedTab(),
                  CompletedTab(),
                  CancelledTab(),
                ],
              ),
            ),
          );
  }
}
// class NextTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print("hello yd");
//     return ListView.builder(
//       itemCount: nextList.length,
//       shrinkWrap: true,
//       physics: ScrollPhysics(),
//       itemBuilder: (context, index) {
//         print(nextList[index]);
//         return OrderCard(appointment: nextList[index]);
//       },
//     );
//   }
// }

class NextTab extends StatefulWidget {
  @override
  State<NextTab> createState() => _NextTabState();
}

class _NextTabState extends State<NextTab> {
  bool isLoading = false;
  String email = '';
  String? user_id;

  void initState() {
    super.initState();
    _get_session();
  }

  Future<void> _get_session() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id ??= prefs.getString('id');
    });

    print('my id');
    print(user_id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ChangeNotifierProvider(
            create: (context) => PendingProvider.initial(userid: user_id),

            //create: (context) => PendingProvider.intial(),

            child: Builder(builder: (context) {
              final model = Provider.of<PendingProvider>(context);
              print("heyyyyy ${model.pendingModel}");
              final pendinglist = model.pendingModel;
              print("heyyyyy");
              print(pendinglist.length);
              if (pendinglist.length != 0) {
                return ListView.builder(
                  itemCount: pendinglist.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    PendingModel pendinglists = pendinglist[index];
                    print(pendinglists);
                    return PendingOrderCard(pendinglists: pendinglists);
                  },
                );
              } else {
                return Center(child: Text("No orders to show"));
              }
            }),
          );
  }
}

class AcceptedTab extends StatefulWidget {
  @override
  State<AcceptedTab> createState() => _AcceptedTabState();
}

class _AcceptedTabState extends State<AcceptedTab> {
  bool isLoading = false;
  String email = '';
  String? user_id;

  void initState() {
    super.initState();
    _get_session();
  }

  Future<void> _get_session() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id ??= prefs.getString('id');
    });

    print('my id');
    print(user_id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ChangeNotifierProvider(
            create: (context) => AcceptedProvider.initial(userid: user_id),

            //create: (context) => PendingProvider.intial(),

            child: Builder(builder: (context) {
              final model = Provider.of<AcceptedProvider>(context);
              print("heyyyyy ${model.acceptedModel}");
              final acceptedlist = model.acceptedModel;
              print("heyyyyy");
              print(acceptedlist.length);
              if (acceptedlist.length != 0) {
                return ListView.builder(
                  itemCount: acceptedlist.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    AcceptedModel acceptedlists = acceptedlist[index];

                    return AcceptedOrderCard(acceptedlists: acceptedlists);
                  },
                );
              } else {
                return Center(child: Text("No orders to show"));
              }
            }),
          );
  }
}

class CompletedTab extends StatefulWidget {
  const CompletedTab({
    Key? key,
  }) : super(key: key);

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  bool isLoading = false;
  String email = '';
  String? user_id;

  void initState() {
    super.initState();
    _get_session();
  }

  Future<void> _get_session() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id ??= prefs.getString('id');
    });

    print('my id');
    print(user_id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ChangeNotifierProvider(
            //create: (context) => CompletedProvider(),
            create: (context) => CompletedProvider.initial(userid: user_id),

            child: Builder(builder: (context) {
              final model = Provider.of<CompletedProvider>(context);
              print("heyyyyy ${model.completedModel}");
              final completedlist = model.completedModel;
              if (completedlist.length != 0) {
                return ListView.builder(
                  itemCount: completedlist.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    CompletedModel completedlists = completedlist[index];
                    return CompletedOrderCard(completedlists: completedlists);
                  },
                );
              } else {
                return Center(child: Text("No orders to show"));
              }
            }),
          );
  }
}

class CancelledTab extends StatefulWidget {
  @override
  State<CancelledTab> createState() => _CancelledTabState();
}

class _CancelledTabState extends State<CancelledTab> {
  bool isLoading = false;
  String email = '';
  String? user_id;

  void initState() {
    super.initState();
    _get_session();
  }

  Future<void> _get_session() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id ??= prefs.getString('id');
    });

    print('my id rejected');
    print(user_id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ChangeNotifierProvider(
            create: (context) => RejectedProvider.initial(userid: user_id),
            // create: (context) => RejectedProvider(),
            child: Builder(builder: (context) {
              final model = Provider.of<RejectedProvider>(context);
              final rejectedlist = model.rejectedModel;
              print(rejectedlist.length);
              if (rejectedlist.length != 0) {
                return ListView.builder(
                  itemCount: rejectedlist.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    RejectedModel rejectedlists = rejectedlist[index];
                    return RejectedOrderCard(rejectedlists: rejectedlists);
                  },
                );
              } else {
                return Center(child: Text("No orders to show"));
              }
            }),
          );
  }
}
