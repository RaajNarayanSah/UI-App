import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String dropDownValue = 'Home';
  FocusNode focusNode = FocusNode();
  List<DropdownMenuItem<String>> dropdownItems = [];
  List<String> drawer = [
    'Home',
    'About',
    'Contact us',
    'Setting',
    'Message',
    'Logout'
  ];
  List<String> boxName = [];
  final List<String> allBoxNameList = [
    'Ram',
    'Shyam',
    'Anand',
    'Tnbcd',
    'Cdef',
    'sadfasdf',
    'Bodfsdf',
    'dfgfdg',
    'Qerter',
    'Wvbnvbnv',
    'hjhjkh',
    'Rrtyr',
    'kjlk'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boxName = List.from(allBoxNameList);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            focusNode.requestFocus();
          },
          child: const Icon(Icons.search),
        ),
        drawer: Drawer(
          child: NavigationDrawer(
            // backgroundColor: Colors.black26,
            children: [
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                shrinkWrap: true,
                itemCount: drawer.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    color: Colors.orange.shade50,
                    child: Center(child: Text(drawer[index])),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ));
            },
          ),
          backgroundColor: Colors.blue,
          title: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Test App',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // height: 50,
              padding:
                  const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 3),
              child: Center(
                child: TextField(
                  focusNode: focusNode,
                  onChanged: (String? value) {
                    boxName.clear();
                    if (value == null) {
                      boxName.addAll(allBoxNameList);
                    } else {
                      // for (var i in allBoxNameList) {
                      //   if (i.toLowerCase().contains(value.toLowerCase())) {
                      //     boxName.add(i);
                      //   }
                      // }
                      List<String> newData = allBoxNameList
                          .where((element) => element
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      boxName.addAll(newData);
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Search Here',
                      hintStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.zero, color: Colors.black12),
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child:
                    //     Container(
                    //   height: 5,
                    //   width: 50,
                    //   color: Colors.red,
                    //   child: ListView.builder(
                    //     itemBuilder: (context, index) {
                    //       return ListTile(
                    //         title: Text("$index"),
                    //       );
                    //     },
                    //     itemCount: 20,
                    //   ),
                    // )

                    boxName.isEmpty
                        ? Center(
                            child: Text("No Result Found"),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: boxName.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.red.shade400,
                                margin: EdgeInsets.all(10),
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  // color: Colors.amber[500],
                                  child: Center(
                                      child: Text(
                                    boxName[index],
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  )),
                                ),
                              );
                            },
                          )),
            Container(
              height: 40,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 30.0),
              // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              // color: Colors.lightBlue,
              child: DropdownButton(
                  isDense: true,
                  elevation: 20,
                  dropdownColor: Colors.blue.shade100,
                  value: dropDownValue,
                  items: drawer.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  }),
            )

            // FloatingActionButton(
            //   onPressed: () {},
            //   child: Icon(Icons.add),
            // ),
          ],
        ),
      ),
    );
  }
}
