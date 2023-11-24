import 'package:appetit/cubits/branch/branchs_cubit.dart';
import 'package:appetit/cubits/campaign/campaigns_cubit.dart';
import 'package:appetit/cubits/profile/account_cubit.dart';
import 'package:appetit/cubits/store/stores_cubit.dart';
import 'package:appetit/fragments/HomeFragment.dart';
import 'package:appetit/fragments/ANotificationFragment.dart';
import 'package:appetit/fragments/AProfileFragment.dart';
import 'package:appetit/screens/CreateCampaignScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedItem = 0;

  void onTapSelection(int index) {
    if (index == 1)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => CreateCampaignCubit()),
                      BlocProvider(create: (context) => BranchsCubit()),
                      BlocProvider<AccountCubit>(create: (context) => AccountCubit()),
                      BlocProvider(create: (context) => StoresCubit())
                    ],
                    child: CreateCampaignScreen(),
                  )));
    else
      setState(() => selectedItem = index);
  }

  List<Widget> widgetOption = <Widget>[
    HomeFragment(),
    SizedBox(),
    ANotificationFragment(),
    AProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<StoresCubit>(create: (context) => StoresCubit()), BlocProvider<AccountCubit>(create: (context) => AccountCubit())],
      child: Scaffold(
        body: widgetOption.elementAt(selectedItem),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 25,
          backgroundColor: Color(0xFF462F4C),
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedItem,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: onTapSelection,
          elevation: 0,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orangeAccent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline_outlined), label: 'Reels'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
