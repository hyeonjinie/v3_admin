import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:v3_admin/screens/Dashboard.dart';
import 'package:v3_admin/screens/client_mgt/supplier_page.dart';
import 'package:v3_admin/screens/member_mgt/member_page.dart';
import 'package:v3_admin/screens/operation_mgt/forward_inquiry.dart';
import 'package:v3_admin/screens/product_mgt/regist_prod.dart';
import 'package:v3_admin/screens/settlement_mgt/settlement_page.dart';
import 'package:v3_admin/screens/statistics_data/statistics_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _updateIndex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      DashboardPage(
        onCategorySelected: (index) =>
            NavigationHelper.onItemTapped(context, index, _updateIndex),
      ),
      MemberManagementPage(),
      ClientManagement(),
      OperationPage(),
      ProdPage(),
      SettlementPage(),
      StatisticsPage(),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        key: _scaffoldKey,
        selectedPageIndex: _selectIndex,
        onItemTapped: (index) => NavigationHelper.onItemTapped(context, index, _updateIndex),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: pages[_selectIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
