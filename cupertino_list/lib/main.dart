import 'package:cupertino_list/src/console.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CupertinoListView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter CupertinoListView Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _data = Section.allData();
  AutoScrollController _scrollController;

  List<List<Widget>> _children;
  Map<int, int> _sectionIndexes;

  @override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setupList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [_buildMenu()],
      ),
      body: CupertinoListView(
        controller: _scrollController,
        children: _children,
        floatingSectionBuilder: _buildSection,
      ),
    );
  }

  Widget __wrap({Widget child, int index, bool disabled = false}) {
    return AutoScrollTag(
      index: index,
      key: ValueKey(index),
      controller: _scrollController,
      child: child,
      disabled: disabled,
    );
  }

  void _setupList() {
    int index = 0, attrCount;
    _children = [];
    _sectionIndexes = {};
    List<Widget> tmp;
    final buildIndex = (section, child, index) {
      return IndexPath(section: section, child: child, absoluteIndex: index);
    };
    for (var i = 0; i < _data.length; i++) {
      tmp = [
        _buildSection(
            context, SectionPath(section: i, absoluteIndex: index), false)
      ];
      _sectionIndexes[i] = index++;
      attrCount = _data[i].attributes.length;
      for (var j = 0; j < attrCount; j++) {
        tmp.add(_buildItem(context, buildIndex(i, j, index++)));
        tmp.add(_buildSeparator(context, buildIndex(i, j, index++)));
      }
      tmp.removeLast();
      _children.add(tmp);
    }
  }

  Widget _buildMenu() {
    return PopupMenuButton(
      child: Icon(Icons.menu),
      onSelected: (index) {
        print("Scroll to section index $index");
        _scrollController.scrollToIndex(index,
            preferPosition: AutoScrollPosition.begin);
      },
      itemBuilder: (context) {
        List<PopupMenuEntry<int>> entries = [];
        for (var i = 0; i < _data.length; i++) {
          entries.add(PopupMenuItem(
            child: Text(_data[i].name),
            value: _sectionIndexes[i],
          ));
        }
        return entries;
      },
    );
  }

  Widget _buildSeparator(BuildContext context, IndexPath index) {
    return __wrap(
      index: index.absoluteIndex,
      child: Divider(
        height: 20.0,
        thickness: 1.0,
        indent: 20.0,
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, SectionPath index, bool isFloating) {
    final style = Theme.of(context).textTheme.headline6;
    return __wrap(
      index: index.absoluteIndex,
      disabled: isFloating,
      child: Container(
        height: 80.0,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.0),
        color: Theme.of(context).primaryColorDark,
        child: Text(_data[index.section].name,
            style: style.copyWith(color: Colors.white)),
      ),
    );
  }

  Widget _buildItem(BuildContext context, IndexPath index) {
    final item = _data[index.section][index.child];
    return __wrap(
      index: index.absoluteIndex,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        constraints: BoxConstraints(minHeight: 50.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(child: Text(item.console), width: 120.0),
            Expanded(child: Text(item.attribute)),
          ],
        ),
      ),
    );
  }
}
