import 'package:flutter/material.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

class RegistSupplier extends StatefulWidget {
  const RegistSupplier({super.key});

  @override
  State<RegistSupplier> createState() => _RegistSupplierState();
}

class _RegistSupplierState extends State<RegistSupplier> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 5;
  int selectedMenu = 1;

  void _updateIndex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        key: _scaffoldKey,
        selectedPageIndex: _selectIndex,
        onItemTapped: (index) =>
            NavigationHelper.onItemTapped(context, index, _updateIndex),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left Navigation Bar (LNB)
                Container(
                  width: 200.0,
                  color: Color(0xFF292F3D),
                  child: Column(
                    children: [
                      ProfileWidget(),
                      SizedBox(height: 10),
                      SingleMenuWidget(
                        label: '공급사 관리',
                        selectedMenu: selectedMenu,
                        index: 1,
                        onTap: () {
                          setState(() {
                            selectedMenu = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RegistView(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegistView extends StatefulWidget {
  const RegistView({super.key});

  @override
  State<RegistView> createState() => _RegistViewState();
}

class _RegistViewState extends State<RegistView> {
  late TextEditingController supNameController;
  late TextEditingController supRepController;
  late TextEditingController supRegiTypeController;
  late TextEditingController supRegiNumController;
  late TextEditingController supFieldController;
  late TextEditingController supItemController;
  late TextEditingController supContactController;
  late TextEditingController supEmailController;
  late TextEditingController supFaxController;
  late TextEditingController supController;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}