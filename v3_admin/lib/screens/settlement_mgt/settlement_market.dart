import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

class SettleMarket extends StatefulWidget {
  const SettleMarket({super.key});

  @override
  State<SettleMarket> createState() => _SettleMarketState();
}

class _SettleMarketState extends State<SettleMarket> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 3; // GNB : 정산관리
  int selectedMenu = 4; // SUB : 정산관리 > 비굿마켓

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
                        SettleMarketList(),
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
    "id": "6fLU2Wzd3JHqKTVJvqn2",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-19 20:00",
    "order_sales": 84000,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "7LgAP2teoubV6msrkwjz",
    "order_id": "24021600252",
    "product_name": "간장고추 1kg",
    "date": "2024-06-19 20:00",
    "order_sales": 4900,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "8Dj1Mmigt9k0NL6n1i6Z",
    "order_id": "24021600253",
    "product_name": "비굿 파프리카(노랑) 5KG",
    "date": "2024-06-24 20:00",
    "order_sales": 10725,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "8SuZFkwywCWJm0z4971g",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-13 20:00",
    "order_sales": 28000,
    "payment": "무통장입금",
    "status": "결제완료"
  },
  {
    "id": "DPQBADjBYzxsqXAQ71Vm",
    "order_id": "24021600253",
    "product_name": "비굿 파프리카(노랑) 5KG",
    "date": "2024-06-24 20:00",
    "order_sales": 10725,
    "payment": "무통장입금",
    "status": "취소"
  },
  {
    "id": "DgIhzGGBNbTcntBprzfg",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-19 20:00",
    "order_sales": 28000,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "EB1MkQRoqdGUFSej1I7J",
    "order_id": "24021600253",
    "product_name": "비굿 파프리카(노랑) 5KG",
    "date": "2024-06-20 20:00",
    "order_sales": 10725,
    "payment": "무통장입금",
    "status": "결제완료"
  },
  {
    "id": "FkJImEM5Su79WWwNNJ08",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-10 20:00",
    "order_sales": 28000,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "GDnD8fQ0ekYCc2YLNc9G",
    "order_id": "24021600253",
    "product_name": "콩조림 1kg",
    "date": "2024-06-21 20:00",
    "order_sales": 2100,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "GDp9PGfM8EbjEqwRUGEj",
    "order_id": "24021600253",
    "product_name": "간장고추 1kg",
    "date": "2024-06-24 20:00",
    "order_sales": 4900,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "GOJeu7riID0s5aTJq8Se",
    "order_id": "24021600253",
    "product_name": "감자",
    "date": "2024-05-25 20:00",
    "order_sales": 140000,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "H40qd9p6SCzpSp1Ypxl5",
    "order_id": "24021600253",
    "product_name": "감자",
    "date": "2024-05-27 20:00",
    "order_sales": 35000,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "HNEko5bysyrShUozuJmp",
    "order_id": "24021600253",
    "product_name": "성주 가정용 참외 5kg",
    "date": "2024-05-31 20:00",
    "order_sales": 113850,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "I1JsgFOmDUVdKr3elV7B",
    "order_id": "24021600253",
    "product_name": "비굿 금실 딸기 2KG",
    "date": "2024-06-30 20:00",
    "order_sales": 27000,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "IQANFAo3nGfK3U9rv7vE",
    "order_id": "24021600253",
    "product_name": "콩조림 1kg",
    "date": "2024-06-19 20:00",
    "order_sales": 2100,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "JwchutqEvhvQId8bEI6a",
    "order_id": "24021600253",
    "product_name": "성주 가정용 참외 5kg",
    "date": "2024-06-19 20:00",
    "order_sales": 37950,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "OPfEYbHBYPZKrSXWNXY8",
    "order_id": "24021600253",
    "product_name": "비굿 한우 육회용 1kg",
    "date": "2024-06-13 20:00",
    "order_sales": 28000,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "SHaluaSsCFFDBPcxCiwe",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-26 20:00",
    "order_sales": 119150,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "TWzVmQYZcqI8Z7yxr9Ha",
    "order_id": "24021600253",
    "product_name": "특 토마토(10KG)",
    "date": "2024-06-30 20:00",
    "order_sales": 18480,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "UzHio8QphWWZNDkJd9JK",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-19 20:00",
    "order_sales": 140000,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "WUwVOpuJteqZcSU3mFpM",
    "order_id": "24021600253",
    "product_name": "성주 가정용 참외 5kg",
    "date": "2024-07-01 20:00",
    "order_sales": 37950,
    "payment": "무통장입금",
    "status": "확인중"
  },
  {
    "id": "YYjYxJH5FdygIbADvTfM",
    "order_id": "24021600253",
    "product_name": "바사삭 오징어스낵 300g",
    "date": "2024-06-26 20:00",
    "order_sales": 17500,
    "payment": "무통장입금",
    "status": "결제완료"
  },
  {
    "id": "Yx1r7bS9Uftebp4i1bQ3",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-24 20:00",
    "order_sales": 28000,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "aDmkdZjkp9Rfq4UCiIcb",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-19 20:00",
    "order_sales": 28000,
    "payment": "무통장입금",
    "status": "결제완료"
  },
  {
    "id": "aO1SdSgOYeeEMklnp2Xn",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-24 20:00",
    "order_sales": 28000,
    "payment": "무통장입금",
    "status": "취소"
  },
  {
    "id": "aSfzTUL3kzdXn5pD5x8K",
    "order_id": "24021600253",
    "product_name": "성주 가정용 참외 5kg",
    "date": "2024-05-31 20:00",
    "order_sales": 113850,
    "payment": "무통장입금",
    "status": "결제완료"
  },
  {
    "id": "arBd9bp6RJDC3MFEKE6N",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-19 20:00",
    "order_sales": 28000,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "bOXfHfbfkJDIKoO1xOrq",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-19 20:00",
    "order_sales": 28000,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "c4QPsGxgvNjHMNh1jFub",
    "order_id": "24021600253",
    "product_name": "비굿 한우 등심(냉장) 1kg",
    "date": "2024-06-13 20:00",
    "order_sales": 28000,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "dbI1R4cr4WcRyRTpP4xd",
    "order_id": "24021600253",
    "product_name": "냉동 순살닭꼬치 110g x 130ea",
    "date": "2024-06-13 20:00",
    "order_sales": 134500,
    "payment": "무통장입금",
    "status": "결제완료"
  },
  {
    "id": "e4sbwef26agO3Cjl1TeG",
    "order_id": "24021600253",
    "product_name": "비굿 설향 딸기 2KG",
    "date": "2024-06-13 20:00",
    "order_sales": 22500,
    "payment": "카드결제",
    "status": "결제완료"
  },
  {
    "id": "eK7k6uqczN1FItIYFlpS",
    "order_id": "24021600253",
    "product_name": "감자",
    "date": "2024-06-13 20:00",
    "order_sales": 105000,
    "payment": "무통장입금",
    "status": "결제완료"
  },
  {
    "id": "juZgtOJPidph8vclOUJc",
    "order_id": "24021600253",
    "product_name": "비굿 한우 육회용 1kg",
    "date": "2024-06-13 20:00",
    "order_sales": 28000,
    "payment": "카드결제",
    "status": "결제완료"
  },
];

class SettleMarketList extends StatefulWidget {
  const SettleMarketList({super.key});

  @override
  State<SettleMarketList> createState() => _SettleMarketListState();
}

class _SettleMarketListState extends State<SettleMarketList> {
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
              mainTitle: '비굿마켓 정산',
              breadcrumb1: ' > 정산관리 > ',
              breadcrumb2: '비굿마켓'),

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
                            '카드결제',
                            '무통장입금',
                          ],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                        const SizedBox(width: 135),
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
                          columns: [
                            const DataColumn(
                              label: Text(
                                '주문번호',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                '상품명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                '주문일시',
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
                                    width: 35,
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
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    // context.go('/order-detail');
                                  },
                                  child: Text(
                                    item['order_id']!.length > 12
                                        ? item['order_id']!.substring(0, 12) +
                                            '... >'
                                        : item['order_id']! + ' >',
                                    style: const TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(item['product_name']!)),
                              DataCell(Text(
                                  item['date'] == null ? '' : item['date'])),
                              DataCell(Text(
                                  currencyFormat.format(item['order_sales']) +
                                      '원')),
                              DataCell(Text(item['payment']!)),
                              DataCell(Row(
                                children: [
                                  Text(
                                    item['status'],
                                    style: TextStyle(
                                        color: item['status'] == '확인중'
                                            ? Color(0xFFFF5F5F)
                                            : Color(0xFF4470F6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: item['status'] == '확인중'
                                        ? 23
                                        : item['status'] == '취소'
                                            ? 37
                                            : 10,
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('상태 변경',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
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
            const SizedBox(
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
