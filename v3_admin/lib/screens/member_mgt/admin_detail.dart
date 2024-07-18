import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

class AdminDetail extends StatefulWidget {
  const AdminDetail({super.key});

  @override
  State<AdminDetail> createState() => _AdminDetailState();
}

class _AdminDetailState extends State<AdminDetail> {
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
                          context.go('/admin');
                        },
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AdminDetailView(),
                    ],
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

class AdminDetailView extends StatefulWidget {
  const AdminDetailView({super.key});

  @override
  State<AdminDetailView> createState() => _AdminDetailViewState();
}

class _AdminDetailViewState extends State<AdminDetailView> {
  bool isEditing = false;
  late Map<String, TextEditingController> controllers;

  final Map<String, dynamic> staffInfo = {
    "name": "박재성",
    "contact": "0100000000",
    "email": "jspark@bgood.co.kr",
    "status": "재직",
    "join_date": "2021-02-22",
    "permission": "일반관리자",
    "div": "연구소",
  };

  final Map<String, dynamic> staffInfo_kr = {
    "name": "이름",
    "contact": "연락처",
    "email": "메일",
  };

  final Map<String, dynamic> companyInfo_kr = {
    "status": "재직여부",
    "join_date": "입사일",
    "div": "부서",
  };

  String? _selectedStatus = "재직";
  final TextEditingController dateController = TextEditingController();
  final List<String> divisions = ["경영기획본부", "마케팅본부", "기업부설연구소"];
  String? selectedDivision = "경영기획본부";
  late DateTime selectedDate;

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

  @override
  void initState() {
    super.initState();
    controllers = {
      for (var entry in staffInfo.entries)
        entry.key: TextEditingController(text: entry.value),
    };
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(30.0),
          color: Color(0xFFF9FCFE),
          child: Column(
            children: [
              // 디테일 페이지 상단 영역
              Row(
                children: [
                  Text(
                    '${staffInfo["name"]} 상세정보',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: isEditing ? '저장' : '수정',
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomElevatedButton2(
                    text: '목록',
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF9A9A9A),
                    borderColor: Color(0xFFD6D6D6),
                    onPressed: () {
                      context.go('/admin');
                    },
                  ),
                ],
              ),

              // 디테일 페이지 내용 영역
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: commonBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              // 직원 정보
                              TableBar(titleText: '직원 정보'),
                              Container(
                                width: double.infinity,
                                height: 300,
                                child: Table(
                                  border: const TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: const {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: staffInfo.entries
                                      .where((entry) =>
                                          staffInfo_kr.containsKey(entry.key))
                                      .map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            staffInfo_kr[entry.key]!,
                                            style: const TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: isEditing
                                              ? Container(
                                                  width: 350,
                                                  height: 45,
                                                  child: TextFormField(
                                                    controller:
                                                        controllers[entry.key],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    decoration: InputDecoration(
                                                      hintText: entry.value,
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFD1D1D1),
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFD1D1D1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  entry.value,
                                                  style: const TextStyle(
                                                    color: Color(0xFF323232),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // 재직 정보
                              TableBar(titleText: '재직 정보'),
                              Container(
                                width: double.infinity,
                                height: 180,
                                child: Table(
                                  border: const TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: const {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            height: 45,
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              '재직여부',
                                              style: TextStyle(
                                                color: Color(0xFF323232),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        isEditing
                                            ? buildEditableStatusRow()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Container(
                                                  height: 45,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    staffInfo['status'],
                                                    style: const TextStyle(
                                                      color: Color(0xFF323232),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            height: 45,
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              '부서',
                                              style: TextStyle(
                                                color: Color(0xFF323232),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        isEditing
                                            ? buildEditableDivisionRow()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Container(
                                                  height: 45,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    staffInfo['div'],
                                                    style: const TextStyle(
                                                      color: Color(0xFF323232),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            height: 45,
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              '입사일',
                                              style: TextStyle(
                                                color: Color(0xFF323232),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        isEditing
                                            ? buildEditableJoinDateRow()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Container(
                                                  height: 45,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    staffInfo['join_date'],
                                                    style: const TextStyle(
                                                      color: Color(0xFF323232),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
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
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding buildEditableStatusRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: RadioListTile<String>(
              title: Text('재직'),
              value: '재직',
              groupValue: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              activeColor: Color(0xFF5D75BF),
            ),
          ),
          Expanded(
            child: RadioListTile<String>(
              title: Text('휴직'),
              value: '휴직',
              groupValue: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              activeColor: Color(0xFF5D75BF),
            ),
          ),
          Expanded(
            child: RadioListTile<String>(
              title: Text('퇴사'),
              value: '퇴사',
              groupValue: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              activeColor: Color(0xFF5D75BF),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildEditableDivisionRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: SelectBoxExample(
        initialValue: '경영기획본부',
        options: const ['경영기획본부', '마케팅본부', '기업부설연구소'],
        onChanged: (String? newValue) {
          setState(() {});
        },
        custom_width: 220.0,
      ),
    );
  }

  Padding buildEditableJoinDateRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: CustomDatePickerField(
        controller: dateController,
        onDateTap: _selectDate,
      ),
    );
  }
}
