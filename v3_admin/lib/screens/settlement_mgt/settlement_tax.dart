import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

class TaxBill extends StatefulWidget {
  const TaxBill({super.key});

  @override
  State<TaxBill> createState() => _TaxBillState();
}

class _TaxBillState extends State<TaxBill> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 3; // GNB : 정산관리
  int selectedMenu = 2; // SUB : 정산관리 > 세금계산서

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
                        label: '정산관리',
                        selectedMenu: selectedMenu,
                        onTap: (index) {
                          setState(() {
                            selectedMenu = index;
                          });
                          if (index == 1) {
                            context.go('/settlement');
                          } else if (index == 2) {
                            context.go('/taxbill');
                          } else if (index == 3) {
                            context.go('/settle-forward');
                          } else if (index == 4) {
                            context.go('/settle-market');
                          }
                        },
                        items: [
                          SubMenuItem(
                            label: '정산',
                            index: 1,
                          ),
                          SubMenuItem(
                            label: '세금계산서',
                            index: 2,
                          ),
                          SubMenuItem(
                            label: '선도주문',
                            index: 3,
                          ),
                          SubMenuItem(
                            label: '비굿마켓',
                            index: 4,
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
                        TaxBillList(),
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

class TaxBillList extends StatefulWidget {
  const TaxBillList({super.key});

  @override
  State<TaxBillList> createState() => _TaxBillListState();
}

class _TaxBillListState extends State<TaxBillList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late List<Map<String, dynamic>> _filteredData;
  late TextEditingController StartDateController;
  late TextEditingController EndDateController;
  late TextEditingController SearchController;
  late List<bool> isSelected;
  bool _allChecked = false; // 체크박스 전체 선택

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

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
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

  final List<Map<String, dynamic>> _data = [
    {
      '발행일자': null,
      '거래명': '[선도]산울림(우리동네 씨없는수박이 최고)',
      '구분': '공급처',
      '업체명': '넉넉한사람들',
      '금액': '2500000',
      '승인번호': '',
      '상태': '발행예정',
    },
    {
      '발행일자': null,
      '거래명': '[선도]산울림(우리동네 씨없는수박이 최고)',
      '구분': '공급처',
      '업체명': '넉넉한사람들',
      '금액': '12500000',
      '승인번호': '',
      '상태': '발행예정',
    },
    {
      '발행일자': '2024-04-24',
      '거래명': '[선도]토마토(우리동네 씨없는수박이 최고)',
      '구분': '물류',
      '업체명': '지엘물류',
      '금액': '200000',
      '승인번호': '20240422-10240422-24855829',
      '상태': '발행완료',
    },
    {
      '발행일자': null,
      '거래명': '[선도]수박(우리동네 씨없는수박이 최고)',
      '구분': '공급처',
      '업체명': '자연진리',
      '금액': '2800000',
      '승인번호': '',
      '상태': '발행예정',
    },
    {
      '발행일자': '2024-04-20',
      '거래명': '[선도]포도(우리동네 씨없는수박이 최고)',
      '구분': '수요처',
      '업체명': '한결농산',
      '금액': '3400000',
      '승인번호': '20240422-10240422-24855829',
      '상태': '발행완료',
    },
    {
      '발행일자': null,
      '거래명': '[선도]천혜향(우리동네 씨없는수박이 최고)',
      '구분': '공급처',
      '업체명': '넉넉한사람들',
      '금액': '112500000',
      '승인번호': '',
      '상태': '발행예정',
    },
    
  ];
  final List<Map<String, dynamic>> _data2 = [
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
      StartDateController.text = DateFormat('yyyy-MM-dd').format(startDate);
      EndDateController.text = DateFormat('yyyy-MM-dd').format(endDate);
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
              mainTitle: '세금계산서',
              breadcrumb1: ' > 정산관리 > ',
              breadcrumb2: '세금계산서'),

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
                            '• 기간',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        CustomDatePickerField(
                          controller: StartDateController,
                          onDateTap: _selectDate,
                        ),
                        Text(
                          '  -  ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        CustomDatePickerField(
                          controller: EndDateController,
                          onDateTap: _selectDate,
                        ),
                        SizedBox(
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
                    SizedBox(
                      height: 10,
                    ),
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
                            '카드결제',
                            '무통장입금',
                          ],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                        SizedBox(width: 220),
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
                          options: [
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
                text: '승인번호 저장',
                onPressed: () {},
              ),
              SizedBox(width: 10,),
              CustomElevatedButton1(
                backgroundColor: Color(0xFF5D75BF),
                text: '일괄변경',
                onPressed: () {},
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
                                '발행일자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '거래명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '구분',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '업체명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '금액',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '승인번호',
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
                              DataCell(Text(item['발행일자'] == null ? '' : item['발행일자'])),
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    // context.go('/order-detail');
                                  },
                                  child: Text(
                                    item['거래명']!.length > 12
                                        ? item['거래명']!.substring(0, 12) +
                                            '... >'
                                        : item['거래명']! + ' >',
                                    style: TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(item['구분']!)),
                              DataCell(Text(item['업체명']!)),
                              DataCell(Text(item['금액']!)),
                              DataCell(Text(item['승인번호']!)),
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
