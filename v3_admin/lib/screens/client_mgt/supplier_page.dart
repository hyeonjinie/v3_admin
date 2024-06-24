import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:v3_admin/main.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/screens/main_screen.dart';

class ClientManagement extends StatefulWidget {
  const ClientManagement({super.key});

  @override
  State<ClientManagement> createState() => _ClientManagementState();
}

class _ClientManagementState extends State<ClientManagement> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 5; // GNB : 거래처관리
  int selectedMenu = 1; // SUB : 공급사 관리

  void _updateIndex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

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
                      SingleMenuWidget(
                        label: '공급사 관리',
                        selectedMenu: selectedMenu,
                        index: 1,
                        onTap: () {
                          setState(() {
                            selectedMenu = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SupplierMgt(),
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

class SupplierMgt extends StatefulWidget {
  const SupplierMgt({super.key});

  @override
  State<SupplierMgt> createState() => _SupplierMgtState();
}

class _SupplierMgtState extends State<SupplierMgt> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late List<Map<String, String>> _filteredData;
  late TextEditingController SearchController;

  @override
  void initState() {
    super.initState();
    SearchController = TextEditingController();
    _filteredData = _data;
  }

  final List<Map<String, String>> _data = [
    {
      '공급사명': 'ABC Company',
      '사업자유형': '주식회사',
      '등록상품 수': '10',
      '업태': '소매업',
      '종목': '의류',
      '담당자': '홍길동',
      '담당자 연락처': '010-1234-5678',
    },
    {
      '공급사명': 'XYZ Inc.',
      '사업자유형': '주식회사',
      '등록상품 수': '15',
      '업태': '도매업',
      '종목': '가전제품',
      '담당자': '이순신',
      '담당자 연락처': '010-5678-1234',
    },
    {
      '공급사명': 'ABC Company',
      '사업자유형': '주식회사',
      '등록상품 수': '10',
      '업태': '소매업',
      '종목': '의류',
      '담당자': '홍길동',
      '담당자 연락처': '010-1234-5678',
    },
    {
      '공급사명': 'XYZ Inc.',
      '사업자유형': '주식회사',
      '등록상품 수': '15',
      '업태': '도매업',
      '종목': '가전제품',
      '담당자': '이순신',
      '담당자 연락처': '010-5678-1234',
    },
    {
      '공급사명': 'ABC Company',
      '사업자유형': '주식회사',
      '등록상품 수': '10',
      '업태': '소매업',
      '종목': '의류',
      '담당자': '홍길동',
      '담당자 연락처': '010-1234-5678',
    },
    {
      '공급사명': 'XYZ Inc.',
      '사업자유형': '주식회사',
      '등록상품 수': '15',
      '업태': '도매업',
      '종목': '가전제품',
      '담당자': '이순신',
      '담당자 연락처': '010-5678-1234',
    },
    {
      '공급사명': 'ABC Company',
      '사업자유형': '주식회사',
      '등록상품 수': '10',
      '업태': '소매업',
      '종목': '의류',
      '담당자': '홍길동',
      '담당자 연락처': '010-1234-5678',
    },
    {
      '공급사명': 'XYZ Inc.',
      '사업자유형': '주식회사',
      '등록상품 수': '15',
      '업태': '도매업',
      '종목': '가전제품',
      '담당자': '이순신',
      '담당자 연락처': '010-5678-1234',
    },
    {
      '공급사명': 'ABC Company',
      '사업자유형': '주식회사',
      '등록상품 수': '10',
      '업태': '소매업',
      '종목': '의류',
      '담당자': '홍길동',
      '담당자 연락처': '010-1234-5678',
    },
    {
      '공급사명': 'XYZ Inc.',
      '사업자유형': '주식회사',
      '등록상품 수': '15',
      '업태': '도매업',
      '종목': '가전제품',
      '담당자': '이순신',
      '담당자 연락처': '010-5678-1234',
    },
    {
      '공급사명': 'ABC Company',
      '사업자유형': '주식회사',
      '등록상품 수': '10',
      '업태': '소매업',
      '종목': '의류',
      '담당자': '홍길동',
      '담당자 연락처': '010-1234-5678',
    },
    {
      '공급사명': 'XYZ Inc.',
      '사업자유형': '주식회사',
      '등록상품 수': '15',
      '업태': '도매업',
      '종목': '가전제품',
      '담당자': '이순신',
      '담당자 연락처': '010-5678-1234',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int firstRowIndex = _pageIndex * _rowsPerPage;
    final int lastRowIndex = (_pageIndex + 1) * _rowsPerPage;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(30.0),
          color: Color(0xFFF9FCFE),
          child: Column(
            children: [
              // 상단 타이틀 영역
              TitleSection(
                  mainTitle: '공급사 관리',
                  breadcrumb1: ' > 거래처 관리 > ',
                  breadcrumb2: '공급사 관리'),

              // 검색 영역
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 110,
                  decoration: commonBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      left: 30,
                      right: 30,
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            textBox('• 검색'),
                            Container(
                              width: 350,
                              height: 45,
                              child: TextFormField(
                                controller: SearchController,
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
                            SizedBox(width: 15),
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
                    text: '등록',
                    onPressed: () {
                      context.go('/regist-supplier');
                    },
                  ),
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
                                    '공급사명',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '사업자유형',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '등록상품 수',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '업태',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '종목',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '담당자',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '담당자 연락처',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                        context.go('/supplier');
                                      },
                                      child: Text(
                                        item['공급사명']! + ' >',
                                        style: const TextStyle(
                                          color: Color(0xFF4470F6),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(item['사업자유형']!)),
                                  DataCell(Text(item['등록상품 수']!)),
                                  DataCell(Text(item['업태']!)),
                                  DataCell(Text(item['종목']!)),
                                  DataCell(Text(item['담당자']!)),
                                  DataCell(Text(item['담당자 연락처']!)),
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
        ),
      ],
    );
  }
}
