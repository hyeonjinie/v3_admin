/*
- 회원관리 > 운영자
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 1; // GNB : 회원관리
  int selectedMenu = 2; // SUB : 운영자 

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
                          context.go('/member');
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
                        AdminList(),
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

class AdminList extends StatefulWidget {
  const AdminList({super.key});

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late List<Map<String, String>> _filteredData;
  late TextEditingController searchController;
  late List<bool> isSelected;

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
    searchController = TextEditingController();
    selectedDate = DateTime.now();
    isSelected = [true, false, false, false];
  }


  final List<Map<String, String>> _data = [
    {
      '이름': '강현구',
      '부서': '기업부설연구소',
      '재직여부': '재직',
      '등록 / 수정자': '김희원',
      '등록 / 수정일': '2024-04-20',
    },
    {
      '이름': '박재성',
      '부서': '기업부설연구소',
      '재직여부': '재직',
      '등록 / 수정자': '김희원',
      '등록 / 수정일': '2024-04-20',
    },
    {
      '이름': '심재윤',
      '부서': '기업부설연구소',
      '재직여부': '휴직',
      '등록 / 수정자': '김희원 / 김희원',
      '등록 / 수정일': '2024-04-20 / 2024-05-20',
    },
    {
      '이름': '김현진',
      '부서': '기업부설연구소',
      '재직여부': '퇴사',
      '등록 / 수정자': '김희원 / 김희원',
      '등록 / 수정일': '2024-04-20 / 2024-05-22',
    },
    {
      '이름': '장세훈',
      '부서': '경영기획본부',
      '재직여부': '재직',
      '등록 / 수정자': '박재성',
      '등록 / 수정일': '2024-04-20',
    },
    {
      '이름': '장은석',
      '부서': '마케팅본부',
      '재직여부': '재직',
      '등록 / 수정자': '박재성',
      '등록 / 수정일': '2024-04-20',
    },
    {
      '이름': '김희원',
      '부서': '경영기획본부',
      '재직여부': '재직',
      '등록 / 수정자': '박재성',
      '등록 / 수정일': '2024-04-20',
    },
    {
      '이름': '박한솔',
      '부서': '경영기획본부',
      '재직여부': '재직',
      '등록 / 수정자': '김희원',
      '등록 / 수정일': '2024-04-20',
    },
    {
      '이름': '이태형',
      '부서': '기업부설연구소',
      '재직여부': '휴직',
      '등록 / 수정자': '김희원 / 박재성',
      '등록 / 수정일': '2024-04-20 / 2024-06-01',
    },
    {
      '이름': '이준형',
      '부서': '기업부설연구소',
      '재직여부': '퇴사',
      '등록 / 수정자': '김희원 / 박재성',
      '등록 / 수정일': '2024-04-20 / 2024-06-01',
    },
    {
      '이름': '황용희',
      '부서': '기업부설연구소',
      '재직여부': '재직',
      '등록 / 수정자': '김희원',
      '등록 / 수정일': '2024-04-20',
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
              mainTitle: '운영자',
              breadcrumb1: ' > 회원관리 > ',
              breadcrumb2: '운영자'),

          // 검색 영역
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: double.infinity,
              height: 225,
              decoration: commonBoxDecoration,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        textBox('• 상태'),
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
                              buildToggleButton('전체', isSelected[0]),
                              buildToggleButton('재직', isSelected[1]),
                              buildToggleButton('휴직', isSelected[2]),
                              buildToggleButton('퇴사', isSelected[3]),
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
                          initialValue: '이름',
                          options: ['이름', '부서'],
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
                text: '직원 등록',
                onPressed: () {
                  context.go('/admin-reg');
                },
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
                                '이름',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '부서',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '재직여부',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '등록 / 수정자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '등록 / 수정일',
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
                                    context.go('/admin-detail');
                                  },
                                  child: Text(
                                    item['이름']! + ' >',
                                    style: const TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(item['부서']!)),
                              DataCell(Text(item['재직여부']!)),
                              DataCell(Text(item['등록 / 수정자']!)),
                              DataCell(Text(item['등록 / 수정일']!)),
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
