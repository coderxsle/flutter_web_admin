import 'package:flutter/material.dart';

/// 有状态StatefulWidget
///  继承于 StatefulWidget，通过 State 的 build 方法去构建控件
class TabBarTopCustom extends StatefulWidget {
  final List tabs;
//  通过构造方法传值
  const TabBarTopCustom({super.key, required this.tabs});
  //主要是负责创建state
  @override
  TabBarTopCustomState createState() => TabBarTopCustomState();
}

/// 在 State 中,可以动态改变数据
/// 在 setState 之后，改变的数据会触发 Widget 重新构建刷新
class TabBarTopCustomState extends State<TabBarTopCustom> with SingleTickerProviderStateMixin {
  //List tabs = ["首页", "发现", "我的", "设置","第五个","第六个"];
  //用于控制/监听Tab菜单切换
  //TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的。
  late TabController tabController;

  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
    tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void didChangeDependencies() {
    ///在initState之后调 Called when a dependency of this [State] object changes.
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return buildTabScaffold();
  }

  //通过“bottom”属性来添加一个导航栏底部tab按钮组，将要实现的效果如下：
  Widget buildTabScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
        //设置选项卡
        bottom: buildTabBar(),
        //设置标题居中
        centerTitle: true,
      ),
      //设置选项卡对应的page
      body: buildBodyView(),
    );
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  buildBodyView() {
    //构造 TabBarView
    Widget tabBarBodyView = TabBarView(
      controller: tabController,
      //创建Tab页
      children: widget.tabs.map((e) {
        return Container(
          alignment: Alignment.center,
          child: Text(e, textScaleFactor: 1),
        );
      }).toList(),
    );
    return tabBarBodyView;
  }

  buildTabBar() {
    //构造 TabBar
    Widget tabBar = TabBar(
        //tabs 的长度超出屏幕宽度后，TabBar，是否可滚动
        //设置为false tab 将平分宽度，为true tab 将会自适应宽度
        isScrollable: true,
        //设置tab文字得类型
        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        //设置tab选中得颜色
        labelColor: Colors.white,
        //设置tab未选中得颜色
        unselectedLabelColor: Colors.white70,
        //设置自定义tab的指示器，CustomUnderlineTabIndicator
        //若不需要自定义，可直接通过
        //indicatorColor 设置指示器颜色
        //indicatorWight 设置指示器厚度
        //indicatorPadding
        //indicatorSize  设置指示器大小计算方式
        ///指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
        indicatorSize: TabBarIndicatorSize.tab,
        //生成Tab菜单
        controller: tabController,
        //构造Tab集合
        tabs: widget.tabs.map((e) => Tab(text: e)).toList());

    return tabBar;
  }
}
