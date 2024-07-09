import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 2; // GNB : 운영관리
  int selectedMenu = 4; // SUB : 비굿마켓 > 주문

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
                          } else {
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
                        isExpanded: false,
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
                        isExpanded: true,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OrderDetailView(),
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

final Map<String, dynamic> marketInfo = {
  "orderInfo": {
    "mainCategory": "농산물",
    "subCategory": "기타",
    "productName": "제품명수정수정",
    "supplierName": "과일회사",
    "quantity": 1,
    "orderDate": "2024-06-19T10:47:53.523000+00:00",
    "orderer": "에스앤이컴퍼니",
    "contact": "",
    "address": "서울 서초구 매헌로8길 39 다동"
  },
  "paymentInfo": {
    "goodsPrice": 28000,
    "deliveryCost": "보류",
    "totalCost": 28000,
    "payment": "결제방식",
    "status": "취소"
  }
};

// 주문정보 
    final Map<String, String> orderInfo = {
      '카테고리': '전체상품 > 가공식품 > 식혜',
      '상품명': '달보드레 전통 음료',
      '공급사': '맛있는 식품',
      '수량': '10',
      '주문일자': '2024-05-19',
      '주문자': '박재성',
      '연락처': '010-0000-0000',
      '배송지': '서울특별시 서초구 매헌로8길 39, D동 4층 406호(양재동, 희경재단) 테스트테스트테스트테스트',
    };

    // 결제정보 
    final Map<String, String> paymentInfo = {
      '상품금액': '1,800원',
      '배송비': '무료',
      '총 결제금액': '18,000원',
      '결제방식': '무통장입금',
      '상태': '결제완료(2024-05-20)',
    };

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
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
                    '{주문명}',
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
                      context.go('/operation');
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
                              SizedBox(height: 65,),
                              // 주문 정보
                              TableBar(titleText: '주문 정보'),
                              Container(
                                width: double.infinity,
                                height: 500,
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
                                  children: orderInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: const TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                                  entry.value,
                                                  style: const TextStyle(
                                                    color: Color(0xFF323232),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // 상태 변경
                              Row(
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
                                    initialValue: '확인중',
                                    options: const [
                                      '확인중',
                                      '결제완료',
                                      '취소',
                                    ],
                                    onChanged: (String? newValue) {
                                      setState(() {});
                                    },
                                    custom_width: 220.0,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CustomElevatedButton1(
                                    backgroundColor: Color(0xFF5D75BF),
                                    text: '저장',
                                    onPressed: () {},
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              // 결제 정보
                              TableBar(titleText: '결제 정보'),
                              Container(
                                width: double.infinity,
                                height: 350,
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
                                  children: paymentInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: const TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.value,
                                            style: const TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
