import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Menu1 extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<Menu1>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (kReleaseMode) {
      sl<FirebaseAnalytics>().setCurrentScreen(
          screenName: 'Category_Page', screenClassOverride: 'Category_Page');
      sl<FirebaseAnalytics>()
          .logEvent(name: "Page_Visit", parameters: {'title': "Category_Page"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, dashboardState) {
        Map<String, List<String>> categories =
            CategoryUtil.getCategories(dashboardState);
        return Scaffold(
          floatingActionButton: DraggableFloatingActionButton(
            url: "category_page",
            fromIndexPage: true,
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900]
                : kBlue,
            title: InkWell(
              onTap: () {
                Router.navigator.pushNamed(Router.categoryPageListVersion,
                    arguments: dashboardState);
              },
              child: Container(
                  height: searchBar32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(cornerRadius5),
                  ),
                  margin: kSearchBarMargin,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: padding12, right: padding8),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: searchIconSize,
                        ),
                      ),
                      Text(
                        'Search',
                        style:
                            TextStyle(color: Colors.grey, fontSize: textSize14),
                      ),
                    ],
                  )),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ConnectivityMessage(
                url: 'category',
              ),
              Expanded(
                child: Container(
                  child: newTabBar(categories, context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget newTabBar(Map<String, List<String>> categories, BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Column(
        children: [
          Container(
            margin: kCategoryBodyMargin,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: kWhite,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: padding16),
              unselectedLabelStyle: TextStyle(),
              unselectedLabelColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? kWhite
                      : kBlack,
              labelStyle: TextStyle(),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(cornerRadius5),
                  color: kBlue),
              tabs: getTabs(categories, context),
            ),
          ),
          Expanded(
            child: TabBarView(children: getCategories(categories)),
          ),
        ],
      ),
    );
  }

  getTabs(Map<String, List<String>> categories, BuildContext context) {
    List headings = categories.keys.toList();
    List<Widget> tabs = [];
    for (int i = 0; i < headings.length; i++) {
      tabs.add(
        Padding(
          padding: kCategoryTabPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CategoryUtil.icons[headings[i]],
                size: iconSize16,
              ),
              SizedBox(
                height: padding8,
              ),
              Center(
                child: Text(
                  headings[i],
                  style: TextStyle(fontSize: textSize14),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return tabs;
  }

  getCategories(Map<String, List<String>> categories) {
    List<Widget> body = [];
    categories.keys.toList().forEach((category) {
      List<Widget> items = [];
      categories[category].forEach((element) {
        items.add(InkWell(
          onTap: () {
            Router.navigator.pushNamed(CategoryUtil.routes[element]);
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: padding1, horizontal: padding4),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: padding16, vertical: padding24),
                decoration: BoxDecoration(
//                    color: Theme.of(context).brightness == Brightness.light
//                        ? Colors.white
//                        : Colors.grey[900],
                    border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? kGradeCardBorderColor
                          : kGradeCardBorderColorDark),
                )),
                child: Text(
                  element,
                  style: TextStyle(),
                ),
              ),
            ),
          ),
        ));
      });
      body.add(Padding(
        padding: kCategoryViewPadding,
        child: ListView(
          children: items,
        ),
      ));
    });
    return body;
  }

  @override
  bool get wantKeepAlive => true;
}

class Menu2 extends StatefulWidget {
  final DashboardState dashboardState;

  Menu2(this.dashboardState);

  @override
  _CategoryPageListVersionState createState() =>
      _CategoryPageListVersionState(dashboardState);
}

class _CategoryPageListVersionState extends State<Menu2> {
  final DashboardState dashboardState;
  ValueNotifier<bool> isSearching = ValueNotifier<bool>(false);
  TextEditingController searchTextController = TextEditingController();

  _CategoryPageListVersionState(this.dashboardState);
  @override
  void initState() {
    if (kReleaseMode) {
      sl<FirebaseAnalytics>().setCurrentScreen(
          screenName: 'Category_Page_List',
          screenClassOverride: 'Category_Page_List');
      sl<FirebaseAnalytics>().logEvent(
          name: "Page_Visit", parameters: {'title': "Category_Page_List"});
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
    isSearching.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => sl<CategoryBloc>()
        ..add(CategoryEvent.filterCategory(keyword: "", state: dashboardState)),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          var nextView;
          state.when(
            initial: () {
              nextView = Container();
            },
            filtered: (categories) {
              nextView = Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? kBlack
                          : kWhite,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? kWhite
                            : kBlack45),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: TextField(
                    autofocus: true,
                    controller: searchTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                    ),
                    onChanged: (value) {
                      if (value.trim().length == 0) {
                        isSearching.value = false;
                      } else {
                        isSearching.value = true;
                      }
                      BlocProvider.of<CategoryBloc>(context)
                        ..add(CategoryEvent.filterCategory(
                            keyword: value, state: dashboardState));
                    },
                  ),
                  actions: <Widget>[
                    ValueListenableBuilder(
                      builder: (BuildContext context, value, Widget child) {
                        return isSearching.value
                            ? IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.times,
                                  color: kBlack45,
                                  size: iconSize16,
                                ),
                                onPressed: () {
                                  BlocProvider.of<CategoryBloc>(context)
                                    ..add(CategoryEvent.filterCategory(
                                        keyword: "", state: dashboardState));
                                  searchTextController.text = "";
                                  isSearching.value = false;
                                },
                              )
                            : Container();
                      },
                      valueListenable: isSearching,
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                    child: categories.length == 0
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: Center(
                              child: Text(
                                "No results found",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: kGrey),
                              ),
                            ))
                        : getCategories(categories)),
              );
            },
          );
          return nextView;
        },
      ),
    );
  }

  getModules(Map<String, List<String>> categories, String category) {
    List<Widget> list = [];
    categories[category].forEach((element) {
      list.add(GestureDetector(
        onTap: () {
          Router.navigator.pushNamed(CategoryUtil.routes[element]);
        },
        child: Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: kCategoryListPadding,
              child: Text(element),
            ),
          ),
        ),
      ));
    });
    return list;
  }

  getCategories(Map<String, List<String>> categories) {
    List<Widget> list = [];
    categories.keys.toList().forEach((element) {
      list.add(Theme(
        data: ThemeData(
            accentColor: kBlue,
            textTheme: TextTheme(),
            unselectedWidgetColor: kGrey),
        child: ExpansionTile(
            initiallyExpanded: true,
            title: Align(
              child: Text(
                element,
                style: TextStyle(
                  fontSize: textSize14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? kWhite
                      : kBlack,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            leading: Align(
              alignment: Alignment.centerLeft,
              widthFactor: widthFactor2,
              child: Icon(
                CategoryUtil.icons[element],
                size: iconSize16,
              ),
            ),
            children: getModules(categories, element)),
      ));
    });
    return Column(
      children: list,
    );
  }
}

class Menu3 extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<Menu3>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (kReleaseMode) {
      sl<FirebaseAnalytics>().setCurrentScreen(
          screenName: 'Category_Page', screenClassOverride: 'Category_Page');
      sl<FirebaseAnalytics>()
          .logEvent(name: "Page_Visit", parameters: {'title': "Category_Page"});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, dashboardState) {
        Map<String, List<String>> categories =
            CategoryUtil.getCategories(dashboardState);
        return Scaffold(
          floatingActionButton: DraggableFloatingActionButton(
            url: "category_page",
            fromIndexPage: true,
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900]
                : kBlue,
            title: InkWell(
              onTap: () {
                Router.navigator.pushNamed(Router.categoryPageListVersion,
                    arguments: dashboardState);
              },
              child: Container(
                  height: searchBar32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(cornerRadius5),
                  ),
                  margin: kSearchBarMargin,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: padding12, right: padding8),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: searchIconSize,
                        ),
                      ),
                      Text(
                        'Search',
                        style:
                            TextStyle(color: Colors.grey, fontSize: textSize14),
                      ),
                    ],
                  )),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ConnectivityMessage(
                url: 'category',
              ),
              Expanded(
                child: Container(
                  child: newTabBar(categories, context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget newTabBar(Map<String, List<String>> categories, BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Column(
        children: [
          Container(
            margin: kCategoryBodyMargin,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: kWhite,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: padding16),
              unselectedLabelStyle: TextStyle(),
              unselectedLabelColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? kWhite
                      : kBlack,
              labelStyle: TextStyle(),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(cornerRadius5),
                  color: kBlue),
              tabs: getTabs(categories, context),
            ),
          ),
          Expanded(
            child: TabBarView(children: getCategories(categories)),
          ),
        ],
      ),
    );
  }

  getTabs(Map<String, List<String>> categories, BuildContext context) {
    List headings = categories.keys.toList();
    List<Widget> tabs = [];
    for (int i = 0; i < headings.length; i++) {
      tabs.add(
        Padding(
          padding: kCategoryTabPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CategoryUtil.icons[headings[i]],
                size: iconSize16,
              ),
              SizedBox(
                height: padding8,
              ),
              Center(
                child: Text(
                  headings[i],
                  style: TextStyle(fontSize: textSize14),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return tabs;
  }

  getCategories(Map<String, List<String>> categories) {
    List<Widget> body = [];
    categories.keys.toList().forEach((category) {
      List<Widget> items = [];
      categories[category].forEach((element) {
        items.add(InkWell(
          onTap: () {
            Router.navigator.pushNamed(CategoryUtil.routes[element]);
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: padding1, horizontal: padding4),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: padding16, vertical: padding24),
                decoration: BoxDecoration(
//                    color: Theme.of(context).brightness == Brightness.light
//                        ? Colors.white
//                        : Colors.grey[900],
                    border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? kGradeCardBorderColor
                          : kGradeCardBorderColorDark),
                )),
                child: Text(
                  element,
                  style: TextStyle(),
                ),
              ),
            ),
          ),
        ));
      });
      body.add(Padding(
        padding: kCategoryViewPadding,
        child: ListView(
          children: items,
        ),
      ));
    });
    return body;
  }

  @override
  bool get wantKeepAlive => true;
}
