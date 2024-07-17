import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';


class MemberAdd extends StatefulWidget {
  const MemberAdd({super.key});

  @override
  State<MemberAdd> createState() => _MemberAddState();
}

class _MemberAddState extends State<MemberAdd> {
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
                        RegistMember(),
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

class RegistMember extends StatefulWidget {
  const RegistMember({super.key});

  @override
  State<RegistMember> createState() => _RegistMemberState();
}

class _RegistMemberState extends State<RegistMember> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController repNameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController bizRegiNumController = TextEditingController();
  final TextEditingController bizFieldController = TextEditingController();
  final TextEditingController bizTypeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController mgrNameController = TextEditingController();
  final TextEditingController mgrContactController = TextEditingController();
  final TextEditingController mgrMailController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  // XFile? _bizRegiImg;
  // XFile? _accountImg;
  // final ImagePicker picker = ImagePicker();

  // Future getbizImage(ImageSource imageSource) async {
  //   final XFile? pickedFile = await picker.pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _bizRegiImg = XFile(pickedFile.path); 
  //     });
  //   }
  // }

  // Future getAccountImage(ImageSource imageSource) async {
  //   final XFile? pickedFile = await picker.pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _accountImg = XFile(pickedFile.path); 
  //     });
  //   }
  // }

    Uint8List? _bizImgData;
    Uint8List? _accountImgData;

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

    Future<void> getBizImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _bizImgData = file.bytes;
      });
    }
  }


  @override
  void dispose() {
    nameController.dispose();
    repNameController.dispose();
    typeController.dispose();
    bizRegiNumController.dispose();
    bizFieldController.dispose();
    bizTypeController.dispose();
    addressController.dispose();
    contactController.dispose();
    mgrNameController.dispose();
    mgrContactController.dispose();
    mgrMailController.dispose();
    memoController.dispose();
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
                    '{에스앤이컴퍼니(공급사명)} 상세정보',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  CustomElevatedButton1(
                    backgroundColor: Color(0xFF5D75BF),
                    text: '등록',
                    onPressed: () {
                      setState(() {});
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
                  height: 900,
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
                                  children: [
                                    buildRow('업체명', controller: nameController),
                                    buildRow('대표자명',
                                        controller: repNameController),
                                    buildRow('회원유형',
                                        controller: typeController),
                                    buildRow('사업자등록번호',
                                        controller: bizRegiNumController),
                                    buildRow('업태',
                                        controller: bizFieldController),
                                    buildRow('종목',
                                        controller: bizTypeController),
                                    buildRow('사업장 주소',
                                        controller: addressController),
                                    buildRow('사업장 번호',
                                        controller: contactController),
                                    TableRow(children: [
                                      buildCell('사업자등록증', isHeader: true),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 20),
                                        child: Row(
                                          children: [
                                            if (_bizImgData != null)
                                                Image.memory(
                                                  _bizImgData!,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                )
                                              else
                                                Text(''),
                                              SizedBox(width: 15,),
                                              CustomElevatedButton1(
                                                backgroundColor:
                                                    Color(0xFF5D75BF),
                                                text: '파일선택',
                                                onPressed: () {
                                                  getBizImage();
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                    ]),
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
                                              if (_accountImgData != null)
                                                Image.memory(
                                                  _accountImgData!,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                )
                                              else
                                                Text(''),
                                              SizedBox(width: 15,),
                                              CustomElevatedButton1(
                                                backgroundColor:
                                                    Color(0xFF5D75BF),
                                                text: '파일선택',
                                                onPressed: () {
                                                  getAccountImage();
                                                },
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
                              // 기업 담당자 정보
                              TableBar(titleText: '기업 담당자 정보'),
                              Container(
                                width: double.infinity,
                                height: 240,
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
                                        controller: mgrNameController),
                                    buildRow('연락처',
                                        controller: mgrContactController),
                                    buildRow('이메일',
                                        controller: mgrMailController),
                                  ],
                                ),
                              ),
                              TableBar(titleText: '기타 참고사항'),
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
                                    expands: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(8.0),
                                      border: InputBorder.none,
                                      hintText: '내용을 입력하세요',
                                    ),
                                  )),
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
