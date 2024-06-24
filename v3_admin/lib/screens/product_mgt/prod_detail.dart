import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

class ProdDetail extends StatefulWidget {
  const ProdDetail({super.key});

  @override
  State<ProdDetail> createState() => _ProdDetailState();
}

class _ProdDetailState extends State<ProdDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 4; // GNB : 상품관리
  int selectedMenu = 1; // SUB : 상품등록

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
                        label: '상품등록',
                        selectedMenu: selectedMenu,
                        index: 1,
                        onTap: () {
                          setState(() {
                            selectedMenu = 1;
                          });
                          context.go('/product');
                        },
                      ),
                      SingleMenuWidget(
                        label: '카테고리',
                        selectedMenu: selectedMenu,
                        index: 2,
                        onTap: () {
                          setState(() {
                            selectedMenu = 2;
                          });
                          context.go('/category');
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
                        ProdDetailView(),
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

class ProdDetailView extends StatefulWidget {
  const ProdDetailView({super.key});

  @override
  State<ProdDetailView> createState() => _ProdDetailViewState();
}

class _ProdDetailViewState extends State<ProdDetailView> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> prodInfo = {
      '상품정보': '비굿 금실 딸기 4KG',
      '상품안내': '크기는 3-4cm정도 되며, 푸른빛이 돌 수 있습니다.',
      '상품이미지\n(대표사진)':
          'https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae'
    };

    final Map<String, String> requiredInfo = {
      '무게': '4kg',
      '재고': '100',
      '원물가격': '50,000원',
      '도매가격': '48,000원',
      '비굿가격': '48,000원',
      '할인율': '4%',
      '수수료': '2,000원',
    };

    final Map<String, dynamic> saleInfo = {
      '노출여부': true,
      '판매상태': '재고확보중',
    };

    final List<Map<String, dynamic>> lawInfo = [
      {
        'info_number': "(19)식품(농수축산물)",
        'product_info_law': [
          {
            "제품명": "냉동 순살닭꼬치 110g x 130ea",
            "식품의 유형": "양념육(비살균제품)",
            "생산자 및 소재지, 수입품의 경우 생산자, 수입자 및 제조국 함께 표기": "주식회사 비에스푸드테크",
            "제조연월일, 유통기한 또는 품질유지기한": "제품 별도 표기",
            "포장단위별 내용물의 용량(중량), 수량": "제품 별도 표기",
            "원재료명 및 함량": "닭정육99.95%(브라질산) , 정제소금0.05%(국내산)",
            "영양성분(식품 등의 표시·광고에 관한 법률에 따른 영양성분 표시대상 식품에 한함)": "제품 별도 표기",
            "유전자변형식품에 해당하는 경우의 표시": "해당없음",
            "수입식품에 해당하는 경우 '수입식품안전관리특별법에 따른 수입신고를 필함'의 문구": "해당없음",
            "소비자안전을 위한 주의사항": "-18도 이하 냉동보관",
            "소비자상담관련 전화번호": "02-553-7709",
          },
        ],
        'detail':
            'https://storage.googleapis.com/v3mvp-b9aa4.appspot.com/uploads/register/products/0ryuiGwDxEgRZWUdwFDf/detail_image'
      }
    ];

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
                    '{상품명}',
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
                    onPressed: () {
                      context.go('/operation');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1500,
                  decoration: commonBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFD0D0D0)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 15),
                                      child: Text('농산물 > 딸기'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // 상품정보
                                  TableBar(titleText: '상품 정보'),
                                  Container(
                                    width: double.infinity,
                                    height: 210,
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
                                      children: prodInfo.entries.map((entry) {
                                        return TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: entry.key ==
                                                      '상품이미지\n(대표사진)'
                                                  ? (entry.value == null
                                                      ? Text('')
                                                      : Row(
                                                          children: [
                                                            Image.network(
                                                              entry.value,
                                                              height: 100,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ],
                                                        ))
                                                  : Text(
                                                      entry.value,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF323232),
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
                                  TableBar(titleText: '판매 정보'),
                                  Container(
                                    width: double.infinity,
                                    height: 95,
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
                                      children: [
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '노출 여부',
                                                  style: TextStyle(
                                                    color: Color(0xFF323232),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Row(
                                                children: [
                                                  buildRadioButton('노출', true),
                                                  buildRadioButton(
                                                      '미노출', false),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '판매 상태',
                                                  style: TextStyle(
                                                    color: Color(0xFF323232),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Row(
                                                children: [
                                                  buildRadioButton('정상',
                                                      saleInfo['판매상태'] == '정상'),
                                                  buildRadioButton('품절',
                                                      saleInfo['판매상태'] == '품절'),
                                                  buildRadioButton(
                                                      '재고확보중',
                                                      saleInfo['판매상태'] ==
                                                          '재고확보중'),
                                                  buildRadioButton(
                                                      '판매중지',
                                                      saleInfo['판매상태'] ==
                                                          '판매중지'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TableBar(titleText: '공급사 정보'),
                                  Container(
                                    width: double.infinity,
                                    height: 70,
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
                                      children: [
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '공급사',
                                                  style: TextStyle(
                                                    color: Color(0xFF323232),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: GestureDetector(
                                                onTap: () {
                                                  //
                                                },
                                                child: Text(
                                                  '농업회사법인 주식회사 케이베리' + ' >',
                                                  style: TextStyle(
                                                    color: Color(0xFF4470F6),
                                                    fontWeight: FontWeight.bold,
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
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // 배송
                                  TableBar(titleText: '배송'),
                                  Container(
                                    width: double.infinity,
                                    height: 175,
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
                                      children: [
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '배송비',
                                                  style: TextStyle(
                                                    color: Color(0xFF323232),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Column(
                                                children: [
                                                  buildRadioButton('무료', true),
                                                  buildRadioButton(
                                                      '유료 3,500원', false),
                                                  buildRadioButton(
                                                      '조건부 무료', false),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '반품 배송비',
                                                  style: TextStyle(
                                                    color: Color(0xFF323232),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
                                              child: Text('5,000원'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 필수 옵션
                                  TableBar(titleText: '필수 옵션'),
                                  Container(
                                    width: double.infinity,
                                    height: 340,
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
                                      children:
                                          requiredInfo.entries.map((entry) {
                                        return TableRow(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 20),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        TableBar(titleText: '상품정보 제공고시'),
                        Container(
                          width: double.infinity,
                          height: 340,
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
                              0: FractionColumnWidth(0.15),
                              1: FractionColumnWidth(0.85),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '품목',
                                        style: TextStyle(
                                          color: Color(0xFF323232),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20),
                                    child: Text(lawInfo[0]['info_number']),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '상세정보',
                                        style: TextStyle(
                                          color: Color(0xFF323232),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20),
                                    child: Container(
                                      height: 250.0,
                                      child: SingleChildScrollView(
                                        child: Table(
                                          border: TableBorder.all(
                                              color: Color(0xFFD6D6D6)),
                                          children: [
                                            TableRow(
                                              children: [
                                                Container(
                                                  color: Color(0xFFF9FCFE),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 15.0),
                                                  child: Text(
                                                    '항목',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  color: Color(0xFFF9FCFE),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 15.0),
                                                  child: Text(
                                                    '정보',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ...lawInfo[0]['product_info_law'][0]
                                                .entries
                                                .map((entry) {
                                              return TableRow(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 15.0),
                                                    child: Text(entry.key),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 15.0),
                                                    child: Text(entry.value),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TableBar(titleText: '상품 상세 설명'),
                        Container(
                          width: double.infinity,
                          height: 370,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Color(0xFFD1D1D1), width: 1.0),
                            ),
                          ),
                          child: ListView(
                            children: lawInfo.map((item) {
                              if (item.containsKey('detail')) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        item['detail'],
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }).toList(),
                          ),
                        )
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
