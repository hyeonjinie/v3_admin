/* 
- 운영관리 > 선도거래 > 문의/계약
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

class OperationPage extends StatefulWidget {
  const OperationPage({super.key});

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
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
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InquiryList(),
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

class InquiryList extends StatefulWidget {
  const InquiryList({super.key});

  @override
  State<InquiryList> createState() => _InquiryListState();
}

class _InquiryListState extends State<InquiryList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late List<Map<String, String>> _filteredData;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController searchController;
  late List<bool> isSelected;   // 검색영역 - 날짜 선택 토글 
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    searchController = TextEditingController();
    selectedDate = DateTime.now();
    isSelected = [false, false, false, false, true];    // '전체'선택으로 디폴트 
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

  final List<Map<String, String>> _data = [
    {
      '거래명': '[맞춤]산울림(우리동네 자회사)+한결농산, 사과(가공용 부사) 2,500kg',
      '품목': '딸기',
      '품종': '설향',
      '등급': '특',
      '업체명': '넉넉한 사람들',
      '공급물량': '12520kg',
      '공급기간': '2024-04-24 \n~ 2024-10-10',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]한빛유통+자연농장, 배(신고배) 5,000kg',
      '품목': '배',
      '품종': '신고',
      '등급': '상',
      '업체명': '햇살 좋은 과일',
      '공급물량': '5000kg',
      '공급기간': '2024-03-15 \n~ 2024-08-30',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]청춘농장+드림푸드, 토마토(대추형) 3,000kg',
      '품목': '토마토',
      '품종': '대추형',
      '등급': '특',
      '업체명': '신선한 과일',
      '공급물량': '3000kg',
      '공급기간': '2024-05-01 \n~ 2024-09-20',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]맑은농원+푸른하늘, 감귤(하우스 감귤) 10,000kg',
      '품목': '감귤',
      '품종': '하우스',
      '등급': '상',
      '업체명': '자연의 맛',
      '공급물량': '10000kg',
      '공급기간': '2024-02-01 \n~ 2024-07-15',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]에코팜+행복한 농장, 블루베리(수입) 2,000kg',
      '품목': '블루베리',
      '품종': '수입',
      '등급': '특',
      '업체명': '자연의 선물',
      '공급물량': '2000kg',
      '공급기간': '2024-06-10 \n~ 2024-11-25',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]상생농원+유기농장, 수박(무가당) 6,000kg',
      '품목': '수박',
      '품종': '무가당',
      '등급': '상',
      '업체명': '달콤한 과일',
      '공급물량': '6000kg',
      '공급기간': '2024-05-20 \n~ 2024-09-10',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]자연유통+푸른과수원, 복숭아(천도 복숭아) 4,500kg',
      '품목': '복숭아',
      '품종': '천도',
      '등급': '특',
      '업체명': '싱싱한 과일',
      '공급물량': '4500kg',
      '공급기간': '2024-06-05 \n~ 2024-09-25',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]햇빛농장+그린파머스, 포도(샤인머스캣) 7,000kg',
      '품목': '포도',
      '품종': '샤인머스캣',
      '등급': '상',
      '업체명': '싱그러운 과일',
      '공급물량': '7000kg',
      '공급기간': '2024-08-01 \n~ 2024-12-15',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]맑은샘+청정과일, 자두(오미자 자두) 3,500kg',
      '품목': '자두',
      '품종': '오미자',
      '등급': '특',
      '업체명': '자연의 신선함',
      '공급물량': '3500kg',
      '공급기간': '2024-07-10 \n~ 2024-11-30',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]푸른들판+선한농부, 바나나(필리핀산) 5,200kg',
      '품목': '바나나',
      '품종': '필리핀산',
      '등급': '상',
      '업체명': '신선한 과일',
      '공급물량': '5200kg',
      '공급기간': '2024-03-01 \n~ 2024-08-15',
      '희망배송일': '2024-04-24',
    },
    {
      '거래명': '[맞춤]참좋은농장+자연의 맛, 체리(수입) 4,000kg',
      '품목': '체리',
      '품종': '수입',
      '등급': '특',
      '업체명': '프레시베리',
      '공급물량': '4000kg',
      '공급기간': '2024-05-15 \n~ 2024-10-20',
      '희망배송일': '2024-04-24',
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
              mainTitle: '문의/계약',
              breadcrumb1: ' > 운영관리 > 선도거래 > ',
              breadcrumb2: '문의/계약'),

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
                        textBox('• 날짜'),
                        SelectBoxExample(
                          initialValue: '선택',
                          options: const [
                            '선택',
                            '문의등록일',
                            '희망배송일',
                          ],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                        const SizedBox(
                          width: 10,
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
                        textBox('• 검색'),
                        SelectBoxExample(
                          initialValue: '전체',
                          options: ['전체', '업체명', '담당자명', '담당자 연락처', '담당자 메일'],
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
              const SizedBox(
                width: 20,
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
                          columns: const [
                            DataColumn(
                              label: Text(
                                '거래명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '품목',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '품종',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '등급',
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
                                '공급물량',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '공급기간',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '희망배송일',
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
                                    context.go('/inquiry-detail');
                                  },
                                  child: Text(
                                    item['거래명']!.length > 12
                                        ? item['거래명']!.substring(0, 12) +
                                            '... >'
                                        : item['거래명']! + '>',
                                    style: const TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(item['품목']!)),
                              DataCell(Text(item['품종']!)),
                              DataCell(Text(item['등급']!)),
                              DataCell(Text(item['업체명']!)),
                              DataCell(Text(item['공급물량']!)),
                              DataCell(Text(item['공급기간']!)),
                              DataCell(Text(item['희망배송일']!)),
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
