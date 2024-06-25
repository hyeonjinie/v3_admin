import 'package:flutter/material.dart';
import 'package:v3_admin/screens/main_screen.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

// 타이틀 및 네비게이션 영역
class TitleSection extends StatelessWidget {
  final String mainTitle;
  final String breadcrumb1;
  final String breadcrumb2;

  TitleSection({
    required this.mainTitle,
    required this.breadcrumb1,
    required this.breadcrumb2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          mainTitle,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Row(
          children: [
            // 홈 아이콘
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.home,
                    size: 20.0,
                    color: Color(0xFF9A9A9A),
                  ),
                  Text(
                    breadcrumb1,
                    style: TextStyle(
                      color: Color(0xFF9A9A9A),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    breadcrumb2,
                    style: TextStyle(
                      color: Color(0xFF282828),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// 배경색상 있는 버튼
class CustomElevatedButton1 extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  CustomElevatedButton1({
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: Size(100, 50),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// 테두리 버튼
class CustomElevatedButton2 extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;

  CustomElevatedButton2({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: Size(100, 50),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// 셀렉트박스
class SelectBoxExample extends StatefulWidget {
  final String initialValue;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final double custom_width;

  SelectBoxExample({
    required this.initialValue,
    required this.options,
    required this.onChanged,
    required this.custom_width,
  });

  @override
  _SelectBoxExampleState createState() => _SelectBoxExampleState();
}

class _SelectBoxExampleState extends State<SelectBoxExample> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.custom_width,
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFD6D6D6),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        value: _selectedValue,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        underline: SizedBox(),
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// 날짜 선택 박스
class CustomDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final Function(BuildContext, TextEditingController) onDateTap;
  final String hintText;

  CustomDatePickerField({
    required this.controller,
    required this.onDateTap,
    this.hintText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFD6D6D6),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: InputBorder.none,
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today, color: Color(0xFF999999)),
            onPressed: () {
              onDateTap(context, controller);
            },
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        onTap: () {
          onDateTap(context, controller);
        },
      ),
    );
  }
}

// detail페이지 테이블 상단 바
class TableBar extends StatelessWidget {
  final String titleText;

  TableBar({
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 43,
      decoration: BoxDecoration(
        color: Color(0xFFF1F1F1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFFD0D0D0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 12),
        child: Text(
          titleText,
          style: TextStyle(
            color: Color(0xFF282828),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// detail페이지 테이블 상단 바 - 버튼 유형
class Btn_TableBar extends StatelessWidget {
  final String titleText;
  final String btnText;
  final VoidCallback onBtnPressed;

  Btn_TableBar({
    required this.titleText,
    required this.btnText,
    required this.onBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 43,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F1F1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFFD0D0D0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleText,
              style: const TextStyle(
                color: Color(0xFF282828),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            OutlinedButton(
              onPressed: onBtnPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFFD6D6D6)),
                backgroundColor: Colors.white,
              ),
              child: Text(
                btnText,
                style: const TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 공통 화면 UI - 상단 테두리 박스
final BoxDecoration commonBoxDecoration = BoxDecoration(
  color: Colors.white,
  border: Border(
    top: BorderSide(
      color: Color(0xFF5D75BF),
      width: 3.0,
    ),
    bottom: BorderSide(
      color: Color(0xFFD1D1D1),
      width: 1.0,
    ),
    left: BorderSide(
      color: Color(0xFFD1D1D1),
      width: 1.0,
    ),
    right: BorderSide(
      color: Color(0xFFD1D1D1),
      width: 1.0,
    ),
  ),
);

// 이미지 크게보기
void showImagePopup(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '닫기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Image.network(imageUrl, fit: BoxFit.contain),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// 검색영역 내의 항목명
Widget textBox(String text) {
  return SizedBox(
    width: 120,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

// 검색영역 내의 토글버튼
Widget buildToggleButton(String text, bool isSelected) {
  return SizedBox(
    width: 60,
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Color(0xFF4470F6) : Colors.black,
        ),
      ),
    ),
  );
}

// 테이블 내의 체크박스 ui
Widget customCheckbox(
    {required bool value, required ValueChanged<bool?> onChanged}) {
  return Theme(
    data: ThemeData(
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Color(0xFF5D75BF);
          }
          return null;
        }),
      ),
    ),
    child: Checkbox(
      value: value,
      onChanged: onChanged,
    ),
  );
}

// 등록 및 수정페이지_ 텍스트 필드
Widget buildCell(String text,
    {bool isHeader = false, TextEditingController? controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
    child: controller == null
        ? Container(
            height: 45,
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF323232),
                fontSize: 14,
                fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          )
        : Container(
            width: 350,
            height: 45,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
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
  );
}

TableRow buildRow(String label, {TextEditingController? controller}) {
  return TableRow(
    children: [
      buildCell(label, isHeader: true),
      buildCell('', controller: controller),
    ],
  );
}

// 탭 구조 안 텍스트
Widget tabTextBox(String text1, String text2, double w) {
  return Row(
    children: [
      SizedBox(
        width: w,
        child: Text(
          text1,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      Text(text2),
    ],
  );
}


Widget customTextField(
    String txt, String hint, TextEditingController? controller) {
  return Row(
    children: [
      SizedBox(
        width: 120,
        child: Text(
          txt,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      Container(
        width: 350,
        height: 45,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
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
  );
}

Widget buildRadioButton(String label, bool isSelected) {
  return Row(
    children: [
      Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isSelected ? Color(0xFF4470F6) : Color(0xFFD0D0D0),
      ),
      SizedBox(width: 8),
      Text(label),
      SizedBox(width: 16),
    ],
  );
}

// 정산 및 세금계산서 등록에 필요한 텍스트필드
Widget textToText(TextEditingController? controller1,
    TextEditingController? controller2, String _text, double custom_width) {
  return Row(
    children: [
      SizedBox(
        width: 120,
        child: Text(
          _text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      Container(
        width: custom_width,
        height: 45,
        child: TextFormField(
          controller: controller1,
          decoration: InputDecoration(
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
      SizedBox(
        width: 30,
        child: Text(
          ' → ',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      Container(
        width: custom_width,
        height: 45,
        child: TextFormField(
          controller: controller2,
          decoration: InputDecoration(
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
  );
}

// 공급처
// class SuppliersButtons extends StatefulWidget {
//   final List<dynamic> suppliers;
//   final bool isAdd;
//   final bool isSub;

//   SuppliersButtons(
//       {required this.suppliers, required this.isAdd, required this.isSub});

//   @override
//   _SuppliersButtonsState createState() => _SuppliersButtonsState();
// }

// class _SuppliersButtonsState extends State<SuppliersButtons> {
//   int _selectedSupplierIndex = 0;
//   void _showEditDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return EditDialog(
//           suppliers: widget.suppliers,
//           onSave: (updatedSuppliers) {
//             setState(() {
//             });
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             if (widget.suppliers == null || widget.suppliers.isEmpty)
//               const Expanded(
//                 child: Row(
//                   children: [
//                     Text(
//                       '공급처 정보 없음',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//               )
//             else
//               Expanded(
//                 child: Row(
//                   children:
//                       List<Widget>.generate(widget.suppliers.length, (index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedSupplierIndex = index;
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         alignment: Alignment.center,
//                         width: 85,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(8.0),
//                             topRight: Radius.circular(8.0),
//                           ),
//                           border: Border.all(
//                               color: _selectedSupplierIndex == index
//                                   ? Color(0xFF5D75BF)
//                                   : Color(0xFFD6D6D6)),
//                         ),
//                         child: Text(
//                           '공급처${index + 1}',
//                           style: TextStyle(
//                             color: _selectedSupplierIndex == index
//                                 ? Color(0xFF5D75BF)
//                                 : Colors.black,
//                             fontWeight: _selectedSupplierIndex == index
//                                 ? FontWeight.bold
//                                 : FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             if (widget.suppliers != null &&
//                 widget.suppliers.isNotEmpty &&
//                 widget.isAdd)
//               TextButton(
//                 onPressed: () {
//                   _showEditDialog();
//                 },
//                 child: const Text(
//                   '편집',
//                   style: TextStyle(
//                     color: Color(0xFF5D75BF),
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             widget.isAdd
//                 ? OutlinedButton(
//                     onPressed: () {},
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(color: Color(0xFFD6D6D6)),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Text(
//                       '공급처 추가',
//                       style: TextStyle(
//                         color: Color(0xFF323232),
//                         fontSize: 14,
//                       ),
//                     ),
//                   )
//                 : SizedBox(),
//           ],
//         ),
//         if (widget.suppliers != null && widget.suppliers.isNotEmpty)
//           Container(
//             padding: const EdgeInsets.all(25.0),
//             alignment: Alignment.center,
//             height: 170,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(8.0),
//                 bottomRight: Radius.circular(8.0),
//                 topRight: Radius.circular(8.0),
//               ),
//               border: Border.all(color: Color(0xFFD6D6D6)),
//             ),
//             child: Column(
//               children: [
//                 tabTextBox(
//                     '업체명 :',
//                     '${widget.suppliers[_selectedSupplierIndex!]['supplierName']} / ${widget.suppliers[_selectedSupplierIndex!]['bizRegiNum']}',
//                     120),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 tabTextBox(
//                     '원물가격 :',
//                     '${currencyFormat.format((widget.suppliers[_selectedSupplierIndex!]['cost']))}원',
//                     120),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 tabTextBox(
//                     '공급물량 :',
//                     '${currencyFormat.format(widget.suppliers[_selectedSupplierIndex!]['volume'])}kg',
//                     120),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 tabTextBox(
//                     '총 금액 :',
//                     '${currencyFormat.format(widget.suppliers[_selectedSupplierIndex!]['totalAmount'])}원',
//                     120),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }

// class EditDialog extends StatefulWidget {
//   final List<dynamic> suppliers;
//   final Function(List<Map<String, dynamic>>) onSave;

//   EditDialog({required this.suppliers, required this.onSave});

//   @override
//   _EditDialogState createState() => _EditDialogState();
// }

// class _EditDialogState extends State<EditDialog> {
//   late List<Map<String, dynamic>> _tempSuppliers;

//   @override
//   void initState() {
//     super.initState();
//     _tempSuppliers = List.from(widget.suppliers);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('공급처 정보 편집'),
//       content: SingleChildScrollView(
//         child: Column(
//           children: List<Widget>.generate(_tempSuppliers.length, (index) {
//             return Column(
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: '업체명',
//                   ),
//                   controller: TextEditingController(
//                     text: _tempSuppliers[index]['supplierName'],
//                   ),
//                   readOnly: true,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: '사업자등록번호',
//                   ),
//                   controller: TextEditingController(
//                     text: _tempSuppliers[index]['bizRegiNum'],
//                   ),
//                   readOnly: true,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: '원물가격',
//                   ),
//                   controller: TextEditingController(
//                     text: _tempSuppliers[index]['cost'].toString(),
//                   ),
//                   onChanged: (value) {
//                     _tempSuppliers[index]['cost'] = int.parse(value);
//                   },
//                   keyboardType: TextInputType.number,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: '공급물량',
//                   ),
//                   controller: TextEditingController(
//                     text: _tempSuppliers[index]['volume'].toString(),
//                   ),
//                   onChanged: (value) {
//                     _tempSuppliers[index]['volume'] = int.parse(value);
//                   },
//                   keyboardType: TextInputType.number,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: '총 금액',
//                   ),
//                   controller: TextEditingController(
//                     text: _tempSuppliers[index]['totalAmount'].toString(),
//                   ),
//                   onChanged: (value) {
//                     _tempSuppliers[index]['totalAmount'] = int.parse(value);
//                   },
//                   keyboardType: TextInputType.number,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       _tempSuppliers.removeAt(index);
//                     });
//                   },
//                   child: Text(
//                     '삭제',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//                 const Divider(),
//               ],
//             );
//           }),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('취소'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             widget.onSave(_tempSuppliers);
//             Navigator.of(context).pop();
//           },
//           child: Text('수정'),
//         ),
//       ],
//     );
//   }
// }








