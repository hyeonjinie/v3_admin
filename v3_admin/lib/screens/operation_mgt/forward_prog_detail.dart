/*
- 운영관리 > 선도거래 > 진행 or 완료 > 주문 상세 페이지 
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:v3_admin/screens/member_mgt/member_detail.dart';
import 'package:intl/intl.dart';
import 'package:v3_admin/screens/operation_mgt/forward_inquiry_detail.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');
// 공급처 목록
final List<Map<String, dynamic>> suppliersList = [
  {
    'supplierName': 'a',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'b',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'c',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'd',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'e',
    "bizRegiNum": "123456789",
  },
  {
    'supplierName': 'f',
    "bizRegiNum": "123456789",
  },
];

// 주문 정보
final Map<String, dynamic> orderInfo = {
  "main": {
    "itemName": "매실",
    "variety": "품종",
    "grade": "못난이",
    "origin": "원산지",
    "price": 1000,
    "unit": "kg",
    "startDate": "2024-06-19",
    "endDate": "2024-06-29",
    "orderCount": 0,
    "volume": 0,
    "totalVolume": 10000,
    "amount": 8000,
    "totalAmount": 10000000,
    "status" : "진행중",
  },
  "client": {
    "companyName": "에스앤이컴퍼니1",
    "bizRegiNum": "7378801827",
    "bizField": "도매",
    "bizType": "소매",
    "managerName": "김희원",
    "contact": "010-0000-0000",
    "bankImg":
        "https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae"
  },
  "suppliers": [
    {
      "supplierId": "I5winMNcKwNVGHkC4O8H",
      "supplierName": "채소회사",
      "bizRegiNum": "123456789",
      "cost": 200,
      "volume": 100,
      "unit": "kg",
      "totalAmount": 20000,
    },
    {
      "supplierId": "I5winMNcKwNVGHkC4O8H",
      "supplierName": "고기회사",
      "bizRegiNum": "123456789",
      "cost": 20000,
      "volume": 200,
      "unit": "kg",
      "totalAmount": 4000000,
    }
  ],
  "subOrders": [
    {
      "quantity": 20,
      "amount": 3000,
      "contact": "0100000000",
      "deliveryDate": "2024-06-20",
      "completedDate": null,
      "registeredDate": "2024-06-13",
      "address": "서울 서초구매헌로 8길39 406호",
      "status": "주문요청",
      "settlement": {
        "settleCompanyId": "",
        "settleCompanyName": "비굿",
        "settleTargetId": "",
        "settleTargetName": "에스앤이컴퍼니1",
        "settleDate": null,
        "settleStatus": "예정"
      },
      "taxInvoice": {
        "taxIssueCompanyId": "",
        "taxIssueCompanyName": "에스앤이컴퍼니1",
        "taxIssueTargetId": "",
        "taxIssueTargetName": "비굿",
        "taxIssueDate": null,
        "taxIssueStatus": "예정",
        "taxApprovalNum": ""
      },
      "subSupplierList": [],
      "subLogisticList": [],
      "subOtherList": []
    },
    {
      "quantity": 10,
      "amount": 5000,
      "contact": "0100000000",
      "deliveryDate": "2024-05-19",
      "completedDate": "2024-05-19",
      "registeredDate": "2024-04-13",
      "address": "서울 서초구매헌로 8길39 406호",
      "status": "배송예정",
      "settlement": {
        "settleCompanyId": "",
        "settleCompanyName": "비굿",
        "settleTargetId": "",
        "settleTargetName": "에스앤이컴퍼니1",
        "settleDate": "2024-05-19",
        "settleStatus": "예정"
      },
      "taxInvoice": {
        "taxIssueCompanyId": "",
        "taxIssueCompanyName": "에스앤이컴퍼니1",
        "taxIssueTargetId": "",
        "taxIssueTargetName": "비굿",
        "taxIssueDate": "2024-05-20",
        "taxIssueStatus": "예정",
        "taxApprovalNum": "20240520-10240521-01010101"
      },
      "subSupplierList": [
        {
          "supplierId": "I5winMNcKwNVGHkC4O8H",
          "supplierName": "채소회사",
          "bizRegiNum": "123456789",
          "cost": 200,
          "volume": 10,
          "unit": "kg",
          "totalAmount": 2000,
          "settlement": {
            "settleCompanyId": "IdyZUA7S6CcsbeKu7h7Gj8k9zpB2",
            "settleCompanyName": "비굿",
            "settleTargetId": "I5winMNcKwNVGHkC4O8H",
            "settleTargetName": "채소회사",
            "settleDate": "2024-06-20",
            "settleStatus": "예정"
          },
          "taxInvoice": {
            "taxIssueCompanyId": "I5winMNcKwNVGHkC4O8H",
            "taxIssueCompanyName": "채소회사",
            "taxIssueTargetId": "IdyZUA7S6CcsbeKu7h7Gj8k9zpB2",
            "taxIssueTargetName": "비굿",
            "taxIssueDate": "2024-06-20",
            "taxIssueStatus": "예정",
            "taxApprovalNum": ""
          }
        },
        {
          "supplierId": "s2YZWzJuBhWi9jWXM5i9",
          "supplierName": "고기회사",
          "bizRegiNum": "987654321",
          "cost": 20,
          "volume": 20,
          "unit": "kg",
          "totalAmount": 400,
          "settlement": {
            "settleCompanyId": "IdyZUA7S6CcsbeKu7h7Gj8k9zpB2",
            "settleCompanyName": "비굿",
            "settleTargetId": "s2YZWzJuBhWi9jWXM5i9",
            "settleTargetName": "고기회사",
            "settleDate": "2024-06-20",
            "settleStatus": "예정"
          },
          "taxInvoice": {
            "taxIssueCompanyId": "s2YZWzJuBhWi9jWXM5i9",
            "taxIssueCompanyName": "고기회사",
            "taxIssueTargetId": "IdyZUA7S6CcsbeKu7h7Gj8k9zpB2",
            "taxIssueTargetName": "비굿",
            "taxIssueDate": "2024-06-20",
            "taxIssueStatus": "예정",
            "taxApprovalNum": ""
          }
        }
      ],
      "subLogisticList": [
        {
          "logisticName": "물류업체1",
          "driverName": "김물류",
          "driverContact": "030303030",
          "totalAmount": 275000,
          "settlement": {
            "settleCompanyId": "IdyZUA7S6CcsbeKu7h7Gj8k9zpB2",
            "settleCompanyName": "비굿",
            "settleTargetId": "",
            "settleTargetName": "지엘물류",
            "settleDate": "2024-06-20",
            "settleStatus": "예정"
          },
          "taxInvoice": {
            "taxIssueCompanyId": "",
            "taxIssueCompanyName": "지엘물류",
            "taxIssueTargetId": "IdyZUA7S6CcsbeKu7h7Gj8k9zpB2",
            "taxIssueTargetName": "비굿",
            "taxIssueDate": "2024-06-20",
            "taxIssueStatus": "예정",
            "taxApprovalNum": ""
          }
        }
      ],
      "subOtherList": [
        {
          "name": "지엘물류",
          "type": "환불",
          "totalAmount": -4600,
          "contents": "보증금 환불",
          "settlement": {
            "settleCompanyId": null,
            "settleCompanyName": "지엘물류",
            "settleTargetId": "비굿uid",
            "settleTargetName": "비굿",
            "settleDate": "2024-06-20",
            "settleStatus": "예정"
          },
          "taxInvoice": {
            "taxIssueCompanyId": "비굿uid",
            "taxIssueCompanyName": "비굿",
            "taxIssueTargetId": null,
            "taxIssueTargetName": "지엘물류",
            "taxIssueDate": "2024-06-20",
            "taxIssueStatus": "예정",
            "taxApprovalNum": ""
          }
        }
      ]
    }
  ]
};

class ProgressDetail extends StatefulWidget {
  const ProgressDetail({super.key});

  @override
  State<ProgressDetail> createState() => _ProgressDetailState();
}

class _ProgressDetailState extends State<ProgressDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 2; // GNB : 운영관리
  int selectedMenu = 2; // SUB : 선도거래 > 진행

  void _updateIndex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (orderInfo["main"]["status"] == "취소") {
      selectedMenu = 3; 
    } else {
      selectedMenu = 2; 
    }
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


// 페이지 메인
class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  XFile? _accountImg;
  final ImagePicker picker = ImagePicker();

  Future getAccountImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _accountImg = XFile(pickedFile.path);
      });
    }
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
              // 디테일 페이지 상단 영역(타이틀 라인)
              Row(
                children: [
                  const Text(
                    '{선도거래 타이틀(거래명)}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton2(
                    text: '목록',
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF9A9A9A),
                    borderColor: Color(0xFFD6D6D6),
                    onPressed: () {
                      context.go('/progress');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1000,
                  decoration: commonBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // 담당자 지정, 상태변경
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 45,
                                  color: Color(0xFFF9FCFE),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          '담당자 : 이준형',
                                          style: TextStyle(
                                            color: Color(0xFF323232),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      const Text(
                                        '2024-06-17',
                                        style: TextStyle(
                                          color: Color(0xFF323232),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Color(0xFFD6D6D6)),
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Text(
                                            '나에게 배정',
                                            style: TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 90,
                                      child: Text(
                                        '상태 변경',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SelectBoxExample(
                                      initialValue: '대기중',
                                      options: const [
                                        '대기중',
                                        '진행중',
                                        '완료',
                                        '취소',
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {});
                                      },
                                      custom_width: 220.0,
                                    ),
                                    const SizedBox(width: 20),
                                    CustomElevatedButton1(
                                      backgroundColor: Color(0xFF5D75BF),
                                      text: '저장',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // 주문 내용
                          Btn_TableBar(
                            titleText: '주문',
                            btnText: '변경내역',
                            onBtnPressed: () {},
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    child: Text(
                                      '품목 / 품종 / 등급 \n원산지 \n단가 \n공급기간',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          height: 2.5),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    child: Text(
                                      '${orderInfo['main']['itemName']} / ${orderInfo['main']['variety']} / ${orderInfo['main']['grade']} \n'
                                      '${orderInfo['main']['origin']} \n${currencyFormat.format(orderInfo['main']['price'])}원 \n'
                                      '${orderInfo['main']['startDate']} ~ ${orderInfo['main']['endDate']}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          height: 2.5),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    child: Text(
                                      '주문회차 \n누적 공급물량 \n누적 금액\n',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          height: 2.5),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                      child: Text(
                                    '${orderInfo['main']['orderCount']}회\n'
                                    '${orderInfo['main']['volume']}kg / ${orderInfo['main']['totalVolume']}kg \n'
                                    '${currencyFormat.format(orderInfo['main']['amount'])}원 / ${currencyFormat.format(orderInfo['main']['totalAmount'])}원\n',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      height: 2.5,
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                          // main 수요처 및 공급처 정보
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // 수요처
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.0),
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 40,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                8.0),
                                                        topRight:
                                                            Radius.circular(
                                                                8.0),
                                                      ),
                                                      border: Border(
                                                        top: BorderSide(
                                                            color: Color(
                                                                0xFFD6D6D6)),
                                                        left: BorderSide(
                                                            color: Color(
                                                                0xFFD6D6D6)),
                                                        right: BorderSide(
                                                            color: Color(
                                                                0xFFD6D6D6)),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      '수요처',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5D75BF),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.0),
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        getAccountImage(
                                                            ImageSource
                                                                .gallery);
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xFFD6D6D6)),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                      child: const Text(
                                                        '통장사본',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF323232),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                  padding: const EdgeInsets.all(
                                                      25.0),
                                                  alignment: Alignment.center,
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(8.0),
                                                      bottomRight:
                                                          Radius.circular(8.0),
                                                      topRight:
                                                          Radius.circular(8.0),
                                                    ),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFFD6D6D6)),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      tabTextBox(
                                                          '업체명 :',
                                                          '${orderInfo['client']['companyName']} / ${orderInfo['client']['bizRegiNum']}',
                                                          120),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      tabTextBox(
                                                          '업태 :',
                                                          '${orderInfo['client']['bizField']}',
                                                          120),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      tabTextBox(
                                                          '종목 :',
                                                          '${orderInfo['client']['bizType']}',
                                                          120),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      tabTextBox(
                                                          '이름/연락처 :',
                                                          '${orderInfo['client']['managerName']} / ${orderInfo['client']['contact']}',
                                                          120),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        // 공급처
                                        Expanded(
                                          child: SuppliersToggleButtons(
                                            orderInfo: orderInfo,
                                            listName: 'suppliers',
                                            isAdd: false,
                                            isSub: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          orderInfo['main']['status'] == '완료' ? 
                          TableBar(titleText: '회차별 주문')
                          : Btn_TableBar(
                            titleText: '회차별 주문',
                            btnText: '주문서 생성',
                            onBtnPressed: () {
                              _showOrderFormDialog(context);
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          OrderList(subOrders: orderInfo["subOrders"]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//-------------------------------------------------------------------------------------------------
// sub 주문 리스트
class OrderList extends StatelessWidget {
  final List<dynamic> subOrders;

  OrderList({required this.subOrders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: subOrders.isEmpty
          ? [Center(child: Text('진행 중인 주문이 없습니다.'))]
          : subOrders
              .asMap()
              .entries
              .map((entry) => OrderCard(order: entry.value, index: entry.key))
              .toList(),
    );
  }
}

// sub 회차별 주문
class OrderCard extends StatefulWidget {
  final Map<String, dynamic> order;
  final int index;

  OrderCard({required this.order, required this.index});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;
  bool isOrderEditing = false;
  bool isMemoEditing = false;
  late TextEditingController quantityController;
  late TextEditingController amountController;
  late TextEditingController contactController;
  late TextEditingController deliveryDateController;
  late TextEditingController completedDateController;
  late TextEditingController addressController;
  late TextEditingController settleTargetNameController;
  late TextEditingController settleCompanyNameController;
  late TextEditingController settleDateController;
  late TextEditingController taxIssueCompanyNameController;
  late TextEditingController taxIssueTargetNameController;
  late TextEditingController taxIssueDateController;
  late TextEditingController taxApprovalNumController;
  late TextEditingController memoController;

  @override
  void initState() {
    super.initState();
    memoController = TextEditingController();
    quantityController =
        TextEditingController(text: widget.order['quantity'].toString());
    amountController =
        TextEditingController(text: widget.order['amount'].toString());
    contactController = TextEditingController(text: widget.order['contact']);
    deliveryDateController =
        TextEditingController(text: widget.order['deliveryDate']);
    completedDateController =
        TextEditingController(text: widget.order['completedDate'] ?? '');
    addressController = TextEditingController(text: widget.order['address']);
    settleTargetNameController = TextEditingController(
        text: widget.order['settlement']['settleTargetName']);
    settleCompanyNameController = TextEditingController(
        text: widget.order['settlement']['settleCompanyName']);
    settleDateController = TextEditingController(
        text: widget.order['settlement']['settleDate'] ?? '');
    taxIssueCompanyNameController = TextEditingController(
        text: widget.order['taxInvoice']['taxIssueCompanyName']);
    taxIssueTargetNameController = TextEditingController(
        text: widget.order['taxInvoice']['taxIssueTargetName']);
    taxIssueDateController = TextEditingController(
        text: widget.order['taxInvoice']['taxIssueDate'] ?? '');
    taxApprovalNumController = TextEditingController(
        text: widget.order['taxInvoice']['taxApprovalNum'] ?? '');
    memoController = TextEditingController(text: '');
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Color(0xFFF9FCFE),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Color(0xFFD1D1D1)),
      ),
      child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 1,
                      color: Color(0xFF00AF66),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.index + 1}회차',
                      style: const TextStyle(
                        color: Color(0xFF00AF66),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${widget.order['quantity']}kg  |  ${widget.order['amount']}원',
                  style: const TextStyle(
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.order['registeredDate']}',
                  style: const TextStyle(
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${widget.order['status']}',
                  style: TextStyle(
                    color: _getStatusColor('${widget.order['status']}'),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded)
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // sub 주문일, 진행상태
                  Row(
                    children: [
                      Text('주문일: ${widget.order['registeredDate']}'),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 90,
                            child: Text(
                              '진행상태',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SelectBoxExample(
                            initialValue: '${widget.order['status']}',
                            options: const [
                              '주문요청',
                              '배송예정',
                              '배송완료',
                            ],
                            onChanged: (String? newValue) {
                              setState(() {});
                            },
                            custom_width: 220.0,
                          ),
                          SizedBox(width: 20),
                          CustomElevatedButton1(
                            backgroundColor: Color(0xFF5D75BF),
                            text: '저장',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // sub 주문 내용, 메모
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    '주문 내용',
                                    style: TextStyle(
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isOrderEditing = !isOrderEditing;
                                      });
                                    },
                                    child: Text(
                                      isOrderEditing ? '저장' : '편집',
                                      style: const TextStyle(
                                        color: Color(0xFF5D75BF),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFD0D0D0)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    isOrderEditing
                                        ? customTextField(
                                            '거래량 :',
                                            '(kg) 단위로 숫자만 입력',
                                            quantityController,
                                            150)
                                        : tabTextBox(
                                            '거래량 :',
                                            '${widget.order['quantity']}kg',
                                            150),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? customTextField(
                                            '금액 :',
                                            '(원) 단위로 숫자만 입력',
                                            amountController,
                                            150)
                                        : tabTextBox('금액 :',
                                            '${widget.order['amount']}원', 150),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? customTextField('담당자 연락처 :', '',
                                            contactController, 150)
                                        : tabTextBox('담당자 연락처 :',
                                            '${widget.order['contact']}', 150),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      '배송희망일 : ',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  CustomDatePickerField(
                                                    controller:
                                                        deliveryDateController,
                                                    onDateTap: _selectDate,
                                                    hintText: '',
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 16.0),
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      '배송완료일 : ',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  CustomDatePickerField(
                                                    controller:
                                                        completedDateController,
                                                    onDateTap: _selectDate,
                                                    hintText: '',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : tabTextBox(
                                            '배송희망일/완료일 :',
                                            '${widget.order['deliveryDate']} / ${widget.order['completedDate'] ?? '-'}',
                                            150),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? customTextField(
                                            '배송지 :', '', addressController, 150)
                                        : tabTextBox('배송지 :',
                                            '${widget.order['address']}', 150),
                                    SizedBox(height: 16.0),
                                    Divider(),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? textToText(
                                            settleCompanyNameController,
                                            settleTargetNameController,
                                            '정산 :',
                                            150,
                                            160)
                                        : tabTextBox(
                                            '정산 :',
                                            '${widget.order['settlement']['settleTargetName']} → ${widget.order['settlement']['settleCompanyName']}',
                                            150),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? Row(
                                            children: [
                                              const SizedBox(
                                                width: 150,
                                                child: Text(
                                                  '정산일 : ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              CustomDatePickerField(
                                                controller:
                                                    completedDateController,
                                                onDateTap: _selectDate,
                                                hintText: '',
                                              ),
                                            ],
                                          )
                                        : tabTextBox(
                                            ' - 정산일 :',
                                            '${widget.order['settlement']['settleDate'] ?? '-'}',
                                            150),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? textToText(
                                            taxIssueCompanyNameController,
                                            taxIssueTargetNameController,
                                            '세금계산서 :',
                                            150,
                                            160)
                                        : tabTextBox(
                                            '세금계산서 :',
                                            '${widget.order['taxInvoice']['taxIssueCompanyName']} → ${widget.order['taxInvoice']['taxIssueTargetName']}',
                                            150),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? Row(
                                            children: [
                                              const SizedBox(
                                                width: 150,
                                                child: Text(
                                                  ' - 발행일 : ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              CustomDatePickerField(
                                                controller:
                                                    taxIssueDateController,
                                                onDateTap: _selectDate,
                                                hintText: '',
                                              ),
                                            ],
                                          )
                                        : tabTextBox(
                                            ' - 발행일 :',
                                            '${widget.order['taxInvoice']['taxIssueDate'] ?? '-'}',
                                            150),
                                    SizedBox(height: 16.0),
                                    isOrderEditing
                                        ? customTextField(' - 승인번호 :', '',
                                            taxApprovalNumController, 150)
                                        : tabTextBox(
                                            ' - 승인번호 :',
                                            '${widget.order['taxInvoice']['taxApprovalNum'] == '' ? '-' : widget.order['taxInvoice']['taxApprovalNum']}',
                                            150),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    '메모',
                                    style: TextStyle(
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isMemoEditing = !isMemoEditing;
                                      });
                                    },
                                    child: Text(
                                      isMemoEditing ? '저장' : '편집',
                                      style: const TextStyle(
                                        color: Color(0xFF5D75BF),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFD6D6D6),
                                  ),
                                ),
                                child: isMemoEditing
                                    ? TextField(
                                        controller: memoController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        expands: true,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8.0),
                                          border: InputBorder.none,
                                          hintText: '내용을 입력하세요',
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          memoController.text,
                                          style: const TextStyle(
                                            color: Color(0xFF323232),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                        // sub 공급처, 물류, 기타
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SuppliersToggleButtons(
                                orderInfo: orderInfo['subOrders'][widget.index],
                                listName: 'subSupplierList',
                                isAdd: true,
                                isSub: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              LogisticButtons(
                                orderInfo: orderInfo['subOrders'][widget.index],
                                listName: 'subLogisticList',
                                isAdd: true,
                                isSub: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              OtherButtons(
                                orderInfo: orderInfo['subOrders'][widget.index],
                                listName: 'subOtherList',
                                isAdd: true,
                                isSub: true,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '주문요청':
        return Color(0xFFFF5F5F);
      case '배송예정':
        return Color(0xFF4470F6);
      default:
        return Color(0xFF00AF66);
    }
  }
}

// sub 회차별 주문 생성
void _showOrderFormDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: 570,
          padding: EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text(
                '회차별 주문서',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              OrderForm(onSubmit: (newSubOrder) {
                orderInfo['subOrders'].add(newSubOrder);
                Navigator.of(context).pop();
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton2(
                    text: '취소',
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF9A9A9A),
                    borderColor: Color(0xFFD6D6D6),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 15),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: '제출',
                    onPressed: () {
                      print(OrderForm.of(context));
                      // OrderForm.of(context).submitForm();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// sub 회차별 주문 생성 폼
class OrderForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  OrderForm({required this.onSubmit});

  static OrderFormState of(BuildContext context) =>
      context.findAncestorStateOfType<OrderFormState>()!;

  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController contactController;
  late TextEditingController addressController;
  late TextEditingController deliveryDateController;
  late TextEditingController settleCompanyNameController;
  late TextEditingController settleTargetNameController;
  late TextEditingController settleDateController;
  late TextEditingController taxIssueCompanyNameController;
  late TextEditingController taxIssueTargetNameController;
  late TextEditingController taxIssueDateController;

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController();
    priceController = TextEditingController();
    contactController = TextEditingController();
    addressController = TextEditingController();
    deliveryDateController = TextEditingController();
    settleCompanyNameController = TextEditingController();
    settleTargetNameController = TextEditingController();
    settleDateController = TextEditingController();
    taxIssueCompanyNameController = TextEditingController();
    taxIssueTargetNameController = TextEditingController();
    taxIssueDateController = TextEditingController();
  }

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    contactController.dispose();
    addressController.dispose();
    deliveryDateController.dispose();
    settleCompanyNameController.dispose();
    settleTargetNameController.dispose();
    settleDateController.dispose();
    taxIssueCompanyNameController.dispose();
    taxIssueTargetNameController.dispose();
    taxIssueDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final newSubOrder = {
        'quantity': int.parse(quantityController.text),
        'amount': int.parse(priceController.text),
        'contact': contactController.text,
        'deliveryDate': deliveryDateController.text,
        'completedDate': '',
        'registeredDate': DateTime.now().toIso8601String().split('T')[0],
        'address': addressController.text,
        'status': '주문요청',
        "settlement": {
          "settleCompanyId": "",
          "settleCompanyName": settleCompanyNameController.text,
          "settleTargetId": "",
          "settleTargetName": settleTargetNameController.text,
          "settleDate": settleDateController.text.isEmpty
              ? ""
              : settleDateController.text,
          "settleStatus": "예정"
        },
        "taxInvoice": {
          "taxIssueCompanyId": "",
          "taxIssueCompanyName": taxIssueCompanyNameController.text,
          "taxIssueTargetId": "",
          "taxIssueTargetName": taxIssueTargetNameController.text,
          "taxIssueDate": taxIssueDateController.text.isEmpty
              ? ""
              : taxIssueDateController.text,
          "taxIssueStatus": "예정",
          "taxApprovalNum": ""
        },
        'subSupplierList': [],
        'subLogisticList': [],
        'subOtherList': []
      };

      widget.onSubmit(newSubOrder);
    }
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
              customTextField(
                  '거래량', '(kg) 단위로 숫자만 입력', quantityController, 120),
              const SizedBox(height: 10),
              customTextField('금액', '(원) 단위로 숫자만 입력', priceController, 120),
              const SizedBox(height: 10),
              customTextField('담당자연락처', '', contactController, 120),
              const SizedBox(height: 10),
              customTextField('배송지', '', addressController, 120),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text(
                      '배송희망일',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 45,
                    child: CustomDatePickerField(
                      controller: deliveryDateController,
                      onDateTap: _selectDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              textToText(settleCompanyNameController,
                  settleTargetNameController, '정산', 120, 160),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text(
                      ' - 정산일',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 45,
                    child: CustomDatePickerField(
                      controller: settleDateController,
                      onDateTap: _selectDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              textToText(taxIssueCompanyNameController,
                  taxIssueTargetNameController, '세금계산서', 120, 160),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text(
                      ' - 발행일',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 45,
                    child: CustomDatePickerField(
                      controller: taxIssueDateController,
                      onDateTap: _selectDate,
                    ),
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

//-------------------------------------------------------------------------------------------------
// sub 공급처
class SuppliersToggleButtons extends StatefulWidget {
  final Map<String, dynamic> orderInfo;
  final String listName;
  final bool isAdd;
  final bool isSub;

  SuppliersToggleButtons({
    required this.orderInfo,
    required this.listName,
    required this.isAdd,
    required this.isSub,
  });

  @override
  _SuppliersToggleButtonsState createState() => _SuppliersToggleButtonsState();
}

class _SuppliersToggleButtonsState extends State<SuppliersToggleButtons> {
  int _selectedSupplierIndex = 0;
  late Map<String, dynamic> _orderInfo;

  @override
  void initState() {
    super.initState();
    _orderInfo = Map.from(widget.orderInfo);
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuppliersEdit(
          suppliers: List.from(widget.orderInfo[widget.listName]),
          onSave: (updatedSuppliers) {
            setState(() {
              widget.orderInfo[widget.listName] = updatedSuppliers;
            });
          },
        );
      },
    );
  }

  void _showAddSupplierDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddSupplierDialog(
          onSupplierSelected: (selectedSupplier, price, volume, amount) {
            setState(() {
              _orderInfo['subSupplierList'].add({
                'supplierId': '',
                'supplierName': selectedSupplier['supplierName'],
                'bizRegiNum': selectedSupplier['bizRegiNum'],
                'cost': price,
                'volume': volume,
                'unit': 'kg',
                'totalAmount': amount,
                'settlement': {
                  'settleCompanyId': '',
                  'settleCompanyName': '비굿',
                  'settleTargetId': '',
                  'settleTargetName': selectedSupplier['supplierName'],
                  'settleDate': null,
                  'settleStatus': '예정'
                },
                'taxInvoice': {
                  'taxIssueCompanyId': '',
                  'taxIssueCompanyName': selectedSupplier['supplierName'],
                  'taxIssueTargetId': '',
                  'taxIssueTargetName': '비굿',
                  'taxIssueDate': null,
                  'taxIssueStatus': '예정',
                  'taxApprovalNum': ''
                }
              });
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> suppliers = widget.orderInfo[widget.listName];

    return Column(
      children: [
        Row(
          children: [
            if (suppliers == null || suppliers.isEmpty)
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
                  children: List<Widget>.generate(suppliers.length, (index) {
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
            if (suppliers != null && suppliers.isNotEmpty && widget.isAdd)
              TextButton(
                onPressed: _showEditDialog,
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
        if (suppliers != null && suppliers.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(25.0),
            alignment: Alignment.center,
            height: widget.isSub ? 360 : 170,
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
                    '${suppliers[_selectedSupplierIndex!]['supplierName']} / ${suppliers[_selectedSupplierIndex!]['bizRegiNum']}',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox('원물가격 :',
                    '${suppliers[_selectedSupplierIndex!]['cost']}원', 120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox('공급물량 :',
                    '${suppliers[_selectedSupplierIndex!]['volume']}kg', 120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '총 금액 :',
                    '${suppliers[_selectedSupplierIndex!]['totalAmount']}원',
                    120),
                if (widget.isSub) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  tabTextBox(
                      '정산 :',
                      '${suppliers[_selectedSupplierIndex!]['settlement']['settleCompanyName']}  →  ${suppliers[_selectedSupplierIndex!]['settlement']['settleTargetName']}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 정산일 :',
                      '${suppliers[_selectedSupplierIndex!]['settlement']['settleDate'] ?? '-'}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      '세금계산서 :',
                      '${suppliers[_selectedSupplierIndex!]['taxInvoice']['taxIssueCompanyName']} → ${suppliers[_selectedSupplierIndex!]['taxInvoice']['taxIssueTargetName']}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 발행일 :',
                      '${suppliers[_selectedSupplierIndex!]['taxInvoice']['taxIssueDate'] ?? '-'}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 승인번호 :',
                      '${suppliers[_selectedSupplierIndex!]['taxInvoice']['taxApprovalNum'] == '' ? '-' : suppliers[_selectedSupplierIndex!]['taxInvoice']['taxApprovalNum']}',
                      120),
                ]
              ],
            ),
          ),
      ],
    );
  }
}

// 공급처 편집 팝업창
class SuppliersEdit extends StatefulWidget {
  final List<dynamic> suppliers;
  final Function(List<Map<String, dynamic>>) onSave;

  SuppliersEdit({required this.suppliers, required this.onSave});

  @override
  _SuppliersEditState createState() => _SuppliersEditState();
}

class _SuppliersEditState extends State<SuppliersEdit> {
  late List<Map<String, dynamic>> _tempSuppliers;

  @override
  void initState() {
    super.initState();
    _tempSuppliers = List.from(widget.suppliers);
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 570,
        padding: EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '공급처 정보 편집',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tempSuppliers.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFF5D75BF),
                            ),
                            onPressed: () {
                              setState(() {
                                _tempSuppliers.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      customTextField(
                          '업체명',
                          '업체명을 입력하세요',
                          TextEditingController(
                            text: _tempSuppliers[index]['supplierName'],
                          ),
                          120),
                      const SizedBox(height: 10),
                      customTextField(
                          '사업자등록번호',
                          '사업자등록번호를 입력하세요',
                          TextEditingController(
                            text: _tempSuppliers[index]['bizRegiNum'],
                          ),
                          120),
                      const SizedBox(height: 10),
                      customTextField(
                          '원물가격',
                          '원물가격을 입력하세요',
                          TextEditingController(
                            text: _tempSuppliers[index]['cost'].toString(),
                          ),
                          120),
                      const SizedBox(height: 10),
                      customTextField(
                          '공급물량',
                          '공급물량을 입력하세요',
                          TextEditingController(
                            text: _tempSuppliers[index]['volume'].toString(),
                          ),
                          120),
                      const SizedBox(height: 10),
                      customTextField(
                          '총 금액',
                          '총 금액을 입력하세요',
                          TextEditingController(
                            text:
                                _tempSuppliers[index]['totalAmount'].toString(),
                          ),
                          120),
                      const SizedBox(height: 20),
                      customTextField(
                        '정산(업체)',
                        '정산 업체명을 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['settlement']
                              ['settleCompanyName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '정산(대상)',
                        '정산 대상명을 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['settlement']
                              ['settleTargetName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text(
                              ' - 정산일 : ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CustomDatePickerField(
                            controller: TextEditingController(
                              text: _tempSuppliers[index]['settlement']
                                  ['settleDate'],
                            ),
                            onDateTap: _selectDate,
                            hintText: '정산일을 선택하세요',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '세금계산서(발행)',
                        '세금계산서 발행자명을 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['taxInvoice']
                              ['taxIssueCompanyName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '세금계산서(대상)',
                        '세금계산서 대상자명을 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['taxInvoice']
                              ['taxIssueTargetName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text(
                              ' - 발행일 : ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CustomDatePickerField(
                            controller: TextEditingController(
                              text: _tempSuppliers[index]['taxInvoice']
                                  ['taxIssueDate'],
                            ),
                            onDateTap: _selectDate,
                            hintText: '발행일을 선택하세요',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        ' - 승인번호',
                        '세금계산서 승인번호를 입력하세요',
                        TextEditingController(
                          text: _tempSuppliers[index]['taxInvoice']
                              ['taxApprovalNum'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton2(
                  text: '취소',
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF9A9A9A),
                  borderColor: Color(0xFFD6D6D6),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                CustomElevatedButton1(
                  backgroundColor: Color(0xFF5D75BF),
                  text: '수정',
                  onPressed: () {
                    widget.onSave(_tempSuppliers);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------------
// sub 물류
class LogisticButtons extends StatefulWidget {
  final Map<String, dynamic> orderInfo;
  final String listName;
  final bool isAdd;
  final bool isSub;

  LogisticButtons(
      {required this.orderInfo,
      required this.listName,
      required this.isAdd,
      required this.isSub});

  @override
  State<LogisticButtons> createState() => _LogisticButtonsState();
}

class _LogisticButtonsState extends State<LogisticButtons> {
  int _selectedLogisticIndex = 0;
  late Map<String, dynamic> _orderInfo;

  @override
  void initState() {
    super.initState();
    _orderInfo = Map.from(widget.orderInfo);
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogisticsEdit(
          logistics: List.from(widget.orderInfo[widget.listName]),
          onSave: (updatedLogistics) {
            setState(() {
              widget.orderInfo[widget.listName] = updatedLogistics;
            });
          },
        );
      },
    );
  }

  void _showAddLogisticDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddLogisticDialog(
          onLogisticSelected: (name, driver, dcontact, amount) {
            setState(() {
              _orderInfo['subLogisticList'].add({
                'logisticName': name,
                'driverName': driver,
                'driverContact': dcontact,
                'totalAmount': amount,
                'settlement': {
                  'settleCompanyId': '',
                  'settleCompanyName': '비굿',
                  'settleTargetId': '',
                  'settleTargetName': name,
                  'settleDate': null,
                  'settleStatus': '예정'
                },
                'taxInvoice': {
                  'taxIssueCompanyId': '',
                  'taxIssueCompanyName': name,
                  'taxIssueTargetId': '',
                  'taxIssueTargetName': '비굿',
                  'taxIssueDate': null,
                  'taxIssueStatus': '예정',
                  'taxApprovalNum': ''
                }
              });
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> logistics = widget.orderInfo[widget.listName];

    return Column(
      children: [
        Row(
          children: [
            if (logistics == null || logistics.isEmpty)
              const Expanded(
                child: Row(
                  children: [
                    Text(
                      '물류 정보 없음',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
              )
            else
              Expanded(
                child: Row(
                  children: List<Widget>.generate(logistics.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLogisticIndex = index;
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
                              color: _selectedLogisticIndex == index
                                  ? Color(0xFF5D75BF)
                                  : Color(0xFFD6D6D6)),
                        ),
                        child: Text(
                          '물류${index + 1}',
                          style: TextStyle(
                            color: _selectedLogisticIndex == index
                                ? Color(0xFF5D75BF)
                                : Colors.black,
                            fontWeight: _selectedLogisticIndex == index
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            if (logistics != null && logistics.isNotEmpty && widget.isAdd)
              TextButton(
                onPressed: _showEditDialog,
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
                    onPressed: _showAddLogisticDialog,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFD6D6D6)),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      '물류 추가',
                      style: TextStyle(
                        color: Color(0xFF323232),
                        fontSize: 14,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        if (logistics != null && logistics.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(25.0),
            alignment: Alignment.center,
            height: widget.isSub ? 330 : 170,
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
                    '${logistics[_selectedLogisticIndex!]['logisticName']}',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '담당기사 :',
                    '${logistics[_selectedLogisticIndex!]['driverName']} / ${logistics[_selectedLogisticIndex!]['driverContact']}',
                    120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '물류비 :',
                    '${logistics[_selectedLogisticIndex!]['totalAmount']}원',
                    120),
                if (widget.isSub) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  tabTextBox(
                      '정산 :',
                      '${logistics[_selectedLogisticIndex!]['settlement']['settleCompanyName']}  →  ${logistics[_selectedLogisticIndex!]['settlement']['settleTargetName']}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 정산일 :',
                      '${logistics[_selectedLogisticIndex!]['settlement']['settleDate'] ?? '-'}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      '세금계산서 :',
                      '${logistics[_selectedLogisticIndex!]['taxInvoice']['taxIssueCompanyName']} → ${logistics[_selectedLogisticIndex!]['taxInvoice']['taxIssueTargetName']}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 발행일 :',
                      '${logistics[_selectedLogisticIndex!]['taxInvoice']['taxIssueDate'] ?? '-'}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 승인번호 :',
                      '${logistics[_selectedLogisticIndex!]['taxInvoice']['taxApprovalNum'] == '' ? '-' : logistics[_selectedLogisticIndex!]['taxInvoice']['taxApprovalNum']}',
                      120),
                ]
              ],
            ),
          ),
      ],
    );
  }
}

// 물류 편집 팝업창
class LogisticsEdit extends StatefulWidget {
  final List<dynamic> logistics;
  final Function(List<Map<String, dynamic>>) onSave;
  LogisticsEdit({required this.logistics, required this.onSave});

  @override
  State<LogisticsEdit> createState() => _LogisticsEditState();
}

class _LogisticsEditState extends State<LogisticsEdit> {
  late List<Map<String, dynamic>> _tempLogistics;

  @override
  void initState() {
    super.initState();
    _tempLogistics = List.from(widget.logistics);
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 570,
        padding: EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '물류 정보 편집',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tempLogistics.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFF5D75BF),
                            ),
                            onPressed: () {
                              setState(() {
                                _tempLogistics.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      customTextField(
                          '업체명',
                          '업체명을 입력하세요',
                          TextEditingController(
                            text: _tempLogistics[index]['logisticName'],
                          ),
                          120),
                      const SizedBox(height: 10),
                      customTextField(
                          '담당기사',
                          '담당기사 이름을 입력하세요',
                          TextEditingController(
                            text: _tempLogistics[index]['driverName'],
                          ),
                          120),
                      const SizedBox(height: 10),
                      customTextField(
                          '연락처',
                          '담당기사 연락처를 입력하세요',
                          TextEditingController(
                            text: _tempLogistics[index]['driverContact'],
                          ),
                          120),
                      const SizedBox(height: 10),
                      customTextField(
                          '물류비',
                          '물류비를 입력하세요',
                          TextEditingController(
                            text:
                                _tempLogistics[index]['totalAmount'].toString(),
                          ),
                          120),
                      const SizedBox(height: 20),
                      customTextField(
                        '정산(업체)',
                        '정산 업체명을 입력하세요',
                        TextEditingController(
                          text: _tempLogistics[index]['settlement']
                              ['settleCompanyName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '정산(대상)',
                        '정산 대상명을 입력하세요',
                        TextEditingController(
                          text: _tempLogistics[index]['settlement']
                              ['settleTargetName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text(
                              ' - 정산일 : ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CustomDatePickerField(
                            controller: TextEditingController(
                              text: _tempLogistics[index]['settlement']
                                  ['settleDate'],
                            ),
                            onDateTap: _selectDate,
                            hintText: '정산일을 선택하세요',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '세금계산서(발행)',
                        '세금계산서 발행자명을 입력하세요',
                        TextEditingController(
                          text: _tempLogistics[index]['taxInvoice']
                              ['taxIssueCompanyName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '세금계산서(대상)',
                        '세금계산서 대상자명을 입력하세요',
                        TextEditingController(
                          text: _tempLogistics[index]['taxInvoice']
                              ['taxIssueTargetName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text(
                              ' - 발행일 : ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CustomDatePickerField(
                            controller: TextEditingController(
                              text: _tempLogistics[index]['taxInvoice']
                                  ['taxIssueDate'],
                            ),
                            onDateTap: _selectDate,
                            hintText: '발행일을 선택하세요',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        ' - 승인번호',
                        '세금계산서 승인번호를 입력하세요',
                        TextEditingController(
                          text: _tempLogistics[index]['taxInvoice']
                              ['taxApprovalNum'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton2(
                  text: '취소',
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF9A9A9A),
                  borderColor: Color(0xFFD6D6D6),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                CustomElevatedButton1(
                  backgroundColor: Color(0xFF5D75BF),
                  text: '수정',
                  onPressed: () {
                    widget.onSave(_tempLogistics);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 물류 추가 팝업창
class AddLogisticDialog extends StatefulWidget {
  final void Function(String, String, String, int) onLogisticSelected;
  const AddLogisticDialog({required this.onLogisticSelected});

  @override
  State<AddLogisticDialog> createState() => _AddLogisticDialogState();
}

class _AddLogisticDialogState extends State<AddLogisticDialog> {
  late TextEditingController nameController; //업체명
  late TextEditingController driverController; //담당기사
  late TextEditingController dcontactController; //담당기사 연락처
  late TextEditingController amountController; //물류비

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    driverController = TextEditingController();
    dcontactController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    driverController.dispose();
    dcontactController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 570,
        padding: EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            const Text(
              '물류 추가',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              width: 540,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD6D6D6)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  customTextField('업체명', '', nameController, 120),
                  const SizedBox(height: 20),
                  customTextField('담당기사명', '', driverController, 120),
                  const SizedBox(height: 10),
                  customTextField(
                      '연락처', '담당기사 연락처 입력', dcontactController, 120),
                  const SizedBox(height: 10),
                  customTextField(
                      '물류비', '(원) 단위로 숫자만 입력', amountController, 120),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton2(
                  text: '취소',
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF9A9A9A),
                  borderColor: Color(0xFFD6D6D6),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                CustomElevatedButton1(
                  backgroundColor: Color(0xFF5D75BF),
                  text: '등록',
                  onPressed: () {
                    widget.onLogisticSelected(
                      nameController.text ?? '',
                      driverController.text ?? '',
                      dcontactController.text ?? '',
                      int.tryParse(amountController.text) ?? 0,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------------
// sub 기타
class OtherButtons extends StatefulWidget {
  final Map<String, dynamic> orderInfo;
  final String listName;
  final bool isAdd;
  final bool isSub;

  OtherButtons(
      {required this.orderInfo,
      required this.listName,
      required this.isAdd,
      required this.isSub});

  @override
  State<OtherButtons> createState() => _OtherButtonsState();
}

class _OtherButtonsState extends State<OtherButtons> {
  int _selectedOtherIndex = 0;
  late Map<String, dynamic> _orderInfo;

  @override
  void initState() {
    super.initState();
    _orderInfo = Map.from(widget.orderInfo);
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OthersEdit(
          others: List.from(widget.orderInfo[widget.listName]),
          onSave: (updatedLogistics) {
            setState(() {
              widget.orderInfo[widget.listName] = updatedLogistics;
            });
          },
        );
      },
    );
  }

  void _showAddOthersDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddOtherDialog(
          onOtherSelected: (name, type, contents, amount) {
            setState(() {
              _orderInfo['subOtherList'].add({
                'name': name,
                'type': type,
                'totalAmount': amount,
                'contents': contents,
                'settlement': {
                  'settleCompanyId': '',
                  'settleCompanyName': '비굿',
                  'settleTargetId': '',
                  'settleTargetName': name,
                  'settleDate': null,
                  'settleStatus': '예정'
                },
                'taxInvoice': {
                  'taxIssueCompanyId': '',
                  'taxIssueCompanyName': name,
                  'taxIssueTargetId': '',
                  'taxIssueTargetName': '비굿',
                  'taxIssueDate': null,
                  'taxIssueStatus': '예정',
                  'taxApprovalNum': ''
                }
              });
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> others = widget.orderInfo[widget.listName];

    return Column(
      children: [
        Row(
          children: [
            if (others == null || others.isEmpty)
              const Expanded(
                child: Row(
                  children: [
                    Text(
                      '기타 정보 없음',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
              )
            else
              Expanded(
                child: Row(
                  children: List<Widget>.generate(others.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOtherIndex = index;
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
                              color: _selectedOtherIndex == index
                                  ? Color(0xFF5D75BF)
                                  : Color(0xFFD6D6D6)),
                        ),
                        child: Text(
                          '기타${index + 1}',
                          style: TextStyle(
                            color: _selectedOtherIndex == index
                                ? Color(0xFF5D75BF)
                                : Colors.black,
                            fontWeight: _selectedOtherIndex == index
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            if (others != null && others.isNotEmpty && widget.isAdd)
              TextButton(
                onPressed: _showEditDialog,
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
                    onPressed: _showAddOthersDialog,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFD6D6D6)),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      '기타 추가',
                      style: TextStyle(
                        color: Color(0xFF323232),
                        fontSize: 14,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        if (others != null && others.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(25.0),
            alignment: Alignment.center,
            height: widget.isSub ? 360 : 170,
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
                    '업체명 :', '${others[_selectedOtherIndex!]['name']}', 120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '유형 :', '${others[_selectedOtherIndex!]['type']}', 120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox('총 금액 :',
                    '${others[_selectedOtherIndex!]['totalAmount']}원', 120),
                const SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '내용 :', '${others[_selectedOtherIndex!]['contents']}', 120),
                if (widget.isSub) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  tabTextBox(
                      '정산 :',
                      '${others[_selectedOtherIndex!]['settlement']['settleCompanyName']}  →  ${others[_selectedOtherIndex!]['settlement']['settleTargetName']}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 정산일 :',
                      '${others[_selectedOtherIndex!]['settlement']['settleDate'] ?? '-'}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      '세금계산서 :',
                      '${others[_selectedOtherIndex!]['taxInvoice']['taxIssueCompanyName']} → ${others[_selectedOtherIndex!]['taxInvoice']['taxIssueTargetName']}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 발행일 :',
                      '${others[_selectedOtherIndex!]['taxInvoice']['taxIssueDate'] ?? '-'}',
                      120),
                  const SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 승인번호 :',
                      '${others[_selectedOtherIndex!]['taxInvoice']['taxApprovalNum'] == '' ? '-' : others[_selectedOtherIndex!]['taxInvoice']['taxApprovalNum']}',
                      120),
                ]
              ],
            ),
          ),
      ],
    );
  }
}

// 기타 편집 팝업창
class OthersEdit extends StatefulWidget {
  final List<dynamic> others;
  final Function(List<Map<String, dynamic>>) onSave;

  OthersEdit({required this.others, required this.onSave});

  @override
  State<OthersEdit> createState() => _OthersEditState();
}

class _OthersEditState extends State<OthersEdit> {
  late List<Map<String, dynamic>> _tempOthers;

  @override
  void initState() {
    super.initState();
    _tempOthers = List.from(widget.others);
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: 570,
        padding: EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '기타 정보 편집',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tempOthers.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFF5D75BF),
                            ),
                            onPressed: () {
                              setState(() {
                                _tempOthers.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      customTextField(
                          '업체명',
                          '업체명을 입력하세요',
                          TextEditingController(
                            text: _tempOthers[index]['name'],
                          ),
                          120),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text(
                              '유형',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SelectBoxExample(
                            initialValue: _tempOthers[index]['type'],
                            options: const ['환불', '기타'],
                            onChanged: (String? newValue) {
                              setState(() {
                                _tempOthers[index]['type'] = newValue!;
                              });
                            },
                            custom_width: 200,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                          '총 금액',
                          '총 금액을 입력하세요',
                          TextEditingController(
                            text: _tempOthers[index]['totalAmount'].toString(),
                          ),
                          120),
                      const SizedBox(height: 10),
                      customTextField(
                          '내용',
                          '내용을 입력하세요',
                          TextEditingController(
                            text: _tempOthers[index]['contents'],
                          ),
                          120),
                      const SizedBox(height: 20),
                      customTextField(
                        '정산(업체)',
                        '정산 업체명을 입력하세요',
                        TextEditingController(
                          text: _tempOthers[index]['settlement']
                              ['settleCompanyName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '정산(대상)',
                        '정산 대상명을 입력하세요',
                        TextEditingController(
                          text: _tempOthers[index]['settlement']
                              ['settleTargetName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text(
                              ' - 정산일 : ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CustomDatePickerField(
                            controller: TextEditingController(
                              text: _tempOthers[index]['settlement']
                                  ['settleDate'],
                            ),
                            onDateTap: _selectDate,
                            hintText: '정산일을 선택하세요',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '세금계산서(발행)',
                        '세금계산서 발행자명을 입력하세요',
                        TextEditingController(
                          text: _tempOthers[index]['taxInvoice']
                              ['taxIssueCompanyName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        '세금계산서(대상)',
                        '세금계산서 대상자명을 입력하세요',
                        TextEditingController(
                          text: _tempOthers[index]['taxInvoice']
                              ['taxIssueTargetName'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text(
                              ' - 발행일 : ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CustomDatePickerField(
                            controller: TextEditingController(
                              text: _tempOthers[index]['taxInvoice']
                                  ['taxIssueDate'],
                            ),
                            onDateTap: _selectDate,
                            hintText: '발행일을 선택하세요',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      customTextField(
                        ' - 승인번호',
                        '세금계산서 승인번호를 입력하세요',
                        TextEditingController(
                          text: _tempOthers[index]['taxInvoice']
                              ['taxApprovalNum'],
                        ),
                        120,
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton2(
                  text: '취소',
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF9A9A9A),
                  borderColor: Color(0xFFD6D6D6),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                CustomElevatedButton1(
                  backgroundColor: Color(0xFF5D75BF),
                  text: '수정',
                  onPressed: () {
                    widget.onSave(_tempOthers);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 기타 추가 팝업창
class AddOtherDialog extends StatefulWidget {
  final void Function(String, String, String, int) onOtherSelected;
  const AddOtherDialog({required this.onOtherSelected});

  @override
  State<AddOtherDialog> createState() => _AddOtherDialogState();
}

class _AddOtherDialogState extends State<AddOtherDialog> {
  late TextEditingController nameController; //업체명
  String selectedType = '환불'; //유형
  late TextEditingController amountController; //총 금액
  late TextEditingController contentsController; //내용

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    contentsController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    contentsController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 570,
        padding: EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text(
              '물류 추가',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              width: 540,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD6D6D6)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  customTextField('업체명', '', nameController, 120),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text(
                          '유형',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SelectBoxExample(
                        initialValue: selectedType,
                        options: const ['환불', '기타'],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedType = newValue!;
                          });
                        },
                        custom_width: 200,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  customTextField(
                      '총 금액', '(원) 단위로 숫자만 입력', amountController, 120),
                  const SizedBox(height: 10),
                  customTextField('내용', '', contentsController, 120),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton2(
                  text: '취소',
                  backgroundColor: Colors.white,
                  textColor: Color(0xFF9A9A9A),
                  borderColor: Color(0xFFD6D6D6),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                CustomElevatedButton1(
                  backgroundColor: Color(0xFF5D75BF),
                  text: '등록',
                  onPressed: () {
                    widget.onOtherSelected(
                      nameController.text ?? '',
                      selectedType,
                      contentsController.text ?? '',
                      int.tryParse(amountController.text) ?? 0,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
