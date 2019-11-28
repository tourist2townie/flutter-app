import 'package:flutter/material.dart';

class AdminMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      InquiryList(),
      reports(),
      notification(),
    ];

    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.not_interested), title: Text("Inquiries")),
      BottomNavigationBarItem(icon: Icon(Icons.wifi), title: Text("Reports")),
      BottomNavigationBarItem(
          icon: Icon(Icons.notification_important),
          title: Text("notification")),
    ];
    assert(_kTabPages.length == _kBottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Admin"),
      ),
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }

  inquiries() {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text("Guide name:"),
            title: Text(
              "Neo",
              style: TextStyle(color: Colors.red),
            ),
            trailing: Text("4.5"),
          ),
        ],
      ),
    );
  }

  reports() {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text("Guide name:"),
            title: Text(
              "Neo",
              style: TextStyle(color: Colors.red),
            ),
            trailing: Text("4.5"),
          ),
        ],
      ),
    );
  }

  notification() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Text("This is notification"),
              ],
            ),
          ),
          ListTile(
            leading: Text("Guide name:"),
            title: Text(
              "Neo",
              style: TextStyle(color: Colors.red),
            ),
            trailing: Text("4.5"),
          ),
        ],
      ),
    );
  }
}

class InquiryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InquiryListState();
}

class InquiryListState extends State<InquiryList> {
  final _item = List<String>.generate(10, (i) => "Inquiry ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _item.length,
        itemBuilder: (context, index) {
          final String item = _item[index];

          return Dismissible(
            key: Key(item),
            onDismissed: (DismissDirection dir) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(dir == DismissDirection.startToEnd
                    ? '$item removed'
                    : '$item marked'),
                action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        this._item.insert(index, item);
                      });
                    }),
              ));
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.thumb_up),
              alignment: Alignment.centerRight,
            ),
            child: ListTile(
              title: Center(
                child: Text('${_item[index]}'),
              ),
            ),
          );
        });
  }
}
