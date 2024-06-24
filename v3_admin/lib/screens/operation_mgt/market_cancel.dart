import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

class MarketCancel extends StatefulWidget {
  const MarketCancel({super.key});

  @override
  State<MarketCancel> createState() => _MarketCancelState();
}

class _MarketCancelState extends State<MarketCancel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 2; // GNB : 운영관리
  int selectedMenu = 5; // SUB : 비굿마켓 > 반품/취소

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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CancleList(),
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

class CancleList extends StatefulWidget {
  const CancleList({super.key});

  @override
  State<CancleList> createState() => _CancleListState();
}

class _CancleListState extends State<CancleList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late List<Map<String, String>> _filteredData;
  late TextEditingController StartDateController;
  late TextEditingController EndDateController;
  late TextEditingController SearchController;
  late List<bool> isSelected;

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
    StartDateController = TextEditingController();
    EndDateController = TextEditingController();
    SearchController = TextEditingController();
    selectedDate = DateTime.now();
    isSelected = [false, false, false, false, true];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        StartDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  final List<Map<String, String>> _data = [
    {
      '주문번호': '24042800042',
      '상품명': '설향딸기 4kg',
      '주문일': '2024-04-28',
      '주문금액': '17,350원',
      '결제수단': '무통장입금',
      '처리일': '2024-05-01',
      '처리상태': '취소',
      '담당자': '이태형',
    },
    {
      '주문번호': '24021600253',
      '상품명': '동결건조 오징어 1kg',
      '주문일': '2024-02-16',
      '주문금액': '42,550원',
      '결제수단': '카드결제',
      '처리일': '2024-04-20',
      '처리상태': '반품',
      '담당자': '이준형',
    },
    {
      '주문번호': '24010100034',
      '상품명': '유기농 사과 10kg',
      '주문일': '2024-01-01',
      '주문금액': '30,000원',
      '결제수단': '카드결제',
      '처리일': '2024-01-05',
      '처리상태': '반품',
      '담당자': '황용희',
    },
    {
      '주문번호': '24031200089',
      '상품명': '유기농 당근 5kg',
      '주문일': '2024-03-12',
      '주문금액': '15,000원',
      '결제수단': '카드결제',
      '처리일': '2024-03-15',
      '처리상태': '완료',
      '담당자': '이태형',
    },
    {
      '주문번호': '24041700123',
      '상품명': '유기농 배추 3kg',
      '주문일': '2024-04-17',
      '주문금액': '12,000원',
      '결제수단': '무통장입금',
      '처리일': '2024-04-20',
      '처리상태': '취소',
      '담당자': '이태형',
    },
    {
      '주문번호': '24052300056',
      '상품명': '유기농 오이 2kg',
      '주문일': '2024-05-23',
      '주문금액': '8,500원',
      '결제수단': '카드결제',
      '처리일': '2024-05-25',
      '처리상태': '취소',
      '담당자': '이준형',
    },
    {
      '주문번호': '24061400078',
      '상품명': '유기농 감자 5kg',
      '주문일': '2024-06-14',
      '주문금액': '11,000원',
      '결제수단': '무통장입금',
      '처리일': '2024-06-16',
      '처리상태': '반품',
      '담당자': '황용희',
    },
    {
      '주문번호': '24070100092',
      '상품명': '유기농 양배추 4kg',
      '주문일': '2024-07-01',
      '주문금액': '9,500원',
      '결제수단': '무통장입금',
      '처리일': '2024-07-03',
      '처리상태': '취소',
      '담당자': '황용희',
    },
    {
      '주문번호': '24081900145',
      '상품명': '유기농 호박 3kg',
      '주문일': '2024-08-19',
      '주문금액': '10,000원',
      '결제수단': '카드결제',
      '처리일': '2024-08-21',
      '처리상태': '취소',
      '담당자': '이준형',
    },
    {
      '주문번호': '24091500234',
      '상품명': '유기농 고구마 6kg',
      '주문일': '2024-09-15',
      '주문금액': '13,000원',
      '결제수단': '무통장입금',
      '처리일': '2024-09-17',
      '처리상태': '반품',
      '담당자': '이준형',
    },
    {
      '주문번호': '24101000367',
      '상품명': '유기농 딸기 3kg',
      '주문일': '2024-10-10',
      '주문금액': '18,500원',
      '결제수단': '무통장입금',
      '처리일': '2024-10-12',
      '처리상태': '반품',
      '담당자': '김희원',
    },
    {
      '주문번호': '24112100489',
      '상품명': '유기농 블루베리 2kg',
      '주문일': '2024-11-21',
      '주문금액': '25,000원',
      '결제수단': '카드결제',
      '처리일': '2024-11-23',
      '처리상태': '반품',
      '담당자': '김희원',
    },
    {
      '주문번호': '24123000512',
      '상품명': '유기농 무 5kg',
      '주문일': '2024-12-30',
      '주문금액': '14,000원',
      '결제수단': '무통장입금',
      '처리일': '2025-01-02',
      '처리상태': '반품',
      '담당자': '박준형',
    },
    {
      '주문번호': '24010700678',
      '상품명': '유기농 토마토 4kg',
      '주문일': '2024-01-07',
      '주문금액': '20,000원',
      '결제수단': '무통장입금',
      '처리일': '2024-01-10',
      '처리상태': '취소',
      '담당자': '이태형',
    },
    {
      '주문번호': '24021200745',
      '상품명': '유기농 양파 3kg',
      '주문일': '2024-02-12',
      '주문금액': '7,000원',
      '결제수단': '카드결제',
      '처리일': '2024-02-15',
      '처리상태': '반품',
      '담당자': '황용희',
    },
    {
      '주문번호': '24031500812',
      '상품명': '유기농 시금치 2kg',
      '주문일': '2024-03-15',
      '주문금액': '5,500원',
      '결제수단': '무통장입금',
      '처리일': '2024-03-18',
      '처리상태': '취소',
      '담당자': '김민정',
    },
    {
      '주문번호': '24042000934',
      '상품명': '유기농 브로콜리 3kg',
      '주문일': '2024-04-20',
      '주문금액': '16,000원',
      '결제수단': '무통장입금',
      '처리일': '2024-04-23',
      '처리상태': '취소',
      '담당자': '박성준',
    },
    {
      '주문번호': '24052300123',
      '상품명': '유기농 가지 5kg',
      '주문일': '2024-05-23',
      '주문금액': '13,500원',
      '결제수단': '카드결제',
      '처리일': '2024-05-26',
      '처리상태': '취소',
      '담당자': '이승현',
    },
    {
      '주문번호': '24062800234',
      '상품명': '유기농 콩나물 1kg',
      '주문일': '2024-06-28',
      '주문금액': '4,500원',
      '결제수단': '무통장입금',
      '처리일': '2024-06-30',
      '처리상태': '반품',
      '담당자': '정재훈',
    },
    {
      '주문번호': '24073100345',
      '상품명': '유기농 고추 2kg',
      '주문일': '2024-07-31',
      '주문금액': '12,000원',
      '결제수단': '무통장입금',
      '처리일': '2024-08-02',
      '처리상태': '취소',
      '담당자': '홍성민',
    },
    {
      '주문번호': '24081500456',
      '상품명': '유기농 마늘 3kg',
      '주문일': '2024-08-15',
      '주문금액': '18,000원',
      '결제수단': '카드결제',
      '처리일': '2024-08-18',
      '처리상태': '반품',
      '담당자': '임지수',
    },
    {
      '주문번호': '24092100567',
      '상품명': '유기농 상추 2kg',
      '주문일': '2024-09-21',
      '주문금액': '6,000원',
      '결제수단': '계좌이체',
      '처리일': '2024-09-24',
      '처리상태': '취소',
      '담당자': '김진호',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int firstRowIndex = _pageIndex * _rowsPerPage;
    final int lastRowIndex = (_pageIndex + 1) * _rowsPerPage;

    return Container(
      padding: EdgeInsets.all(30.0),
      color: Color(0xFFF9FCFE),
      child: Column(
        children: [
          // 상단 타이틀 영역
          TitleSection(
              mainTitle: '반품/취소',
              breadcrumb1: ' > 운영관리 > 비굿마켓 > ',
              breadcrumb2: '반품/취소'),

          // 검색 영역
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: double.infinity,
              height: 225,
              decoration: commonBoxDecoration,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 30,
                  right: 30,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            '• 상태',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SelectBoxExample(
                          initialValue: '전체',
                          options: [
                            '전체',
                            '주문요청',
                            '배송예정',
                            '배송완료',
                          ],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            '• 검색',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SelectBoxExample(
                          initialValue: '전체',
                          options: ['전체', '업체명', '담당자명', '담당자 연락처', '담당자 메일'],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 350,
                          height: 45,
                          child: TextFormField(
                            controller: SearchController,
                            decoration: InputDecoration(
                              hintText: '검색어를 입력하세요',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD1D1D1),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD1D1D1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton1(
                          backgroundColor: Color(0xFF5D75BF),
                          text: '검색',
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomElevatedButton2(
                          text: '초기화',
                          backgroundColor: Colors.white,
                          textColor: Color(0xFF9A9A9A),
                          borderColor: Color(0xFFD6D6D6),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),

          // 표 상단 영역
          Row(
            children: [
              Text(
                ' 총 n개',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Spacer(),
              CustomElevatedButton1(
                backgroundColor: Color(0xFF5D75BF),
                text: '주문 생성',
                onPressed: () {},
              ),
              SizedBox(
                width: 10,
              ),
              SelectBoxExample(
                initialValue: '10개 보기',
                options: ['10개 보기', '20개 보기', '50개 보기'],
                onChanged: (String? newValue) {
                  setState(() {
                    _rowsPerPage = int.parse(newValue!.split('개')[0]);
                  });
                },
                custom_width: 120.0,
              ),
            ],
          ),
          SizedBox(height: 10),

          // 테이블
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            height: 650,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFD6D6D6),
                )),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                '주문번호',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '상품명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '주문일',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '주문금액',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '결제수단',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '처리상태',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '처리일',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '담당자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: _filteredData
                              .skip(firstRowIndex)
                              .take(_rowsPerPage)
                              .map((item) {
                            return DataRow(cells: [
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    // context.go('/member-detail');
                                  },
                                  child: Text(
                                    item['주문번호']! + ' >',
                                    style: TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(item['상품명']!)),
                              DataCell(Text(item['주문일']!)),
                              DataCell(Text(item['주문금액']!)),
                              DataCell(Text(item['결제수단']!)),
                              DataCell(Text(item['처리상태']!)),
                              DataCell(Text(item['처리일']!)),
                              DataCell(Text(item['담당자']!)),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),

                // 페이징
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _pageIndex > 0
                          ? () {
                              setState(() {
                                _pageIndex--;
                              });
                            }
                          : null,
                    ),
                    Text('${_pageIndex + 1}'),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: (lastRowIndex < _filteredData.length)
                          ? () {
                              setState(() {
                                _pageIndex++;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
