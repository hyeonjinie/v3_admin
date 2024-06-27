import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

class SupplierDetail extends StatefulWidget {
  const SupplierDetail({super.key});

  @override
  State<SupplierDetail> createState() => _SupplierDetailState();
}

class _SupplierDetailState extends State<SupplierDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 5; // GNB - 거래처 관리
  int selectedMenu = 1; // LNB - 공급사 관리 

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
                            context.go('/client');
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DetailView(),
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

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  @override
  Widget build(BuildContext context) {
    final Map<String, String> supplierInfo = {
      '공급사명': '농블리마켓',
      '대표자명': '농블리',
      '사업자(법인)번호': '0000000000(법인)',
      '업태': '도매',
      '종목': '농업',
      '연락처': '010-1234-1234',
      '메일': 'hjkim@bgood.co.kr',
      '주소': '[우편번호] 서울특별시 서초구 매헌로8길 39, D동 4층 406호(양재동, 희경재단) 테스트테스트테스트테스트',
      '사업자 등록증 사본':
          'https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae',
    };
    final Map<String, String> accountInfo = {
      '은행': '우리은행',
      '예금주': '에스앤이컴퍼니',
      '계좌번호': '1002-000-000000',
      '통장사본':
          'https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae'
    };
    final Map<String, String> contactInfo = {
      '이름': '김현진',
      '이메일': 'hjkim@bgood.co.kr',
      '연락처': '010-1234-1234',
      '유형(부서)': '연구원'
    };

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
                    '에스앤이컴퍼니(공급사명)',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: '수정',
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomElevatedButton2(
                    text: '목록',
                    backgroundColor: Colors.white,
                    textColor: Color(0xFF9A9A9A),
                    borderColor: Color(0xFFD6D6D6),
                    onPressed: () {},
                  ),
                ],
              ),

              // 디테일 페이지 내용 영역
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 850,
                  decoration: commonBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TableBar(titleText: '공급사 정보'),
                              Container(
                                width: double.infinity,
                                height: 600,
                                child: Table(
                                  border: TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: supplierInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: entry.key == '사업자 등록증 사본'
                                              ? (entry.value == null
                                                  ? Text('')
                                                  : GestureDetector(
                                                      onTap: () {
                                                        print('click!');
                                                        showImagePopup(context,
                                                            entry.value!);
                                                      },
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Image.network(
                                                          entry.value!,
                                                          height: 100,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ))
                                              : Text(
                                                  entry.value ?? '',
                                                  style: TextStyle(
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
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TableBar(titleText: '입금 계좌 정보'),
                              Container(
                                width: double.infinity,
                                height: 250,
                                child: Table(
                                  border: TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: accountInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: entry.key == '통장사본'
                                              ? (entry.value == null
                                                  ? Text('')
                                                  : GestureDetector(
                                                      onTap: () {
                                                        showImagePopup(context,
                                                            entry.value!);
                                                      },
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Image.network(
                                                          entry.value!,
                                                          height: 100,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ))
                                              : Text(
                                                  entry.value ?? '',
                                                  style: TextStyle(
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
                              SizedBox(
                                height: 20,
                              ),
                              TableBar(titleText: '담당자 정보'),
                              Container(
                                width: double.infinity,
                                height: 172,
                                child: Table(
                                  border: TableBorder(
                                    top: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    verticalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                    horizontalInside: BorderSide(
                                        color: Color(0xFFD0D0D0), width: 1),
                                  ),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  children: contactInfo.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.key,
                                            style: TextStyle(
                                              color: Color(0xFF323232),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            entry.value,
                                            style: TextStyle(
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
                              SizedBox(
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
