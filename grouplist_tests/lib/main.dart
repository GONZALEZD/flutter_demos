import 'dart:math';

import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart' as fsl;
import 'package:flutter_section_list_view/flutter_section_list_view.dart';
import 'package:flutter_tableview/flutter_tableview.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:linkageview/linkage_view.dart';

import 'src/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  List<DataTestGroup> _data;

  List<DataTestGroup> get data =>
      _data != null ? _data : (_data = _buildData());

  List<DataTestGroup> _buildData() {
    final sectionsTitle = {
      "Section 01": Icons.map,
      "Section 02": Icons.extension,
      "Section 03": Icons.group,
      "Section 04": Icons.add_moderator,
      "Section 05": Icons.add_shopping_cart,
      "Section 06": Icons.local_activity,
      "Section 07": Icons.home,
      "Section 08": Icons.airline_seat_individual_suite,
      "Section 09": Icons.location_on,
      "Section 10": Icons.airplanemode_on,
    };
    final rand = Random();
    return List.generate(sectionsTitle.length, (index) {
      final key = sectionsTitle.keys.elementAt(index);
      return DataTestGroup.generate(
        name: key,
        icon: sectionsTitle[key],
        dataPrefix: "$key Data ",
        dataLength: 5 + rand.nextInt(10),
      );
    });
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget Function() _buildMethod;

  @override
  void initState() {
    super.initState();
    _buildMethod = _buildGroupListView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [_buildMenu()],
      ),
      body: _buildMethod(),
    );
  }

  Widget _buildMenu() {
    return PopupMenuButton(
        icon: Icon(Icons.menu),
        onSelected: (method) => setState(() => _buildMethod = method),
        itemBuilder: (context) {
          final methods = {
            'FlutterSectionListView': _buildFlutterSectionListView,
            'FlutterTableView': _buildFlutterTableView,
            'GroupedListView': _buildGroupedListView,
            'GroupListView': _buildGroupListView,
            'SectionListView': _buildSectionListView,
            'LinkageView': _buildLinkageView,
            'MY LIBRARY': _buildCupertinoListView,
          };
          return methods.keys.map((key) {
            return PopupMenuItem(
              value: methods[key],
              child: Text(key),
            );
          }).toList();
        });
  }

  Widget _buildGroupedListView() {
    return GroupedListView<Map<String, dynamic>, String>(
      floatingHeader: true,
      useStickyGroupSeparators: true,
      elements: widget.data
          .map((e) => e.flatMap())
          .fold([], (list, elt) => list + elt),
      groupBy: (element) => element['name'],
      itemComparator: (map1, map2) => map1['dataValue'] - map2['dataValue'],
      itemBuilder: (context, map) =>
          __buildData(name: map['dataName'], value: map['dataValue']),
      groupHeaderBuilder: (map) =>
          __buildHeader(name: map['name'], icon: map['icon']),
    );
  }

  Widget _buildGroupListView() {
    return GroupListView(
      sectionsCount: widget.data.length,
      countOfItemInSection: (section) => widget.data[section].count,
      groupHeaderBuilder: (context, index) {
        final section = widget.data[index];
        return __buildHeader(name: section.name, icon: section.icon);
      },
      itemBuilder: (context, path) {
        final data = widget.data[path.section][path.index];
        return __buildData(name: data.name, value: data.value);
      },
    );
  }

  Widget _buildFlutterSectionListView() {
    return FlutterSectionListView(
      numberOfSection: () => widget.data.length,
      numberOfRowsInSection: (section) => widget.data[section].count,
      sectionWidget: (index) {
        final section = widget.data[index];
        return __buildHeader(name: section.name, icon: section.icon);
      },
      rowWidget: (section, index) {
        final data = widget.data[section][index];
        return __buildData(name: data.name, value: data.value);
      },
    );
  }

  Widget _buildFlutterTableView() {
    return FlutterTableView(
      sectionCount: widget.data.length,
      rowCountAtSection: (section) => widget.data[section].count,
      sectionHeaderBuilder: (_, index) {
        final section = widget.data[index];
        return __buildHeader(name: section.name, icon: section.icon);
      },
      cellBuilder: (_, section, index) {
        final data = widget.data[section][index];
        return __buildData(name: data.name, value: data.value);
      },
      sectionHeaderHeight: (_, __) => 50.0,
      cellHeight: (_, section, index) => 40.0,
    );
  }

  Widget _buildSectionListView() {
    return fsl.SectionListView.builder(
      adapter: SectionListViewAdapter(
        data: widget.data,
        sectionBuilder: (name, icon) => __buildHeader(name: name, icon: icon),
        itemBuilder: (name, value) => __buildData(name: name, value: value),
      ),
    );
  }

  Widget _buildLinkageView() {
    final baseItemBuilder = (BaseItem item) {
      if (item.isHeader) {
        return __buildHeader(name: item.header, icon: item.info);
      }
      return __buildData(name: item.title, value: item.info);
    };
    return LinkageView<BaseItem>(
      isNeedStick: true,
      items: widget.data
          .map((e) => e.toBaseItems())
          .fold([], (list, elt) => list + elt),
      itemBuilder: (_, __, item) => baseItemBuilder(item),
      headerBuilder: (_, item) =>
          __buildHeader(name: item.header, icon: item.info),
      curve: Curves.elasticInOut,
      groupItemBuilder: (_, __, item) => Icon(
        item.info,
        color: Colors.blue,
      ),
      itemHeadHeight: 70.0,
      onGroupItemTap: (_, __, item) =>
          print('Selected section: ${item.header}'),
      duration: 500, // milliseconds
    );
  }

  Widget _buildCupertinoListView() {
    return CupertinoListView.builder(
      sectionCount: widget.data.length,
      sectionBuilder: (_,index,__) {
        final section = widget.data[index];
        return __buildHeader(name: section.name, icon: section.icon);
      },
      childBuilder: (_, section, index, __) {
        final data = widget.data[section][index];
        return __buildData(name: data.name, value: data.value);
      },
      itemInSectionCount: (section) => widget.data[section].count,
      separatorBuilder: (_, __, ___, ____) => SizedBox(),
    );
  }

  Widget __buildHeader({String name, IconData icon}) {
    return ListTile(
      tileColor: Theme.of(context).primaryColor,
      leading: Icon(
        icon,
        size: 40,
        color: Colors.white,
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget __buildData({String name, int value}) {
    final text = value.isOdd ? name : '$name ' * 10;
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            width: 50.0,
            child: Text('$value'),
          ),
          Expanded(
              child: Text(
            text,
            maxLines: 100,
          )),
        ],
      ),
    );
  }
}

class SectionListViewAdapter with fsl.SectionAdapterMixin {
  final List<DataTestGroup> data;
  final Widget Function(String name, IconData icon) sectionBuilder;
  final Widget Function(String name, int value) itemBuilder;

  SectionListViewAdapter({this.data, this.sectionBuilder, this.itemBuilder});

  @override
  int numberOfSections() => data.length;

  @override
  Widget getItem(BuildContext context, fsl.IndexPath indexPath) {
    final item = data[indexPath.section][indexPath.item];
    return itemBuilder(item.name, item.value);
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    final item = data[section];
    return sectionBuilder(item.name, item.icon);
  }

  @override
  int numberOfItems(int section) => data[section].count;

  @override
  bool shouldExistSectionHeader(int section) => true;

  @override
  bool shouldSectionHeaderStick(int section) => true;
}
