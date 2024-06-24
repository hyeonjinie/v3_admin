import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:v3_admin/screens/member_mgt/member_detail.dart';


class SubOrder {
  String itemName;
  int quantity;
  List<String> suppliers; 

  SubOrder(this.itemName, this.quantity, this.suppliers);
}


class CompletedDetail extends StatefulWidget {
  const CompletedDetail({super.key});

  @override
  State<CompletedDetail> createState() => _CompletedDetailState();
}

class _CompletedDetailState extends State<CompletedDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 2; // GNB : 운영관리
  int selectedMenu = 3; // SUB : 선도거래 > 완료

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
                      SubMenuWidget(
                        label: '선도거래',
                        selectedMenu: selectedMenu,
                        onTap: (index) {
                          setState(() {
                            selectedMenu = index;
                          });
                          if (index == 1) {
                            context.go('/operation');
                          } else if (index == 2) {
                            context.go('/progress');
                          } else if (index == 3) {
                            context.go('/completed');
                          }
                        },
                        items: [
                          SubMenuItem(
                            label: '문의/계약',
                            index: 1,
                          ),
                          SubMenuItem(
                            label: '진행',
                            index: 2,
                          ),
                          SubMenuItem(
                            label: '완료',
                            index: 3,
                          ),
                        ],
                        isExpanded: true,
                      ),
                      SubMenuWidget(
                        label: '비굿마켓',
                        selectedMenu: selectedMenu,
                        onTap: (index) {
                          setState(() {
                            selectedMenu = index;
                          });
                          if (index == 4) {
                            context.go('/order');
                          } else if (index == 5) {
                            context.go('/cancel');
                          }
                        },
                        items: [
                          SubMenuItem(
                            label: '주문',
                            index: 4,
                          ),
                          SubMenuItem(
                            label: '반품/취소',
                            index: 5,
                          ),
                        ],
                        isExpanded: false,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DetailView(),
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

final List<Map<String, String>> supplier = [];

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  void _addSupplier(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 570,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  '공급처 등록',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                SupplierForm(
                  onSubmit: (supplierData) {
                    setState(() {
                      supplier.add(supplierData);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      padding: EdgeInsets.all(30.0),
      color: Color(0xFFF9FCFE),
      child: Column(
        children: [
          // 상단 타이틀 영역
          TitleSection(
            mainTitle: '완료',
            breadcrumb1: ' > 운영관리 > 선도거래 > ',
            breadcrumb2: '완료',
          ),
          OutlinedButton(
            onPressed: () {
              _addSupplier(context);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFFD6D6D6)),
              backgroundColor: Colors.white,
            ),
            child: Text(
              '공급처 추가',
              style: TextStyle(
                color: Color(0xFF323232),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: supplier.isEmpty
                ? Center(child: Text('등록된 공급처가 없습니다.'))
                : Expanded(
                    child: Column(
                      children: [
                        ToggleButtons(
                          isSelected: List.generate(
                            supplier.length,
                            (index) => index == 0,
                          ),
                          onPressed: (index) {
                            setState(() {
                            });
                          },
                          children: List.generate(
                            supplier.length,
                            (index) => Text(
                              '공급사${index + 1}',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            '',
                            // supplier[index]['공급사명']!,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class SupplierTile extends StatefulWidget {
  final String supplierName;

  const SupplierTile({Key? key, required this.supplierName}) : super(key: key);

  @override
  _SupplierTileState createState() => _SupplierTileState();
}

class _SupplierTileState extends State<SupplierTile> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToggleButtons(
          isSelected: [isOpened],
          onPressed: (index) {
            setState(() {
              isOpened = !isOpened;
            });
          },
          children: [
            Text('공급사${supplier.indexOf({'공급사명': widget.supplierName}) + 1}'),
          ],
        ),
        if (isOpened)
          Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              widget.supplierName,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
      ],
    );
  }
}

class SupplierForm extends StatefulWidget {
  final Function(Map<String, String>) onSubmit;
  const SupplierForm({super.key, required this.onSubmit});

  @override
  State<SupplierForm> createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
  late TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              customTextField('공급사명', '', nameController),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('제출'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit({
                          "공급사명": nameController.text,
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
