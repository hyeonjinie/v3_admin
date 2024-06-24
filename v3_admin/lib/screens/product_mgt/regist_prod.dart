import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

class ProdPage extends StatefulWidget {
  const ProdPage({super.key});

  @override
  State<ProdPage> createState() => _ProdPageState();
}

class _ProdPageState extends State<ProdPage> {
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
                        ProdRegist(),
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

class ProdRegist extends StatefulWidget {
  const ProdRegist({super.key});

  @override
  State<ProdRegist> createState() => _ProdRegistState();
}

class _ProdRegistState extends State<ProdRegist> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;
  late List<Map<String, dynamic>> _filteredData;
  late TextEditingController SearchController;
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    _filteredData = _data;
    SearchController = TextEditingController();
  }

  final List<Map<String, String>> _data = [
    {
      '거래명': '[맞춤]산울림(우리동네 자회사)+한결농산, 사과(가공용 부사) 2,500kg',
      '품목': '딸기',
      '품종': '설향',
      '등급': '특',
      '업체명': '넉넉한 사람들',
      '주문회차': '3회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '주문요청',
    },
    {
      '거래명': '[맞춤]한빛유통+자연농장, 배(신고배) 5,000kg',
      '품목': '배',
      '품종': '신고',
      '등급': '상',
      '업체명': '햇살 좋은 과일',
      '주문회차': '2회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '주문요청',
    },
    {
      '거래명': '[맞춤]청춘농장+드림푸드, 토마토(대추형) 3,000kg',
      '품목': '토마토',
      '품종': '대추형',
      '등급': '특',
      '업체명': '신선한 과일',
      '주문회차': '1회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '주문요청',
    },
    {
      '거래명': '[맞춤]맑은농원+푸른하늘, 감귤(하우스 감귤) 10,000kg',
      '품목': '감귤',
      '품종': '하우스',
      '등급': '상',
      '업체명': '자연의 맛',
      '주문회차': '4회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '배송완료',
    },
    {
      '거래명': '[맞춤]에코팜+행복한 농장, 블루베리(수입) 2,000kg',
      '품목': '블루베리',
      '품종': '수입',
      '등급': '특',
      '업체명': '자연의 선물',
      '주문회차': '3회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '주문요청',
    },
    {
      '거래명': '[맞춤]상생농원+유기농장, 수박(무가당) 6,000kg',
      '품목': '수박',
      '품종': '무가당',
      '등급': '상',
      '업체명': '달콤한 과일',
      '주문회차': '3회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '배송예정',
    },
    {
      '거래명': '[맞춤]자연유통+푸른과수원, 복숭아(천도 복숭아) 4,500kg',
      '품목': '복숭아',
      '품종': '천도',
      '등급': '특',
      '업체명': '싱싱한 과일',
      '주문회차': '3회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '배송예정',
    },
    {
      '거래명': '[맞춤]햇빛농장+그린파머스, 포도(샤인머스캣) 7,000kg',
      '품목': '포도',
      '품종': '샤인머스캣',
      '등급': '상',
      '업체명': '싱그러운 과일',
      '주문회차': '3회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '주문요청',
    },
    {
      '거래명': '[맞춤]맑은샘+청정과일, 자두(오미자 자두) 3,500kg',
      '품목': '자두',
      '품종': '오미자',
      '등급': '특',
      '업체명': '자연의 신선함',
      '주문회차': '3회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '배송완료',
    },
    {
      '거래명': '[맞춤]푸른들판+선한농부, 바나나(필리핀산) 5,200kg',
      '품목': '바나나',
      '품종': '필리핀산',
      '등급': '상',
      '업체명': '신선한 과일',
      '주문회차': '3회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '주문요청',
    },
    {
      '거래명': '[맞춤]참좋은농장+자연의 맛, 체리(수입) 4,000kg',
      '품목': '체리',
      '품종': '수입',
      '등급': '특',
      '업체명': '프레시베리',
      '주문회차': '3회',
      '누적/총 공급물량': '10,320kg / 12,520kg',
      '상태': '배송예정',
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
              mainTitle: '상품 등록',
              breadcrumb1: ' > 상품관리 > ',
              breadcrumb2: '상품 등록'),

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
                        Container(
                          width: 320,
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
                        SizedBox(width: 120),
                        SizedBox(
                          width: 120,
                          child: Text(
                            '• 판매상태',
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
                            '카드결제',
                            '무통장입금',
                          ],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            '• 카테고리',
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
                            '카드결제',
                            '무통장입금',
                          ],
                          onChanged: (String? newValue) {
                            setState(() {});
                          },
                          custom_width: 220.0,
                        ),
                        SizedBox(width: 220),
                        SizedBox(
                          width: 120,
                          child: Text(
                            '• 노출여부',
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
                text: '상품 등록',
                onPressed: () {},
              ),
              SizedBox(
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
                                '품목',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '품종',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '등급',
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
                                '주문회차',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '누적/총 공급물량',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '상태',
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
                                    context.go('/product-detail');
                                  },
                                  child: Text(
                                    item['거래명']!.length > 12
                                        ? item['거래명']!.substring(0, 12) +
                                            '... >'
                                        : item['거래명']! + '>',
                                    style: TextStyle(
                                      color: Color(0xFF4470F6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(item['품목']!)),
                              DataCell(Text(item['품종']!)),
                              DataCell(Text(item['등급']!)),
                              DataCell(Text(item['업체명']!)),
                              DataCell(Text(item['주문회차']!)),
                              DataCell(Text(item['누적/총 공급물량']!)),
                              DataCell(Text(item['상태']!)),
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
