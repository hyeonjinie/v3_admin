/*
- 거래처관리 > 공급사관리 > 공급사 등록 
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

class RegistSupplier extends StatefulWidget {
  const RegistSupplier({super.key});

  @override
  State<RegistSupplier> createState() => _RegistSupplierState();
}

class _RegistSupplierState extends State<RegistSupplier> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 5;
  int selectedMenu = 1;

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
                        RegistView(),
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

class RegistView extends StatefulWidget {
  const RegistView({super.key});

  @override
  State<RegistView> createState() => _RegistViewState();
}

class _RegistViewState extends State<RegistView> {
  late TextEditingController supNameController;
  late TextEditingController supRepController;
  late TextEditingController supRegiTypeController;
  late TextEditingController supRegiNumController;
  late TextEditingController supFieldController;
  late TextEditingController supItemController;
  late TextEditingController supContactController;
  late TextEditingController supEmailController;
  late TextEditingController supFaxController;
  late TextEditingController supAddrController;
  late TextEditingController supRegiImgController;
  late TextEditingController memoController;
  late TextEditingController acctBankController;
  late TextEditingController acctOwnerController;
  late TextEditingController acctNumController;
  late TextEditingController acctImgController;
  late TextEditingController mgrNameController;
  late TextEditingController mgrMailController;
  late TextEditingController mgrPhoneController;
  late TextEditingController mgrDeptController;

  @override
  void initState() {
    super.initState();
    supNameController = TextEditingController();
    supRepController = TextEditingController();
    supRegiTypeController = TextEditingController();
    supRegiNumController = TextEditingController();
    supFieldController = TextEditingController();
    supItemController = TextEditingController();
    supContactController = TextEditingController();
    supEmailController = TextEditingController();
    supFaxController = TextEditingController();
    supAddrController = TextEditingController();
    memoController = TextEditingController();
    acctBankController = TextEditingController();
    acctOwnerController = TextEditingController();
    acctNumController = TextEditingController();
    acctImgController = TextEditingController();
    mgrNameController = TextEditingController();
    mgrMailController = TextEditingController();
    mgrPhoneController = TextEditingController();
    mgrDeptController = TextEditingController();
  }

  @override
  void dispose() {
    supNameController.dispose();
    supRepController.dispose();
    supRegiTypeController.dispose();
    supRegiNumController.dispose();
    supFieldController.dispose();
    supItemController.dispose();
    supContactController.dispose();
    supEmailController.dispose();
    supFaxController.dispose();
    supAddrController.dispose();
    memoController.dispose();
    acctBankController.dispose();
    acctOwnerController.dispose();
    acctNumController.dispose();
    acctImgController.dispose();
    mgrNameController.dispose();
    mgrMailController.dispose();
    mgrPhoneController.dispose();
    mgrDeptController.dispose();
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
                  const Text(
                    '공급사 등록',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: '저장',
                    onPressed: () {
                      context.go('/admin-detail'); // 현재 직원 detail로 이동 필요
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomElevatedButton2(
                    text: '취소',
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF9A9A9A),
                    borderColor: Color(0xFFD6D6D6),
                    onPressed: () {
                      context.go('/admin-detail'); // 현재 직원 detail로 이동 필요
                    },
                  ),
                ],
              ),

              // 디테일 페이지 내용 영역
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,
                  decoration: commonBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              // 공급사 정보
                              TableBar(titleText: '공급사 정보'),
                              Container(
                                width: double.infinity,
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
                                    buildRow('공급사명',
                                        controller: supNameController),
                                    buildRow('대표자명',
                                        controller: supRepController),
                                    TableRow(children: [
                                      buildCell('사업자번호', isHeader: true),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              height: 45,
                                              child: TextFormField(
                                                controller:
                                                    supRegiNumController,
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFD1D1D1),
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFD1D1D1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SelectBoxExample(
                                              initialValue: '법인',
                                              options: const [
                                                '법인',
                                                '개인',
                                              ],
                                              onChanged: (String? newValue) {
                                                setState(() {});
                                              },
                                              custom_width: 120.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                    buildRow('업태',
                                        controller: supFieldController),
                                    buildRow('종목',
                                        controller: supFieldController),
                                    buildRow('연락처',
                                        controller: supFieldController),
                                    buildRow('메일',
                                        controller: supFieldController),
                                    buildRow('팩스',
                                        controller: supFieldController),
                                    buildRow('주소',
                                        controller: supFieldController),
                                    TableRow(children: [
                                      buildCell('사업자등록증', isHeader: true),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 20),
                                        child: Container(
                                          // width: 350,
                                          height: 45,
                                          child: Row(
                                            children: [
                                              CustomElevatedButton1(
                                                backgroundColor:
                                                    Color(0xFF5D75BF),
                                                text: '파일선택',
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])
                                  ],
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
                              // 입금계좌 정보
                              TableBar(titleText: '입금계좌 정보'),
                              Container(
                                width: double.infinity,
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
                                    buildRow('은행',
                                        controller: supNameController),
                                    buildRow('예금주',
                                        controller: supRepController),
                                    buildRow('계좌번호',
                                        controller: supRepController),
                                    TableRow(children: [
                                      buildCell('통장사본', isHeader: true),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 20),
                                        child: Container(
                                          // width: 350,
                                          height: 45,
                                          child: Row(
                                            children: [
                                              CustomElevatedButton1(
                                                backgroundColor:
                                                    Color(0xFF5D75BF),
                                                text: '파일선택',
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // 담당자 정보
                              TableBar(titleText: '담당자 정보'),
                              Container(
                                width: double.infinity,
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
                                    buildRow('이름',
                                        controller: supNameController),
                                    buildRow('이메일',
                                        controller: supRepController),
                                    buildRow('연락처',
                                        controller: supRepController),
                                    buildRow('유형(부서)',
                                        controller: supRepController),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TableBar(titleText: '메모'),
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFD6D6D6),
                                  ),
                                ),
                                child: TextField(
                                  controller: memoController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  expands:
                                      true, 
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none, 
                                    hintText: '내용을 입력하세요',
                                  ),
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
}
