import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

class SettlementPage extends StatefulWidget {
  const SettlementPage({super.key});

  @override
  State<SettlementPage> createState() => _SettlementPageState();
}

class _SettlementPageState extends State<SettlementPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 3; // GNB : 정산관리
  int selectedMenu = 1; // SUB : 정산관리 > 정산

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
                        SettlementList(),
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

class SettlementList extends StatefulWidget {
  const SettlementList({super.key});

  @override
  State<SettlementList> createState() => _SettlementListState();
}

class _SettlementListState extends State<SettlementList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late TextEditingController SearchController;
  late List<Map<String, dynamic>> _filteredData;

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  final List<int> years =
      List.generate(10, (index) => DateTime.now().year - index);
  final List<int> months = List.generate(12, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
    SearchController = TextEditingController();
  }

  final List<Map<String, dynamic>> _data = [
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
    },
    {
      '거래명': '[맞춤]산울림(우리동네 자회사어쩌고 저쩌고)',
      '거래유형': '선도거래',
      '업체명': '넉넉한 사람들',
      '구분': '공급처',
      '금액': '2500000',
      '정산일자': '2024-05-23',
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
              mainTitle: '정산', breadcrumb1: ' > 정산관리 > ', breadcrumb2: '정산'),

          // 검색 영역
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                DropdownButton<int>(
                                  value: selectedYear,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      selectedYear = newValue!;
                                    });
                                  },
                                  dropdownColor: Colors.white, 
                                  items: years.map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(
                                        '$value년',
                                        style: TextStyle(
                                          fontSize: value == selectedYear
                                              ? 20
                                              : 14,
                                          fontWeight: value == selectedYear
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          decoration: TextDecoration.none, 
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(width: 16), 
                                DropdownButton<int>(
                                  value: selectedMonth,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      selectedMonth = newValue!;
                                    });
                                  },
                                  dropdownColor: Colors.white, 
                                  items: months.map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(
                                        '$value월',
                                        style: TextStyle(
                                          fontSize: value == selectedMonth
                                              ? 20
                                              : 14, 
                                          fontWeight: value == selectedMonth
                                              ? FontWeight.bold
                                              : FontWeight.normal, 
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
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
                SizedBox(width: 15,),
                Expanded(
                  flex: 2,
                  child: Container(
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
                              SizedBox(width: 15,),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  '매출합계',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                color: Color(0xFFFFF3F2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  '매입합계',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                color: Color(0xFFFFF3F2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  '기타비용 합계',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                color: Color(0xFFFFF3F2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  '매출이익',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 45,
                                color: Color(0xFFFFF3F2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                text: '등록',
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
                                '거래명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '거래유형',
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
                                '구분',
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
                                '정산일자',
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
                              DataCell(Text(item['거래유형']!)),
                              DataCell(Text(item['업체명']!)),
                              DataCell(Text(item['구분']!)),
                              DataCell(Text(item['금액']!)),
                              DataCell(Text(item['정산일자']!)),
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
