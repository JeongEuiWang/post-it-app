import 'package:flutter/material.dart';

class HomeTabView extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews;

  const HomeTabView({Key? key, required this.tabs, required this.tabViews});
  @override
  HomeTabViewState createState() => HomeTabViewState();
}

class HomeTabViewState extends State<HomeTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // initState 이후 초기화

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    //위젯이 소멸될 때 시행되는 함수 (컨트롤러 해제 => 메모리 누수 방지)
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                  color: Color(0xFF246BFD), // 선택된 라인의 색상
                  width: 3.0, // 선택된 라인의 높이
                )),
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            tabs: widget.tabs,
            dividerHeight: 3.0,
            dividerColor: Color(0xFFF2F2F2),
            // indicatorColor: Colors.blue,
            labelColor: Color(0xFF246BFD),
            unselectedLabelColor: Color(0xFFA3A3A3),
            splashFactory: NoSplash.splashFactory,
            overlayColor: null,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        Expanded(
            child: TabBarView(
                controller: _tabController, children: widget.tabViews))
      ],
    );
  }
}
