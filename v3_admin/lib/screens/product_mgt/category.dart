import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:v3_admin/common_widget/common_widgets.dart';
import 'package:v3_admin/common_widget/layout.dart';
import 'package:v3_admin/common_widget/naviagtion_helper.dart';

const expandChildrenOnReady = true;

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 4; // GNB : 상품관리
  int selectedMenu = 2; // SUB : 카테고리

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
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CategorySetting(),
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

class CategorySetting extends StatefulWidget {
  const CategorySetting({super.key});

  @override
  State<CategorySetting> createState() => _CategorySettingState();
}

class _CategorySettingState extends State<CategorySetting> {
  TreeViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      color: Color(0xFFF9FCFE),
      child: Column(
        children: [
          TitleSection(
            mainTitle: '카테고리',
            breadcrumb1: ' > 상품관리 > ',
            breadcrumb2: '카테고리',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 750,
                    decoration: commonBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        left: 30,
                        right: 30,
                        bottom: 20,
                      ),
                      child: Expanded(
                        child: TreeView.simple(
                          tree: prodTree,
                          showRootNode: true,
                          indentation:
                              const Indentation(style: IndentStyle.squareJoint),
                          onItemTap: (item) {},
                          onTreeReady: (controller) {
                            _controller = controller;
                            if (expandChildrenOnReady)
                              controller.expandAllChildren(prodTree);
                          },
                          builder: (context, node) => ListTile(
                            dense: true,
                            // contentPadding: const EdgeInsets.symmetric(
                            //     vertical: 0.0, horizontal: 8.0),
                            leading: Icon(
                              Icons.folder,
                              color: Color(0xFF5D75BF),
                            ),
                            title: Text(
                              "${node.key}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: node.level == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    CustomElevatedButton1(
                      backgroundColor: Color(0xFF5D75BF),
                      text: '추가',
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomElevatedButton2(
                      text: '삭제',
                      backgroundColor: Colors.white,
                      textColor: Color(0xFF9A9A9A),
                      borderColor: Color(0xFFD6D6D6),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 750,
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
                        children: [],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final prodTree = TreeNode.root()
    ..addAll([
      TreeNode(key: "농산물")
        ..addAll([
          TreeNode(key: "딸기"),
          TreeNode(key: "포도"),
          TreeNode(key: "복숭아"),
          TreeNode(key: "토마토"),
          TreeNode(key: "사과"),
          TreeNode(key: "참외"),
          TreeNode(key: "블루베리"),
          TreeNode(key: "고구마"),
          TreeNode(key: "파프리카"),
          TreeNode(key: "양파"),
        ]),
      TreeNode(key: "축산물")
        ..addAll([
          TreeNode(key: "한우"),
          TreeNode(key: "한돈"),
          TreeNode(key: "계육"),
        ]),
      TreeNode(key: "수산물")
        ..addAll([
          TreeNode(key: "연어"),
          TreeNode(key: "숭어"),
          TreeNode(key: "갈치"),
        ]),
      TreeNode(key: "반찬가게"),
    ]);
}
