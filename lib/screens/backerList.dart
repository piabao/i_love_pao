import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class backerList extends StatelessWidget {

  final GlobalKey<AnimatedListState> _listKey = new GlobalKey<AnimatedListState>();
  ListModel<int> _list;

  // Used to build list items that haven't been removed.
  Widget buildItem(BuildContext context, int index) {
    return new BackerItem(
      item: _list[index],
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Minhas Padarias'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new ListView.builder(itemBuilder: (BuildContext context, int index) => buildItem(context, index), itemCount: _list.length),
      ),
    );
  }
}

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = new List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
              (BuildContext context, Animation<double> animation) {
            return removedItemBuilder(removedItem, context, animation);
          });
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

class BackerItem extends StatelessWidget {
  const BackerItem(
      {Key key,
        this.onTap,
        @required this.item}):
        assert(item != null && item >= 0),
        super(key: key);

  final VoidCallback onTap;
  final int item;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Padding(
      padding: const EdgeInsets.all(2.0),
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: new SizedBox(
            height: 128.0,
            child: new Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: new Center(
                child: new Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
    );
  }
}