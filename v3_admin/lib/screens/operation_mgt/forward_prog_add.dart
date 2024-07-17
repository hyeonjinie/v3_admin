import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:v3_admin/screens/operation_mgt/forward_inquiry_detail.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

// 수요처 목록
final List<Map<String, dynamic>> bizList = [
  {
    'companyName': 'a',
    "bizRegiNum": "123456789",
  },
  {
    'companyName': 'b',
    "bizRegiNum": "123456789",
  },
  {
    'companyName': 'c',
    "bizRegiNum": "123456789",
  },
  {
    'companyName': 'd',
    "bizRegiNum": "123456789",
  },
  {
    'companyName': 'e',
    "bizRegiNum": "123456789",
  },
  {
    'companyName': 'f',
    "bizRegiNum": "123456789",
  },
];

// 공급처
final List<Map<String, dynamic>> _data = [
  // {
  //   'supplierName': '한결농산',
  //   "bizRegiNum": "123456789",
  //   'cost': 1600,
  //   'volume': 6000,
  //   'totalAmount': 9600000,
  // },
  // {
  //   'supplierName': '냠냠농산',
  //   "bizRegiNum": "123456789",
  //   'cost': 1800,
  //   'volume': 2000,
  //   'totalAmount': 3600000,
  // },
  // {
  //   'supplierName': '꿀꿀농산',
  //   "bizRegiNum": "123456789",
  //   'cost': 1800,
  //   'volume': 2000,
  //   'totalAmount': 3600000,
  // },
];

class RegistMainOrder extends StatefulWidget {
  const RegistMainOrder({super.key});

  @override
  State<RegistMainOrder> createState() => _RegistMainOrderState();
}

class _RegistMainOrderState extends State<RegistMainOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 2; // GNB : 운영관리
  int selectedMenu = 2; // SUB : 선도거래 > 진행

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
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RegistOrderForm(),
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

class RegistOrderForm extends StatefulWidget {
  const RegistOrderForm({super.key});

  @override
  State<RegistOrderForm> createState() => _RegistOrderFormState();
}

class _RegistOrderFormState extends State<RegistOrderForm> {
  late TextEditingController itemController; //품목
  late TextEditingController varietyController; //품종
  late TextEditingController gradeController; //등급
  late TextEditingController originController; //원산지
  late TextEditingController priceController; //단가
  late TextEditingController volumeController; //공급물량
  late TextEditingController orderCntController; //거래횟수
  late TextEditingController startDateController; //공급기간_시작
  late TextEditingController endDateController; //공급기간_종료
  late TextEditingController deliveryDateController; //희망배송일
  late TextEditingController amountController; //총 금액
  late TextEditingController contactController; //담당자 연락처
  late TextEditingController memoController; //메모
  Map<String, dynamic>? _selectedBiz;

  Uint8List? _accountImgData;
  Future<void> getAccountImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _accountImgData = file.bytes;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    itemController = TextEditingController();
    varietyController = TextEditingController();
    gradeController = TextEditingController();
    originController = TextEditingController();
    priceController = TextEditingController();
    volumeController = TextEditingController();
    orderCntController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    deliveryDateController = TextEditingController();
    amountController = TextEditingController();
    contactController = TextEditingController();
    memoController = TextEditingController();
  }

  @override
  void dispose() {
    itemController.dispose();
    varietyController.dispose();
    gradeController.dispose();
    originController.dispose();
    priceController.dispose();
    volumeController.dispose();
    orderCntController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    deliveryDateController.dispose();
    amountController.dispose();
    contactController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(30.0),
          color: Color(0xFFF9FCFE),
          child: Column(
            children: [
              // 디테일 페이지 상단 영역
              Row(
                children: [
                  const Text(
                    '선도거래 주문서 생성',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: '등록',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomElevatedButton2(
                    text: '취소',
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF9A9A9A),
                    borderColor: Color(0xFFD6D6D6),
                    onPressed: () {
                      context.go('/progress');
                    },
                  ),
                ],
              ),

              // 디테일 페이지 내용 영역
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1000,
                  decoration: commonBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              // 문의내용
                              TableBar(titleText: '문의내용'),
                              Container(
                                width: double.infinity,
                                child: Table(
                                  border: const TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: const {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: [
                                    buildRow('품목', controller: itemController),
                                    buildRow('품종',
                                        controller: varietyController),
                                    TableRow(children: [
                                      buildCell('등급', isHeader: true),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 20),
                                        child: SelectBoxExample(
                                          initialValue: '특',
                                          options: const [
                                            '특',
                                            '상',
                                            '중',
                                            '하',
                                            '못난이',
                                          ],
                                          onChanged: (String? newValue) {
                                            setState(() {});
                                          },
                                          custom_width: 120.0,
                                        ),
                                      ),
                                    ]),
                                    buildRow('원산지',
                                        controller: originController),
                                    buildRow('단가', controller: priceController),
                                    buildRow('공급물량',
                                        controller: volumeController),
                                    buildRow('거래횟수',
                                        controller: orderCntController),
                                    buildRow('총 금액',
                                        controller: amountController),
                                    TableRow(children: [
                                      buildCell('통장사본', isHeader: true),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 20),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              if (_accountImgData != null)
                                                Image.memory(
                                                  _accountImgData!,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                )
                                              else
                                                Text(''),
                                              SizedBox(width: 15,),
                                              CustomElevatedButton1(
                                                backgroundColor:
                                                    Color(0xFF5D75BF),
                                                text: '파일선택',
                                                onPressed: () {
                                                  getAccountImage();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // 기업 정보
                              TableBar(titleText: '기업 정보'),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFD6D6D6)),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ListView.builder(
                                  itemCount: bizList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        '${bizList[index]['companyName']} (${bizList[index]['bizRegiNum']})',
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _selectedBiz = bizList[index];
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                              if (_selectedBiz != null) ...[
                                SizedBox(height: 16),
                                Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFD6D6D6)),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    '업체명: ${_selectedBiz!['companyName']} | 사업자번호: ${_selectedBiz!['bizRegiNum']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              const SizedBox(
                                height: 20,
                              ),
                              // 공급처 정보
                              TableBar(titleText: '공급처 정보'),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  child: SuppliersButtons(
                                    suppliers: _data,
                                    isAdd: true,
                                    isSub: false,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 공급처 영역
class SuppliersButtons extends StatefulWidget {
  final List<dynamic> suppliers;
  final bool isAdd;
  final bool isSub;

  SuppliersButtons(
      {required this.suppliers, required this.isAdd, required this.isSub});

  @override
  _SuppliersButtonsState createState() => _SuppliersButtonsState();
}

class _SuppliersButtonsState extends State<SuppliersButtons> {
  int _selectedSupplierIndex = 0;
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDialog(
          suppliers: widget.suppliers,
          onSave: (updatedSuppliers) {
            setState(() {});
          },
        );
      },
    );
  }

  void _showAddSupplierDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSupplierDialog(
          onSupplierSelected: (selectedSupplier, cost, volume, totalAmount) {
            setState(() {
              _data.add({
                'supplierName': selectedSupplier['supplierName'],
                'bizRegiNum': selectedSupplier['bizRegiNum'],
                'cost': cost,
                'volume': volume,
                'totalAmount': totalAmount,
              });
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.suppliers == null || widget.suppliers.isEmpty)
              const Expanded(
                child: Row(
                  children: [
                    Text(
                      '공급처 정보 없음',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
              )
            else
              Expanded(
                child: Row(
                  children:
                      List<Widget>.generate(widget.suppliers.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSupplierIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        width: 85,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          border: Border.all(
                              color: _selectedSupplierIndex == index
                                  ? Color(0xFF5D75BF)
                                  : Color(0xFFD6D6D6)),
                        ),
                        child: Text(
                          '공급처${index + 1}',
                          style: TextStyle(
                            color: _selectedSupplierIndex == index
                                ? Color(0xFF5D75BF)
                                : Colors.black,
                            fontWeight: _selectedSupplierIndex == index
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            if (widget.suppliers != null &&
                widget.suppliers.isNotEmpty &&
                widget.isAdd)
              TextButton(
                onPressed: () {
                  _showEditDialog();
                },
                child: const Text(
                  '편집',
                  style: TextStyle(
                    color: Color(0xFF5D75BF),
                    fontSize: 14,
                  ),
                ),
              ),
            widget.isAdd
                ? OutlinedButton(
                    onPressed: _showAddSupplierDialog,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFD6D6D6)),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      '공급처 추가',
                      style: TextStyle(
                        color: Color(0xFF323232),
                        fontSize: 14,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        if (widget.suppliers != null && widget.suppliers.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(25.0),
            alignment: Alignment.center,
            height: 170,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              border: Border.all(color: Color(0xFFD6D6D6)),
            ),
            child: Column(
              children: [
                tabTextBox(
                    '업체명 :',
                    '${widget.suppliers[_selectedSupplierIndex!]['supplierName']} / ${widget.suppliers[_selectedSupplierIndex!]['bizRegiNum']}',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '원물가격 :',
                    '${currencyFormat.format((widget.suppliers[_selectedSupplierIndex!]['cost']))}원',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '공급물량 :',
                    '${currencyFormat.format(widget.suppliers[_selectedSupplierIndex!]['volume'])}kg',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '총 금액 :',
                    '${currencyFormat.format(widget.suppliers[_selectedSupplierIndex!]['totalAmount'])}원',
                    120),
              ],
            ),
          ),
      ],
    );
  }
}
