/*
- 운영관리 > 비굿마켓 > 주문
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

class MarketOrder extends StatefulWidget {
  const MarketOrder({super.key});

  @override
  State<MarketOrder> createState() => _MarketOrderState();
}

class _MarketOrderState extends State<MarketOrder> {
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
                        OrderList(),
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

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late List<Map<String, dynamic>> _filteredData;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController searchController;
  late List<bool> isSelected;
  bool _allChecked = false; // 체크박스 전체 선택

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    searchController = TextEditingController();
    selectedDate = DateTime.now();
    isSelected = [false, false, false, false, true];
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  //날짜 토글 옵션 
  void _setDateRange(int index) {
    DateTime now = DateTime.now();
    DateTime startDate = now;
    DateTime endDate = now;

    switch (index) {
      case 0:
        startDate = now;
        endDate = now;
        break;
      case 1:
        startDate = now.subtract(Duration(days: 7));
        endDate = now;
        break;
      case 2:
        startDate = DateTime(now.year, now.month - 1, now.day);
        endDate = now;
        break;
      case 3:
        startDate = DateTime(now.year, now.month - 3, now.day);
        endDate = now;
        break;
      case 4:
        startDate = DateTime(2000, 1, 1);
        endDate = now;
        break;
    }

    setState(() {
      startDateController.text = DateFormat('yyyy-MM-dd').format(startDate);
      endDateController.text = DateFormat('yyyy-MM-dd').format(endDate);
    });
  }

  final List<Map<String, dynamic>> _data = [
    {
      '주문번호': '24052300123',
      '상품명': '유기농 가지 5kg',
      '주문일': '2024-05-23',
      '주문금액': '13,500원',
      '결제수단': '카드결제',
      '상태': '확인중',
    },
    {
      '주문번호': '24062800234',
      '상품명': '유기농 콩나물 1kg',
      '주문일': '2024-06-28',
      '주문금액': '4,500원',
      '결제수단': '무통장입금',
      '상태': '확인중',
    },
    {
      '주문번호': '24073100345',
      '상품명': '유기농 고추 2kg',
      '주문일': '2024-07-31',
      '주문금액': '12,000원',
      '결제수단': '무통장입금',
      '상태': '확인중',
    },
    {
      '주문번호': '24081500456',
      '상품명': '유기농 마늘 3kg',
      '주문일': '2024-08-15',
      '주문금액': '18,000원',
      '결제수단': '카드결제',
      '상태': '확인중',
    },
    {
      '주문번호': '24092100567',
      '상품명': '유기농 상추 2kg',
      '주문일': '2024-09-21',
      '주문금액': '6,000원',
      '결제수단': '계좌이체',
      '상태': '완료',
    },
    {
      '주문번호': '24021600253',
      '상품명': '동결건조 오징어 1kg',
      '주문일': '2024-02-16',
      '주문금액': '42,550원',
      '결제수단': '카드결제',
      '상태': '완료',
    },
    {
      '주문번호': '24042800042',
      '상품명': '설향딸기 4kg',
      '주문일': '2024-04-28',
      '주문금액': '17,350원',
      '결제수단': '무통장입금',
      '상태': '완료',
    },
    {
      '주문번호': '24041700123',
      '상품명': '유기농 배추 3kg',
      '주문일': '2024-04-17',
      '주문금액': '12,000원',
      '결제수단': '무통장입금',
      '상태': '완료',
    },
    {
      '주문번호': '24062800234',
      '상품명': '유기농 콩나물 1kg',
      '주문일': '2024-06-28',
      '주문금액': '4,500원',
      '결제수단': '무통장입금',
      '상태': '완료',
    },
    {
      '주문번호': '24062800234',
      '상품명': '유기농 콩나물 1kg',
      '주문일': '2024-06-28',
      '주문금액': '4,500원',
      '결제수단': '무통장입금',
      '상태': '완료',
    },
    {
      '주문번호': '24062800234',
      '상품명': '유기농 콩나물 1kg',
      '주문일': '2024-06-28',
      '주문금액': '4,500원',
      '결제수단': '무통장입금',
      '상태': '완료',
    },
    {
      '주문번호': '24062800234',
      '상품명': '유기농 콩나물 1kg',
      '주문일': '2024-06-28',
      '주문금액': '4,500원',
      '결제수단': '무통장입금',
      '상태': '완료',
    },
    {
      '주문번호': '24062800234',
      '상품명': '유기농 콩나물 1kg',
      '주문일': '2024-06-28',
      '주문금액': '4,500원',
      '결제수단': '무통장입금',
      '상태': '완료',
    },
  ];

  void _updateCheckedStatus(bool? value, int index) {
    setState(() {
      _filteredData[index]['checked'] = value!;
    });
  }

  void _toggleAllCheckboxes(bool? value) {
    setState(() {
      _allChecked = value!;
      for (var item in _filteredData) {
        item['checked'] = _allChecked;
      }
    });
  }

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
              mainTitle: '주문',
              breadcrumb1: ' > 운영관리 > 비굿마켓 > ',
              breadcrumb2: '주문'),

          // 검색 영역
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: double.infinity,
              height: 280,
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
                        const SizedBox(
                          width: 120,
                          child: Text(
                            '• 주문일',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        CustomDatePickerField(
                          controller: startDateController,
                          onDateTap: _selectDate,
                        ),
                        const Text(
                          '  -  ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        CustomDatePickerField(
                          controller: endDateController,
                          onDateTap: _selectDate,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 40),
                          child: ToggleButtons(
                            isSelected: isSelected,
                            selectedColor: Colors.white,
                            fillColor: Colors.transparent,
                            borderColor: Colors.grey,
                            selectedBorderColor: Color(0xFF4470F6),
                            borderRadius: BorderRadius.circular(5),
                            children: <Widget>[
                              buildToggleButton('오늘', isSelected[0]),
                              buildToggleButton('1주일', isSelected[1]),
                              buildToggleButton('1개월', isSelected[2]),
                              buildToggleButton('3개월', isSelected[3]),
                              buildToggleButton('전체', isSelected[4]),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                for (int i = 0; i < isSelected.length; i++) {
                                  isSelected[i] = i == index;
                                }
                                _setDateRange(index);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text(
                            '• 결제수단',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SelectBoxExample(
                          initialValue: '전체',
                          options: const [
                            '전체',
                            '카드결제',
                            '무통장입금',
                          ],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                        SizedBox(width: 220),
                        const SizedBox(
                          width: 120,
                          child: Text(
                            '• 결제상태',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SelectBoxExample(
                          initialValue: '전체',
                          options: const [
                            '전체',
                            '확인중',
                            '입금완료',
                            '결제완료',
                            '배송예정',
                            '완료',
                          ],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
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
                          options: ['전체', '주문번호', '상품명'],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 350,
                          height: 45,
                          child: TextFormField(
                            controller: searchController,
                            decoration: const InputDecoration(
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
                    const SizedBox(
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
                        const SizedBox(
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
          const SizedBox(
            height: 30,
          ),

          // 표 상단 영역
          Row(
            children: [
              const Text(
                ' 총 n개',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Spacer(),
              CustomElevatedButton1(
                backgroundColor: Color(0xFF5D75BF),
                text: '일괄 변경',
                onPressed: () {},
              ),
              const SizedBox(
                width: 10,
              ),
              SelectBoxExample(
                initialValue: '10개 보기',
                options: const ['10개 보기', '20개 보기', '50개 보기'],
                onChanged: (String? newValue) {
                  setState(() {
                    _rowsPerPage = int.parse(newValue!.split('개')[0]);
                  });
                },
                custom_width: 120.0,
              ),
            ],
          ),
          const SizedBox(height: 10),

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
                          columns: const [
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
                                '상태',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: _filteredData
                              .skip(firstRowIndex)
                              .take(_rowsPerPage)
                              .map((item) {
                            int itemIndex = _filteredData.indexOf(item);
                            return DataRow(cells: [
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    context.go('/order-detail');
                                  },
                                  child: Text(
                                    item['주문번호']!.length > 12
                                        ? item['주문번호']!.substring(0, 12) +
                                            '... >'
                                        : item['주문번호']! + ' >',
                                    style: const TextStyle(
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
                              DataCell(Text(item['상태']!)),
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
