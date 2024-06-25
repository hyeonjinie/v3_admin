// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:v3_admin/common_widget/common_widgets.dart';
// import 'package:v3_admin/common_widget/layout.dart';
// import 'package:v3_admin/common_widget/naviagtion_helper.dart';

// class EditInquiry extends StatefulWidget {
//   const EditInquiry({super.key});

//   @override
//   State<EditInquiry> createState() => _EditInquiryState();
// }

// class _EditInquiryState extends State<EditInquiry> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int _selectIndex = 2; // GNB : 운영관리
//   int selectedMenu = 1; // SUB : 선도거래 > 문의/계약

//   void _updateIndex(int index) {
//     setState(() {
//       _selectIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         key: _scaffoldKey,
//         selectedPageIndex: _selectIndex,
//         onItemTapped: (index) =>
//             NavigationHelper.onItemTapped(context, index, _updateIndex),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 // Left Navigation Bar (LNB)
//                 Container(
//                   width: 200.0,
//                   color: Color(0xFF292F3D),
//                   child: Column(
//                     children: [
//                       ProfileWidget(),
//                       SizedBox(height: 10),
//                       SubMenuWidget(
//                         label: '선도거래',
//                         selectedMenu: selectedMenu,
//                         onTap: (index) {
//                           setState(() {
//                             selectedMenu = index;
//                           });
//                           if (index == 1) {
//                             context.go('/operation');
//                           } else if (index == 2) {
//                             context.go('/progress');
//                           } else if (index == 3) {
//                             context.go('/completed');
//                           }
//                         },
//                         items: [
//                           SubMenuItem(
//                             label: '문의/계약',
//                             index: 1,
//                           ),
//                           SubMenuItem(
//                             label: '진행',
//                             index: 2,
//                           ),
//                           SubMenuItem(
//                             label: '완료',
//                             index: 3,
//                           ),
//                         ],
//                         isExpanded: true,
//                       ),
//                       SubMenuWidget(
//                         label: '비굿마켓',
//                         selectedMenu: selectedMenu,
//                         onTap: (index) {
//                           setState(() {
//                             selectedMenu = index;
//                           });
//                           if (index == 4) {
//                             context.go('/order');
//                           } else if (index == 5) {
//                             context.go('/cancel');
//                           }
//                         },
//                         items: [
//                           SubMenuItem(
//                             label: '주문',
//                             index: 4,
//                           ),
//                           SubMenuItem(
//                             label: '반품/취소',
//                             index: 5,
//                           ),
//                         ],
//                         isExpanded: false,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         EditInquiryDetail(),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EditInquiryDetail extends StatefulWidget {
//   const EditInquiryDetail({super.key});

//   @override
//   State<EditInquiryDetail> createState() => _EditInquiryDetailState();
// }

// class _EditInquiryDetailState extends State<EditInquiryDetail> {
//   late TextEditingController itemController; //품목
//   late TextEditingController varietyController; //품종
//   late TextEditingController gradeController; //등급
//   late TextEditingController originController; //원산지
//   late TextEditingController priceController; //단가
//   late TextEditingController volumeController; //공급물량
//   late TextEditingController orderCntController; //거래횟수
//   late TextEditingController startDateController; //공급기간_시작
//   late TextEditingController endDateController; //공급기간_종료
//   late TextEditingController deliveryDateController; //희망배송일
//   late TextEditingController amountController; //총 금액
//   late TextEditingController contactController; //담당자 연락처
//   late TextEditingController memoController; //메모

//   @override
//   void initState() {
//     super.initState();
//     itemController = TextEditingController();
//     varietyController = TextEditingController();
//     gradeController = TextEditingController();
//     originController = TextEditingController();
//     priceController = TextEditingController();
//     volumeController = TextEditingController();
//     orderCntController = TextEditingController();
//     startDateController = TextEditingController();
//     endDateController = TextEditingController();
//     deliveryDateController = TextEditingController();
//     amountController = TextEditingController();
//     contactController = TextEditingController();
//     memoController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     itemController.dispose();
//     varietyController.dispose();
//     gradeController.dispose();
//     originController.dispose();
//     priceController.dispose();
//     volumeController.dispose();
//     orderCntController.dispose();
//     startDateController.dispose();
//     endDateController.dispose();
//     deliveryDateController.dispose();
//     amountController.dispose();
//     contactController.dispose();
//     memoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 기업정보
//     final Map<String, String> memberInfo = {
//       '업체명': '비굿컴퍼니',
//       '사업자등록번호': '1234567890',
//       '업태/종목': '도매/농업',
//       '담당자명': '김현진',
//       '담당자 연락처': '010-1234-1234',
//       '이메일': 'abc@bgood.co.kr',
//       '사업장 주소': '서울특별시 서초구 매헌로8길 39, D동 4층 406호(양재동, 희경재단) 테스트테스트테스트테스트',
//     };

//     // 공급처
//     final List<Map<String, dynamic>> _data = [
//       {
//         'supplierName': '한결농산',
//         "bizRegiNum": "123456789",
//         'cost': 1600,
//         'volume': 6000,
//         'totalAmount': 9600000,
//       },
//       {
//         'supplierName': '냠냠농산',
//         "bizRegiNum": "123456789",
//         'cost': 1800,
//         'volume': 2000,
//         'totalAmount': 3600000,
//       },
//       {
//         'supplierName': '꿀꿀농산',
//         "bizRegiNum": "123456789",
//         'cost': 1800,
//         'volume': 2000,
//         'totalAmount': 3600000,
//       },
//     ];

//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(30.0),
//           color: Color(0xFFF9FCFE),
//           child: Column(
//             children: [
//               // 디테일 페이지 상단 영역
//               Row(
//                 children: [
//                   Text(
//                     '{선도거래 타이틀(거래명)}',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Spacer(),
//                   CustomElevatedButton1(
//                     backgroundColor: Color(0xFF5D75BF),
//                     text: '저장',
//                     onPressed: () {},
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   CustomElevatedButton2(
//                     text: '취소',
//                     backgroundColor: Colors.white,
//                     textColor: Color(0xFF9A9A9A),
//                     borderColor: Color(0xFFD6D6D6),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),

//               // 디테일 페이지 내용 영역
//               Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: Container(
//                   width: double.infinity,
//                   height: 1000,
//                   decoration: commonBoxDecoration,
//                   child: Padding(
//                     padding: const EdgeInsets.all(40.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             children: [
//                               // 문의내용
//                               TableBar(titleText: '문의내용'),
//                               Container(
//                                 width: double.infinity,
//                                 height: 300,
//                                 child: Table(
//                                   border: TableBorder(
//                                     top: BorderSide(
//                                         color: Color(0xFFD0D0D0), width: 1),
//                                     bottom: BorderSide(
//                                         color: Color(0xFFD0D0D0), width: 1),
//                                     verticalInside: BorderSide(
//                                         color: Color(0xFFD0D0D0), width: 1),
//                                     horizontalInside: BorderSide(
//                                         color: Color(0xFFD0D0D0), width: 1),
//                                   ),
//                                   columnWidths: {
//                                     0: FractionColumnWidth(0.3),
//                                     1: FractionColumnWidth(0.7),
//                                   },
//                                   children: [
//                                     buildRow('품목', controller: itemController),
//                                     buildRow('품종',
//                                         controller: varietyController),
//                                     TableRow(children: [
//                                       buildCell('등급', isHeader: true),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 12.0, horizontal: 20),
//                                         child: SelectBoxExample(
//                                           initialValue: '특',
//                                           options: [
//                                             '특',
//                                             '상',
//                                             '중',
//                                             '하',
//                                             '못난이',
//                                           ],
//                                           onChanged: (String? newValue) {
//                                             setState(() {});
//                                           },
//                                           custom_width: 120.0,
//                                         ),
//                                       ),
//                                     ]),
//                                     buildRow('원산지',
//                                         controller: originController),
//                                     buildRow('단가', controller: priceController),
//                                     buildRow('공급물량',
//                                         controller: volumeController),
//                                     buildRow('거래횟수',
//                                         controller: orderCntController),
//                                     buildRow('총 금액',
//                                         controller: amountController),
//                                     buildRow('담당자 연락처',
//                                         controller: contactController),
//                                     TableRow(children: [
//                                       buildCell('통장사본', isHeader: true),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 12.0, horizontal: 20),
//                                         child: Container(
//                                           // width: 350,
//                                           height: 45,
//                                           child: Row(
//                                             children: [
//                                               CustomElevatedButton1(
//                                                 backgroundColor:
//                                                     Color(0xFF5D75BF),
//                                                 text: '파일선택',
//                                                 onPressed: () {},
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ])
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               // 기업 정보
//                               TableBar(titleText: '기업 정보'),
//                               Container(
//                                 width: double.infinity,
//                                 height: 350,
//                                 child: Table(
//                                   border: TableBorder(
//                                     top: BorderSide(
//                                         color: Color(0xFFD0D0D0), width: 1),
//                                     bottom: BorderSide(
//                                         color: Color(0xFFD0D0D0), width: 1),
//                                     verticalInside: BorderSide(
//                                         color: Color(0xFFD0D0D0), width: 1),
//                                     horizontalInside: BorderSide(
//                                         color: Color(0xFFD0D0D0), width: 1),
//                                   ),
//                                   columnWidths: {
//                                     0: FractionColumnWidth(0.3),
//                                     1: FractionColumnWidth(0.7),
//                                   },
//                                   children: memberInfo.entries.map((entry) {
//                                     return TableRow(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 12.0, horizontal: 20),
//                                           child: Text(
//                                             entry.key,
//                                             style: TextStyle(
//                                               color: Color(0xFF323232),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 12.0, horizontal: 20),
//                                           child: Text(
//                                             entry.value,
//                                             style: TextStyle(
//                                               color: Color(0xFF323232),
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 child: SuppliersButtons(
//                                   suppliers: _data,
//                                   isAdd: true,
//                                   isSub: false,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 40,
//                               ),
//                               // 메모
//                               TableBar(titleText: '메모'),
//                               Container(
//                                 width: double.infinity,
//                                 height: 150,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Color(0xFFD6D6D6),
//                                   ),
//                                 ),
//                                 child: TextField(
//                                   controller: memoController,
//                                   keyboardType: TextInputType.multiline,
//                                   maxLines: null,
//                                   expands: true,
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.all(8.0),
//                                     border: InputBorder.none,
//                                     hintText: '내용을 입력하세요',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
