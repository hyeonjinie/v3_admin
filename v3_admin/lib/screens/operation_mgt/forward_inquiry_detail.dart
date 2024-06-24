import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:v3_admin/screens/client_mgt/supplier_detail.dart';

class InquiryDetail extends StatefulWidget {
  const InquiryDetail({super.key});

  @override
  State<InquiryDetail> createState() => _InquiryDetailState();
}

class _InquiryDetailState extends State<InquiryDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 2; // GNB : 운영관리
  int selectedMenu = 1; // SUB : 선도거래 > 문의/계약

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

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int _selectedSupplierIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    // 문의내용 
    final Map<String, String> inquiryInfo = {
      '품목': '사과',
      '품종': '부사',
      '등급': '상',
      '원산지': '경상북도',
      '단가': '1,500원',
      '공급물량': '12,520kg',
      '거래횟수': '',
      '공급기간': '2024-04-24 ~ 2024-10-10',
      '희망배송일': '2024-04-24',
      '총 금액': '18,780,000원',
      '담당자 연락처': '010-1234-1234',
      '통장사본':
          'https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae'
    };

    // 기업정보 
    final Map<String, String> memberInfo = {
      '업체명': '비굿컴퍼니',
      '사업자등록번호': '1234567890',
      '업태/종목': '도매/농업',
      '담당자명': '김현진',
      '담당자 연락처': '010-1234-1234',
      '이메일': 'abc@bgood.co.kr',
      '사업장 주소': '서울특별시 서초구 매헌로8길 39, D동 4층 406호(양재동, 희경재단) 테스트테스트테스트테스트',
    };

    // 공급처
    final List<Map<String, String>> _data = [
      {
        '업체명': '한결농산 / 1234556890',
        '원물가격': '1,600원',
        '공급수량': '6,000kg',
        '총 금액': '9,600,000원',
      },
      {
        '업체명': '냠냠농산 / 1234556890',
        '원물가격': '1,800원',
        '공급수량': '2,000kg',
        '총 금액': '3,600,000원',
      },
      {
        '업체명': '꿀꿀농산 / 1234556890',
        '원물가격': '1,800원',
        '공급수량': '2,000kg',
        '총 금액': '3,600,000원',
      },
    ];

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
                  Text(
                    '{선도거래 타이틀(거래명)}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: '수정',
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10,
                  ),
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
                              // 담당자 지정
                              Container(
                                width: double.infinity,
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
                              SizedBox(
                                height: 20,
                              ),

                              // 문의내용
                              TableBar(titleText: '문의내용'),
                              Container(
                                width: double.infinity,
                                height: 500,
                                child: Table(
                                  border: TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: inquiryInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: entry.key == '통장사본'
                                              ? (entry.value == null
                                                  ? Text('')
                                                  : Row(
                                                      children: [
                                                        Image.network(
                                                          entry.value,
                                                          height: 100,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ],
                                                    ))
                                              : Text(
                                                  entry.value,
                                                  style: TextStyle(
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
                        SizedBox(
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
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomElevatedButton1(
                                    backgroundColor: Color(0xFF5D75BF),
                                    text: '저장',
                                    onPressed: () {},
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              // 기업 정보
                              TableBar(titleText: '기업 정보'),
                              Container(
                                width: double.infinity,
                                height: 350,
                                child: Table(
                                  border: TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: memberInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: TextStyle(
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
                                            style: TextStyle(
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
                              Container(
                                child: Expanded(
                                child: CustomToggleColumn(
                                  data: _data,
                                  selectedIndex: _selectedSupplierIndex,
                                  onSelected: (index) {
                                    setState(() {
                                      _selectedSupplierIndex = index;
                                    });
                                  },
                                  tabTitlePrefix: '공급처',
                                  btnText: '공급처 추가',
                                  content: [
                                    tabTextBox(
                                        '업체명 :',
                                        '${_data[_selectedSupplierIndex]['업체명']} / ${_data[_selectedSupplierIndex]['사업자번호']}',
                                        120),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        '원물가격 :',
                                        '${_data[_selectedSupplierIndex]['원물가격']}',
                                        120),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        '공급수량 :',
                                        '${_data[_selectedSupplierIndex]['공급수량']}',
                                        120),
                                    SizedBox(height: 16.0),
                                    tabTextBox(
                                        '총 금액 :',
                                        '${_data[_selectedSupplierIndex]['총 금액']}',
                                        120),
                                  ],
                                ),
                              ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // 메모
                              TableBar(titleText: '메모'),
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFD6D6D6),
                                  ),
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
