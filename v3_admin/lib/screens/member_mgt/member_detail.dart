import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class MemberDetail extends StatefulWidget {
  const MemberDetail({super.key});

  @override
  State<MemberDetail> createState() => _MemberDetailState();
}

class _MemberDetailState extends State<MemberDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 1; // GNB : 회원관리
  int selectedMenu = 1; // SUB : 일반회원

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
  bool isEditing = false;
  late Map<String, TextEditingController> controllers;
  late TextEditingController memoController;

  Uint8List? _accountImgData;
  Uint8List? _bizRegiImgData;

  Future<void> getAccountImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _accountImgData = file.bytes;
      });
    }
  }

  Future<void> getBizRegiImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _bizRegiImgData = file.bytes;
      });
    }
  }

  final Map<String, String> company_info = {
    'name': '비굿컴퍼니',
    'representativeName': '강현구',
    'type': '기타',
    'bizRegiNum': '1234567890',
    'bizField': '도매',
    'bizType': '농업',
    'address': '서울특별시 서초구 매헌로8길 39, D동 4층 406호(양재동, 희경재단) 테스트테스트테스트테스트',
    'contact': '010-1234-1234',
    'bizRegiImg':
        'https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae',
    'accountImg':
        'https://firebasestorage.googleapis.com/v0/b/v3mvp-b9aa4.appspot.com/o/uploads%2Fregister%2Fclient%2FIdyZUA7S6CcsbeKu7h7Gj8k9zpB2%2Fbusiness_registration_image?alt=media&token=7a17324f-6e09-4520-b4ef-6d4ddc4c29ae',
  };
  final Map<String, String> manager_info = {
    'name': '이태형',
    'contact': '010-1234-1234',
    'email': 'thl@bgood.co.kr',
  };
  final Map<String, String> product_order_info = {
    'ordered': '{n}건',
    'cancelled': '{n}건',
    'returned': '{n}건',
  };
  final Map<String, String> contract_info = {
    'ordered': '{n}건',
    'inProgress': '{n}건',
    'completed': '{n}건',
    'cancelled': '{n}건',
  };

  final Map<String, String> company_info_kr = {
    'name': '업체명',
    'representativeName': '대표자명',
    'type': '회원유형',
    'bizRegiNum': '사업자등록번호',
    'bizField': '업태',
    'bizType': '종목',
    'address': '사업장 주소',
    'contact': '사업장 번호',
    'bizRegiImg': '사업자등록증',
    'accountImg': '통장사본',
  };
  final Map<String, String> manager_info_kr = {
    'name': '이름',
    'contact': '연락처',
    'email': '이메일',
  };
  final Map<String, String> product_order_info_kr = {
    'ordered': '주문 건',
    'cancelled': '취소 건',
    'returned': '반품 건',
  };
  final Map<String, String> contract_info_kr = {
    'ordered': '문의 건',
    'inProgress': '진행 건',
    'completed': '완료 건',
    'cancelled': '취소 건',
  };

  @override
  void initState() {
    super.initState();
    controllers = {
      for (var entry in company_info.entries)
        entry.key: TextEditingController(text: entry.value),
      for (var entry in manager_info.entries)
        entry.key: TextEditingController(text: entry.value),
      for (var entry in product_order_info.entries)
        entry.key: TextEditingController(text: entry.value),
      for (var entry in contract_info.entries)
        entry.key: TextEditingController(text: entry.value)
    };
    memoController = TextEditingController(text: ''); // 저장된 메모로 초기화 필요
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
                    '${company_info["name"]} 상세정보',
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
                      context.go('/member');
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
                              // 기업 정보
                              TableBar(titleText: '기업 정보'),
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
                                  children: company_info.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            company_info_kr[entry.key]!,
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
                                          child: entry.key == 'bizRegiImg' ||
                                                  entry.key == 'accountImg'
                                              ? (entry.value == null
                                                  ? Text('')
                                                  : Row(
                                                      children: [
                                                        _getImageWidget(
                                                            entry.key,
                                                            entry.value),
                                                        if (isEditing)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                            child:
                                                                CustomElevatedButton1(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xFF5D75BF),
                                                                    text:
                                                                        '파일선택',
                                                                    onPressed:
                                                                        () {
                                                                      if (entry
                                                                              .key ==
                                                                          'bizRegiImg') {
                                                                        getBizRegiImage();
                                                                      } else {
                                                                        getAccountImage();
                                                                      }
                                                                    }),
                                                          ),
                                                      ],
                                                    ))
                                              : isEditing
                                                  ? Container(
                                                      width: 350,
                                                      height:
                                                          entry.key == 'address'
                                                              ? 80
                                                              : 45,
                                                      child: TextFormField(
                                                        controller: controllers[
                                                            entry.key],
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                        maxLines: entry.key ==
                                                                'address'
                                                            ? null
                                                            : 1,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: entry.value,
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xFFD1D1D1),
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xFFD1D1D1),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Text(
                                                      entry.value,
                                                      style: const TextStyle(
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
                              // 기업 담당자 정보
                              TableBar(titleText: '기업 담당자 정보'),
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
                                  children: manager_info.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            manager_info_kr[entry.key]!,
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
                              TableBar(titleText: '비굿마켓 주문 정보'),
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
                                  children:
                                      product_order_info.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            product_order_info_kr[entry.key]!,
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
                                          child: Text(
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
                              TableBar(titleText: '선도거래 주문 정보'),
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
                                  children: contract_info.entries.map((entry) {
                                    return TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 20),
                                          child: Text(
                                            contract_info_kr[entry.key]!,
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
                                          child: Text(
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
                              // 기타 참고사항
                              TableBar(titleText: '기타 참고사항'),
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFD6D6D6),
                                  ),
                                ),
                                child: isEditing
                                    ? TextField(
                                        controller: memoController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        expands: true,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8.0),
                                          border: InputBorder.none,
                                          hintText: '내용을 입력하세요',
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          memoController.text,
                                          style: const TextStyle(
                                            color: Color(0xFF323232),
                                            fontSize: 14,
                                          ),
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

  Widget _getImageWidget(String key, String url) {
    Uint8List? imageData =
        key == 'bizRegiImg' ? _bizRegiImgData : _accountImgData;
    if (imageData != null) {
      return Image.memory(
        imageData,
        height: 100,
        fit: BoxFit.contain,
      );
    } else {
      return Image.network(
        url,
        height: 100,
        fit: BoxFit.contain,
      );
    }
  }
}
