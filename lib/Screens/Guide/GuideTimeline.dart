import 'package:flutter/material.dart';
import 'package:tt/Screens/Guide/AddPlaceGuide.dart';

class GuideTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        isExtended: true,
        icon: Icon(Icons.add),
        label: Text("Add"),
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPlaceGuide()));},
      ),
      appBar: AppBar(
        title: Text("Timeline"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(0.3)
                ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text("ST. clairs fall"),
                          trailing: Text("2018/07/12"),
                        ),
                        Container(
                          child: Image(
                              image:
                                  AssetImage('assets/images/stclairs.png')),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(
                              Icons.favorite,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
               Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text("Nine Arch"),
                          trailing: Text("2018/07/14"),
                        ),
                        Container(
                          child: Image(
                              image:
                                  AssetImage('assets/images/nine_arch.jpg')),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(
                              Icons.favorite,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0),),
               Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text("Upper Diyaluma"),
                          trailing: Text("2018/07/24"),
                        ),
                        Container(
                          child: Image(
                              image:
                                  AssetImage('assets/images/upper_diyaluma.jpg')),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(
                              Icons.favorite,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.all(8.0),
              ),
               Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text("Nine Arch"),
                          trailing: Text("2018/07/14"),
                        ),
                        Container(
                          child: Image(
                              image:
                                  AssetImage('assets/images/nine_arch.jpg')),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(
                              Icons.favorite,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0),),
               Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text("Chariot Path"),
                          trailing: Text("2018/08/24"),
                        ),
                        Container(
                          child: Image(
                              image:
                                  AssetImage('assets/images/chariot_path.jpg')),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(
                              Icons.favorite,
                            ),
                            onPressed: () {},
                            color: Colors.teal,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPlaceGuide()));
                            },
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
