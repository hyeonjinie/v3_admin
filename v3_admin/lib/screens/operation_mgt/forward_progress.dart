import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:intl/intl.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 2; // GNB : 운영관리
  int selectedMenu = 2; // SUB : 선도거래 > 진행

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
                        label: '선도거래',
                        selectedMenu: selectedMenu,
                        onTap: (index) {
                          setState(() {
                            selectedMenu = index;
                          });
                          if (index == 1) {
                            context.go('/operation');
                          } else if (index == 2) {
                            context.go('/progress');
                          } else if (index == 3) {
                            context.go('/completed');
                          }
                        },
                        items: [
                          SubMenuItem(
                            label: '문의/계약',
                            index: 1,
                          ),
                          SubMenuItem(
                            label: '진행',
                            index: 2,
                          ),
                          SubMenuItem(
                            label: '완료',
                            index: 3,
                          ),
                        ],
                        isExpanded: true,
                      ),
                      SubMenuWidget(
                        label: '비굿마켓',
                        selectedMenu: selectedMenu,
                        onTap: (index) {
                          setState(() {
                            selectedMenu = index;
                          });
                          if (index == 4) {
                            context.go('/order');
                          } else if (index == 5) {
                            context.go('/cancel');
                          }
                        },
                        items: [
                          SubMenuItem(
                            label: '주문',
                            index: 4,
                          ),
                          SubMenuItem(
                            label: '반품/취소',
                            index: 5,
                          ),
                        ],
                        isExpanded: false,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ProgressList(),
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

late List<Map<String, String>> _filteredData;
late TextEditingController StartDateController;
late TextEditingController EndDateController;
late TextEditingController SearchController;

class ProgressList extends StatefulWidget {
  const ProgressList({super.key});

  @override
  State<ProgressList> createState() => _ProgressListState();
}

class _ProgressListState extends State<ProgressList> {
  int _rowsPerPage = 10;
  int _pageIndex = 0;

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        StartDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
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
              mainTitle: '진행',
              breadcrumb1: ' > 운영관리 > 선도거래 > ',
              breadcrumb2: '진행'),

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
                        textBox('• 상태'),
                        SelectBoxExample(
                          initialValue: '전체',
                          options: const [
                            '전체',
                            '주문요청',
                            '배송예정',
                            '배송완료',
                          ],
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
                text: '주문 생성',
                onPressed: () {
                  context.go('/regist-order');
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
                                    context.go('/progress-detail');
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

// // main 주문 생성
// void _showMainOrderDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         child: Container(
//           width: 570,
//           height: 800,
//           padding: EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   '선도거래 주문서',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16),
//                 OrderForm(),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomElevatedButton2(
//                       text: '취소',
//                       backgroundColor: Colors.white,
//                       textColor: Color(0xFF9A9A9A),
//                       borderColor: Color(0xFFD6D6D6),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     CustomElevatedButton1(
//                       backgroundColor: Color(0xFF5D75BF),
//                       text: '제출',
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// // sub 주문 생성 폼
// class OrderForm extends StatefulWidget {
//   @override
//   _OrderFormState createState() => _OrderFormState();
// }

// class _OrderFormState extends State<OrderForm> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController itemContoller; // 품목
//   late TextEditingController priceController;  // 품종
//   late TextEditingController contactController;   //등급
//   late TextEditingController adressController;  //원산지
//   late TextEditingController priceController;  //단가
//   late TextEditingController quantityContoller;   //공급기간_시작일 
//   late TextEditingController priceController;     //공급기간_종료일
//   late TextEditingController contactController;   //총 공급물량 
//   late TextEditingController adressController;    //총 금액 
//   late TextEditingController deliveryDateController;  //수요처
//   late TextEditingController completionController;
//   late TextEditingController stlCoController;
//   late TextEditingController stlTargetController;
//   late TextEditingController stlDateController;
//   late TextEditingController taxCoController;
//   late TextEditingController taxTargetController;
//   late TextEditingController taxDateController;
//   late TextEditingController taxNumController;
//   late DateTime selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     quantityContoller = TextEditingController();
//     priceController = TextEditingController();
//     contactController = TextEditingController();
//     adressController = TextEditingController();
//     deliveryDateController = TextEditingController();
//     completionController = TextEditingController();
//     stlCoController = TextEditingController();
//     stlTargetController = TextEditingController();
//     stlDateController = TextEditingController();
//     taxCoController = TextEditingController();
//     taxTargetController = TextEditingController();
//     taxDateController = TextEditingController();
//     taxNumController = TextEditingController();
//     selectedDate = DateTime.now();
//   }

//   @override
//   void dispose() {
//     quantityContoller.dispose();
//     priceController.dispose();
//     contactController.dispose();
//     adressController.dispose();
//     deliveryDateController.dispose();
//     completionController.dispose();
//     stlCoController.dispose();
//     stlTargetController.dispose();
//     stlDateController.dispose();
//     taxCoController.dispose();
//     taxTargetController.dispose();
//     taxDateController.dispose();
//     taxNumController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate(
//       BuildContext context, TextEditingController controller) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null && pickedDate != DateTime.now()) {
//       setState(() {
//         controller.text = "${pickedDate.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               customTextField('거래량', '(kg) 단위로 숫자만 입력', quantityContoller),
//               SizedBox(
//                 height: 10,
//               ),
//               customTextField('금액', '(원) 단위로 숫자만 입력', priceController),
//               SizedBox(
//                 height: 10,
//               ),
//               customTextField('담당자연락처', '', contactController),
//               SizedBox(
//                 height: 10,
//               ),
//               customTextField('배송지', '', adressController),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     child: Text(
//                       '배송희망일',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 350,
//                     height: 45,
//                     child: CustomDatePickerField(
//                       controller: StartDateController,
//                       onDateTap: _selectDate,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     child: Text(
//                       '배송완료일',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 350,
//                     height: 45,
//                     child: CustomDatePickerField(
//                       controller: stlDateController,
//                       onDateTap: _selectDate,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               textToText(stlCoController, stlTargetController, '정산', 160),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     child: Text(
//                       ' - 정산일',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 180,
//                     height: 45,
//                     child: CustomDatePickerField(
//                       controller: EndDateController,
//                       onDateTap: _selectDate,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   SelectBoxExample(
//                     initialValue: '정산예정',
//                     options: ['정산예정', '정산완료'],
//                     onChanged: (String? newValue) {
//                       setState(() {});
//                     },
//                     custom_width: 160.0,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               textToText(taxCoController, taxTargetController, '세금계산서', 160),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     child: Text(
//                       ' - 발행일',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 180,
//                     height: 45,
//                     child: CustomDatePickerField(
//                       controller: taxDateController,
//                       onDateTap: _selectDate,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   SelectBoxExample(
//                     initialValue: '발행예정',
//                     options: ['발행예정', '발행완료'],
//                     onChanged: (String? newValue) {
//                       setState(() {});
//                     },
//                     custom_width: 160.0,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               customTextField('승인번호', '', taxNumController),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
