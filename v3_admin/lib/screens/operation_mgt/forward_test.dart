import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

class ProgressTest extends StatefulWidget {
  const ProgressTest({super.key});

  @override
  State<ProgressTest> createState() => _ProgressTestState();
}

class _ProgressTestState extends State<ProgressTest> {
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
    "totalAmount": 10000000
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
          "type": "기타비용",
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

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
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
                  Text(
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
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
                                      Text(
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
                                            side: BorderSide(
                                                color: Color(0xFFD6D6D6)),
                                            backgroundColor: Colors.white,
                                          ),
                                          child: Text(
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
                                    SizedBox(
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
                                      options: [
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
                                    SizedBox(width: 20),
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
                          SizedBox(height: 20),
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
                                Expanded(
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
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          height: 2.5),
                                    ),
                                  ),
                                ),
                                Expanded(
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
                                    style: TextStyle(
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
                                                    decoration: BoxDecoration(
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
                                                    child: Text(
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
                                                      onPressed: () {},
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                            color: Color(
                                                                0xFFD6D6D6)),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                      child: Text(
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
                                                        BorderRadius.only(
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
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      tabTextBox(
                                                          '업태 :',
                                                          '${orderInfo['client']['bizField']}',
                                                          120),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      tabTextBox(
                                                          '종목 :',
                                                          '${orderInfo['client']['bizType']}',
                                                          120),
                                                      SizedBox(
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
                                        SizedBox(
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
                          SizedBox(
                            height: 20,
                          ),
                          Btn_TableBar(
                            titleText: '회차별 주문',
                            btnText: '주문서 생성',
                            onBtnPressed: () {},
                          ),
                          SizedBox(
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

// sub 주문
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

// sub 주문(회차별)
class OrderCard extends StatefulWidget {
  final Map<String, dynamic> order;
  final int index;

  OrderCard({required this.order, required this.index});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;

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
                      style: TextStyle(
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
                  style: TextStyle(
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.order['registeredDate']}',
                  style: TextStyle(
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
                          SizedBox(
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
                            options: [
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
                                  Text(
                                    '주문 내용',
                                    style: TextStyle(
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '편집',
                                      style: TextStyle(
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
                                    tabTextBox('거래량 :',
                                        '${widget.order['quantity']}kg', 150),
                                    SizedBox(height: 16.0),
                                    tabTextBox('금액 :',
                                        '${widget.order['amount']}원', 150),
                                    SizedBox(height: 16.0),
                                    tabTextBox('담당자 연락처 :',
                                        '${widget.order['contact']}', 150),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        '배송희망일/완료일 :',
                                        '${widget.order['deliveryDate']} / ${widget.order['completedDate'] ?? '-'}',
                                        150),
                                    SizedBox(height: 16.0),
                                    tabTextBox('배송지 :',
                                        '${widget.order['address']}', 150),
                                    SizedBox(height: 16.0),
                                    Divider(),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        '정산 :',
                                        '${widget.order['settlement']['settleTargetName']} → ${widget.order['settlement']['settleCompanyName']}',
                                        // widget.order['subSupplierList'].isEmpty? '${widget.index}' : '${widget.order['subSupplierList'][widget.index]['settlement']['settleTargetName']}' '→ ',
                                        150),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        ' - 정산일 :',
                                        '${widget.order['settlement']['settleDate'] ?? '-'}',
                                        150),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        '세금계산서 :',
                                        '${widget.order['taxInvoice']['taxIssueCompanyName']} → ${widget.order['taxInvoice']['taxIssueTargetName']}',
                                        150),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        ' - 발행일 :',
                                        '${widget.order['taxInvoice']['taxIssueDate'] ?? '-'}',
                                        150),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        ' - 승인번호 :',
                                        '${widget.order['taxInvoice']['taxApprovalNum'] == '' ? '-' : widget.order['taxInvoice']['taxApprovalNum']}',
                                        150),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '메모',
                                    style: TextStyle(
                                      color: Color(0xFF323232),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '편집',
                                      style: TextStyle(
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
                                  border: Border.all(color: Color(0xFFD6D6D6)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
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
                              SizedBox(
                                height: 20,
                              ),
                              SuppliersToggleButtons(
                                orderInfo: orderInfo['subOrders'][widget.index],
                                listName: 'subSupplierList',
                                isAdd: true,
                                isSub: true,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              LogisticButtons(
                                orderInfo: orderInfo['subOrders'][widget.index],
                                listName: 'subLogisticList',
                                isAdd: true,
                                isSub: true,
                              ),
                              SizedBox(
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

// sub 공급처
class SuppliersToggleButtons extends StatefulWidget {
  final Map<String, dynamic> orderInfo;
  final String listName;
  final bool isAdd;
  final bool isSub;

  SuppliersToggleButtons(
      {required this.orderInfo,
      required this.listName,
      required this.isAdd,
      required this.isSub});

  @override
  _SuppliersToggleButtonsState createState() => _SuppliersToggleButtonsState();
}

class _SuppliersToggleButtonsState extends State<SuppliersToggleButtons> {
  int _selectedSupplierIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<dynamic> suppliers = widget.orderInfo[widget.listName];

    return Column(
      children: [
        Row(
          children: [
            if (suppliers == null || suppliers.isEmpty)
              Expanded(
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
                          borderRadius: BorderRadius.only(
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
                onPressed: () {},
                child: Text(
                  '편집',
                  style: TextStyle(
                    color: Color(0xFF5D75BF),
                    fontSize: 14,
                  ),
                ),
              ),
            widget.isAdd
                ? OutlinedButton(
                    onPressed: () {},
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
              borderRadius: BorderRadius.only(
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
                SizedBox(
                  height: 12,
                ),
                tabTextBox('원물가격 :',
                    '${suppliers[_selectedSupplierIndex!]['cost']}원', 120),
                SizedBox(
                  height: 12,
                ),
                tabTextBox('공급물량 :',
                    '${suppliers[_selectedSupplierIndex!]['volume']}kg', 120),
                SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '총 금액 :',
                    '${suppliers[_selectedSupplierIndex!]['totalAmount']}원',
                    120),
                if (widget.isSub) ...[
                  SizedBox(height: 12),
                  Divider(),
                  SizedBox(height: 12),
                  tabTextBox(
                      '정산 :',
                      '${suppliers[_selectedSupplierIndex!]['settlement']['settleCompanyName']}  →  ${suppliers[_selectedSupplierIndex!]['settlement']['settleTargetName']}',
                      120),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 정산일 :',
                      '${suppliers[_selectedSupplierIndex!]['settlement']['settleDate'] ?? '-'}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      '세금계산서 :',
                      '${suppliers[_selectedSupplierIndex!]['taxInvoice']['taxIssueCompanyName']} → ${suppliers[_selectedSupplierIndex!]['taxInvoice']['taxIssueTargetName']}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 발행일 :',
                      '${suppliers[_selectedSupplierIndex!]['taxInvoice']['taxIssueDate'] ?? '-'}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 승인번호 :',
                      '${suppliers[_selectedSupplierIndex!]['taxInvoice']['taxApprovalNum'] == '' ? '-' : suppliers[_selectedSupplierIndex!]['taxInvoice']['taxApprovalNum']}',
                      150),
                ]
              ],
            ),
          ),
      ],
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    List<dynamic> logistics = widget.orderInfo[widget.listName];

    return Column(
      children: [
        Row(
          children: [
            if (logistics == null || logistics.isEmpty)
              Expanded(
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
                          borderRadius: BorderRadius.only(
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
                onPressed: () {},
                child: Text(
                  '편집',
                  style: TextStyle(
                    color: Color(0xFF5D75BF),
                    fontSize: 14,
                  ),
                ),
              ),
            widget.isAdd
                ? OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFD6D6D6)),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
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
              borderRadius: BorderRadius.only(
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
                SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '담당기사 :',
                    '${logistics[_selectedLogisticIndex!]['driverName']} / ${logistics[_selectedLogisticIndex!]['driverContact']}',
                    120),
                SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '물류비 :',
                    '${logistics[_selectedLogisticIndex!]['totalAmount']}원',
                    120),
                if (widget.isSub) ...[
                  SizedBox(height: 12),
                  Divider(),
                  SizedBox(height: 12),
                  tabTextBox(
                      '정산 :',
                      '${logistics[_selectedLogisticIndex!]['settlement']['settleCompanyName']}  →  ${logistics[_selectedLogisticIndex!]['settlement']['settleTargetName']}',
                      120),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 정산일 :',
                      '${logistics[_selectedLogisticIndex!]['settlement']['settleDate'] ?? '-'}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      '세금계산서 :',
                      '${logistics[_selectedLogisticIndex!]['taxInvoice']['taxIssueCompanyName']} → ${logistics[_selectedLogisticIndex!]['taxInvoice']['taxIssueTargetName']}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 발행일 :',
                      '${logistics[_selectedLogisticIndex!]['taxInvoice']['taxIssueDate'] ?? '-'}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 승인번호 :',
                      '${logistics[_selectedLogisticIndex!]['taxInvoice']['taxApprovalNum'] == '' ? '-' : logistics[_selectedLogisticIndex!]['taxInvoice']['taxApprovalNum']}',
                      150),
                ]
              ],
            ),
          ),
      ],
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    List<dynamic> others = widget.orderInfo[widget.listName];

    return Column(
      children: [
        Row(
          children: [
            if (others == null || others.isEmpty)
              Expanded(
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
                          borderRadius: BorderRadius.only(
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
                onPressed: () {},
                child: Text(
                  '편집',
                  style: TextStyle(
                    color: Color(0xFF5D75BF),
                    fontSize: 14,
                  ),
                ),
              ),
            widget.isAdd
                ? OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFD6D6D6)),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
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
              borderRadius: BorderRadius.only(
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
                SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '유형 :', '${others[_selectedOtherIndex!]['type']}', 120),
                SizedBox(
                  height: 12,
                ),
                tabTextBox('총 금액 :',
                    '${others[_selectedOtherIndex!]['totalAmount']}원', 120),
                SizedBox(
                  height: 12,
                ),
                tabTextBox(
                    '내용 :', '${others[_selectedOtherIndex!]['contents']}', 120),
                if (widget.isSub) ...[
                  SizedBox(height: 12),
                  Divider(),
                  SizedBox(height: 12),
                  tabTextBox(
                      '정산 :',
                      '${others[_selectedOtherIndex!]['settlement']['settleCompanyName']}  →  ${others[_selectedOtherIndex!]['settlement']['settleTargetName']}',
                      120),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 정산일 :',
                      '${others[_selectedOtherIndex!]['settlement']['settleDate'] ?? '-'}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      '세금계산서 :',
                      '${others[_selectedOtherIndex!]['taxInvoice']['taxIssueCompanyName']} → ${others[_selectedOtherIndex!]['taxInvoice']['taxIssueTargetName']}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 발행일 :',
                      '${others[_selectedOtherIndex!]['taxInvoice']['taxIssueDate'] ?? '-'}',
                      150),
                  SizedBox(height: 12.0),
                  tabTextBox(
                      ' - 승인번호 :',
                      '${others[_selectedOtherIndex!]['taxInvoice']['taxApprovalNum'] == '' ? '-' : others[_selectedOtherIndex!]['taxInvoice']['taxApprovalNum']}',
                      150),
                ]
              ],
            ),
          ),
      ],
    );
  }
}
