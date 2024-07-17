import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:intl/intl.dart';

class MemberManagementPage extends StatefulWidget {
  const MemberManagementPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MemberManagementPage> createState() => _MemberManagementPageState();
}

class _MemberManagementPageState extends State<MemberManagementPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 1;  // GNB : 회원관리 
  int selectedMenu = 1;  // SUB : 일반회원

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
                      SingleMenuWidget(
                        label: '일반회원',
                        selectedMenu: selectedMenu,
                        index: 1,
                        onTap: () {
                          setState(() {
                            selectedMenu = 1;
                          });
                        },
                      ),
                      SingleMenuWidget(
                        label: '운영자',
                        selectedMenu: selectedMenu,
                        index: 2,
                        onTap: () {
                          setState(() {
                            selectedMenu = 2;
                          });
                          context.go('/admin');
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
                        MemberList(),
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

class MemberList extends StatefulWidget {
  const MemberList({super.key});

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
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

  final List<Map<String, String>> _data = [
    {
      '업체명': 'ABC Company',
      '회원 유형': '농인',
      '담당자': '심재윤',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-24 11:05',
    },
    {
      '업체명': 'DEF Company',
      '회원 유형': '소상공인',
      '담당자': '박재성',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-23 11:05',
    },
    {
      '업체명': 'GHI Company',
      '회원 유형': '식품제조가공업체',
      '담당자': '강현구',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-22 11:05',
    },
    {
      '업체명': 'XYZ Company',
      '회원 유형': '기타',
      '담당자': '김현진',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-21 11:05',
    },
    {
      '업체명': 'ABC Company',
      '회원 유형': '농인',
      '담당자': '심재윤',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-24 11:05',
    },
    {
      '업체명': 'DEF Company',
      '회원 유형': '소상공인',
      '담당자': '박재성',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-23 11:05',
    },
    {
      '업체명': 'GHI Company',
      '회원 유형': '식품제조가공업체',
      '담당자': '강현구',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-22 11:05',
    },
    {
      '업체명': 'XYZ Company',
      '회원 유형': '기타',
      '담당자': '김현진',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-21 11:05',
    },
    {
      '업체명': 'ABC Company',
      '회원 유형': '농인',
      '담당자': '심재윤',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-24 11:05',
    },
    {
      '업체명': 'DEF Company',
      '회원 유형': '소상공인',
      '담당자': '박재성',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-23 11:05',
    },
    {
      '업체명': 'GHI Company',
      '회원 유형': '식품제조가공업체',
      '담당자': '강현구',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-22 11:05',
    },
    {
      '업체명': 'XYZ Company',
      '회원 유형': '기타',
      '담당자': '김현진',
      '담당자 연락처': '010-1234-1234',
      '담당자 메일': 'abc@gmail.com',
      '가입일': '2024-04-21 11:05',
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
              mainTitle: '일반회원',
              breadcrumb1: ' > 회원관리 > ',
              breadcrumb2: '일반회원'),

          // 검색 영역
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: double.infinity,
              height: 275,
              decoration: commonBoxDecoration,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        textBox('• 회원유형'),
                        SelectBoxExample(
                          initialValue: '전체',
                          options: ['전체', '농민', '소상공인', '식품제조가공업체', '기타'],
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
                        textBox('• 가입일'),
                        CustomDatePickerField(
                          controller: StartDateController,
                          onDateTap: _selectDate,
                        ),
                        const Text(
                          '  -  ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        CustomDatePickerField(
                          controller: EndDateController,
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
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                ' 총 n개',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Spacer(),
              CustomElevatedButton1(
                backgroundColor: Color(0xFF5D75BF),
                text: '회원등록',
                onPressed: () {
                  context.go('/member-reg');
                },
              ),
              const SizedBox(
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
                                '업체명',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '회원 유형',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '담당자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '담당자 연락처',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '담당자 메일',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '가입일',
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
                                    context.go('/member-detail');
                                  },
                                  child: Text(
                                    item['업체명']! + ' >',
                                    style: TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(item['회원 유형']!)),
                              DataCell(Text(item['담당자']!)),
                              DataCell(Text(item['담당자 연락처']!)),
                              DataCell(Text(item['담당자 메일']!)),
                              DataCell(Text(item['가입일']!)),
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
