import 'package:flutter/material.dart';

import 'classes/language.dart';
import 'classes/language_constants.dart';
import 'main.dart';

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
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli',
    'Daman and Diu',
    'Lakshadweep',
    'Delhi',
    'Puducherry',
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
            backgroundColor: Color(0xff38b9c5),
            onPressed: () {
              focusNode.requestFocus();
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color(0xff38b9c5),
            leading: SizedBox(),
            title: Text(
              translation(context).homePage,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<Language>(
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onChanged: (Language? language) async {
                    if (language != null) {
                      Locale _locale = await setLocale(language.languageCode);
                      MyApp.setLocale(context, _locale);
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
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
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(12, 26),
                      blurRadius: 50,
                      spreadRadius: 0,
                      color: Colors.grey.withOpacity(.1)),
                ]),
                child: TextField(
                  focusNode: focusNode,

                  // controller: textController,
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
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[500]!,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search here",
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w300),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[300]!, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[400]!, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, top: 10, bottom: 2),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 16,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          decoration: BoxDecoration(
                                            color: Color(0xff38b9c5),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(8.0),
                                                    bottomLeft:
                                                        Radius.circular(8.0),
                                                    bottomRight:
                                                        Radius.circular(8.0),
                                                    topRight:
                                                        Radius.circular(8.0)),
                                            // boxShadow: <BoxShadow>[
                                            //   BoxShadow(
                                            //       color: FitnessAppTheme.grey.withOpacity(0.2),
                                            //       offset: Offset(1.1, 1.1),
                                            //       blurRadius: 10.0),
                                            // ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 68,
                                                bottom: 12,
                                                right: 16,
                                                top: 12),
                                            child: Text(
                                              boxName[index],
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 19,
                                                  letterSpacing: 0.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -12,
                                        left: 0,
                                        child: SizedBox(
                                          width: 60,
                                          height: 80,
                                          child: Image.asset(
                                              "assets/images/3d-flag.png"),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )),
            ],
          ),
        ));
  }
}
