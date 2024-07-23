/*
- 정산관리 > 선도주문
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

class SettleForward extends StatefulWidget {
  const SettleForward({super.key});

  @override
  State<SettleForward> createState() => _SettleForwardState();
}

class _SettleForwardState extends State<SettleForward> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 3; // GNB : 정산관리
  int selectedMenu = 3; // SUB : 정산관리 > 선도주문

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
                        SettleForwardList(),
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

final List<Map<String, dynamic>> _data = [
  {
    "id": "HrLfZNVVmZ9gsXxgBgH0",
    "settleDate": null,
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "suborders",
    "companyName": "나만보면바나나",
    "amount": 3000,
    "status": "예정"
  },
  {
    "id": "UvdAHsTXNc3BmU6fdqG7",
    "settleDate": "2024-06-24 12:50",
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "suborders",
    "companyName": "딸기회사",
    "amount": 15040000,
    "status": "완료"
  },
  {
    "id": "iIDnzl7JkeSiic1DFz1U",
    "settleDate": "2024-06-24 12:50",
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "logistics",
    "companyName": "토닥토닥토마토",
    "amount": 378420,
    "status": "완료"
  },
  {
    "id": "iIDnzl7JkeSiic1DFz1U",
    "settleDate": null,
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "otherexpenses",
    "companyName": "비굿",
    "amount": 0,
    "status": "예정"
  },
  {
    "id": "iIDnzl7JkeSiic1DFz1U",
    "settleDate": null,
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "suppliers",
    "companyName": "에스앤이컴퍼니",
    "amount": 16000,
    "status": "예정"
  },
  {
    "id": "iIDnzl7JkeSiic1DFz1U",
    "settleDate": null,
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "suborders",
    "companyName": "싱싱쥬스",
    "amount": 18800000,
    "status": "예정"
  },
  {
    "id": "kSg8NoujmzEZcnSPFnxy",
    "settleDate": null,
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "logistics",
    "companyName": "지엘물류",
    "amount": 275000,
    "status": "예정"
  },
  {
    "id": "kSg8NoujmzEZcnSPFnxy",
    "settleDate": null,
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "otherexpenses",
    "companyName": "비굿",
    "amount": -4600,
    "status": "예정"
  },
  {
    "id": "kSg8NoujmzEZcnSPFnxy",
    "settleDate": null,
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "suppliers",
    "companyName": "채소회사",
    "amount": 2000,
    "status": "예정"
  },
  {
    "id": "kSg8NoujmzEZcnSPFnxy",
    "settleDate": "2024-06-24 12:50",
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "suppliers",
    "companyName": "고기회사",
    "amount": 400,
    "status": "완료"
  },
  {
    "id": "kSg8NoujmzEZcnSPFnxy",
    "settleDate": "2024-06-24 12:50",
    "title": "[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)",
    "type": "suborders",
    "companyName": "나만보면바나나",
    "amount": 5000,
    "status": "완료"
  }
];

class SettleForwardList extends StatefulWidget {
  const SettleForwardList({super.key});

  @override
  State<SettleForwardList> createState() => _SettleForwardListState();
}

class _SettleForwardListState extends State<SettleForwardList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  // late List<Map<String, dynamic>> _filteredData;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController searchController;
  late List<bool> isSelected;
  bool _allChecked = false;
  late List<bool> _checked;

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    // _filteredData = _data;
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    searchController = TextEditingController();
    selectedDate = DateTime.now();
    isSelected = [false, false, false, false, true];
    _checked = List.generate(_data.length, (index) => false);
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

  void _updateCheckedStatus(bool? value, int index) {
    setState(() {
      _checked[index] = value!;
    });
  }

  void _toggleAllCheckboxes(bool? value) {
    setState(() {
      _allChecked = value!;
      for (int i = 0; i < _checked.length; i++) {
        _checked[i] = _allChecked;
      }
    });
  }

  String getTypeDisplayName(String type) {
    switch (type) {
      case 'suppliers':
        return '공급처';
      case 'suborders':
        return '수요처';
      case 'logistics':
        return '물류';
      case 'otherexpenses':
        return '기타';
      default:
        return type;
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
              mainTitle: '선도거래 정산',
              breadcrumb1: ' > 정산관리 > ',
              breadcrumb2: '선도거래'),

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
                        const SizedBox(
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
                          options: const [
                            '전체',
                            '예정',
                            '완료',
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
                          options: const [
                            '전체',
                            '거래명',
                            '업체명',
                          ],
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
              Text(
                ' 총 ${_data.length}개',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Spacer(),
              CustomElevatedButton1(
                backgroundColor: Color(0xFF5D75BF),
                text: '일괄변경',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _changeStatus(context);
                    },
                  );
                },
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
                            const DataColumn(
                              label: Text(
                                '정산일자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                '거래명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                '구분',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                '업체명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                '금액',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  const Text(
                                    '상태',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Checkbox(
                                    value: _allChecked,
                                    onChanged: _toggleAllCheckboxes,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    side: const BorderSide(
                                        color: Color(0xFF5D75BF), width: 1.2),
                                    activeColor: Color(0xFF5D75BF),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          rows: _data
                              .skip(firstRowIndex)
                              .take(_rowsPerPage)
                              .map((item) {
                            int itemIndex = _data.indexOf(item);
                            return DataRow(cells: [
                              DataCell(Text(item['settleDate'] == null
                                  ? ''
                                  : item['settleDate'])),
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    // context.go('/order-detail');
                                  },
                                  child: Text(
                                    item['title']!.length > 12
                                        ? item['title']!.substring(0, 12) +
                                            '... >'
                                        : item['title']! + ' >',
                                    style: const TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(getTypeDisplayName(item['type']))),
                              DataCell(Text(item['companyName']!)),
                              DataCell(Text(
                                  currencyFormat.format(item['amount']) + '원')),
                              DataCell(Row(
                                children: [
                                  Text(
                                    item['status'],
                                    style: TextStyle(
                                        color: item['status'] == '예정'
                                            ? Color(0xFFFF5F5F)
                                            : Color(0xFF4470F6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Checkbox(
                                    value: _checked[itemIndex],
                                    onChanged: (bool? value) {
                                      _updateCheckedStatus(value, itemIndex);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    side: const BorderSide(
                                        color: Color(0xFF5D75BF), width: 1.2),
                                    activeColor: Color(0xFF5D75BF),
                                  ),
                                ],
                              )),
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
                      onPressed: (lastRowIndex < _data.length)
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

// 상태변경 팝업창
  Widget _changeStatus(BuildContext context) {
    String dropdownValue = '예정';
    return Dialog(
      child: Container(
        width: 350,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('상태 변경',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SelectBoxExample(
              initialValue: '예정',
              options: const [
                '예정',
                '완료',
                '취소',
              ],
              onChanged: (String? newValue) {
                setState(() {});
              },
              custom_width: 220.0,
            ),
            SizedBox(
              height: 20,
            ),
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
                SizedBox(width: 10),
                CustomElevatedButton1(
                  backgroundColor: Color(0xFF5D75BF),
                  text: '등록',
                  onPressed: () {
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
