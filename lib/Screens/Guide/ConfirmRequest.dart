import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/rendering.dart';

class ConfirmRequest extends StatefulWidget {

  @override
  State createState() {
    return ConfirmRequestState();
  }
}

class ConfirmRequestState extends State<ConfirmRequest> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Request"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withOpacity(0.3)
              ),
              child:Column(
        children: <Widget>[
          Card1(),
          Card1(),
          Card1(),
          Card1(),
        ],
      ),
            ),
          
      ),
    );
  }
}

class Card1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                  SizedBox(
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image: AssetImage("assets/images/pidurangala.jpg"),
                        fit: BoxFit.cover
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text("Prdiurangala",
                        style: Theme.of(context).textTheme.body2,
                      )
                      ),
                    ),
                    collapsed:RaisedButton(
                      onPressed: (){},
                      child: Text("Confirm Request"),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      color: Colors.teal,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          child: Column(
                            children: <Widget>[
                              Card(
                         child:ListTile(
                           leading: Text("Name of customer"),
                           trailing: Text("Neo"),
                         ),
                       ),
                       
                        Card(
                         child:ListTile(
                           leading: Text("'Date"),
                           trailing: Text("2019/06/03"),
                         ),
                       ),
                        Card(
                         child:ListTile(
                           leading: Text("No of people"),
                           trailing: Text("4"),
                         ),
                       ),
                       Center(
                         child:RaisedButton(
                      onPressed: (){},
                      child: Text("Confirm Request"),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      color: Colors.teal,
                    ) ,
                       )

                            ],
                          ),

                        ),
                        
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

