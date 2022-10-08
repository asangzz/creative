import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative/responsive/constant/dummy.dart';
import 'package:creative/responsive/view/component/category_row.dart';
import 'package:creative/responsive/view/component/header_widget.dart';
import 'package:creative/responsive/view/component/related_keyword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import '../entries/item_model.dart';
import '../services/functions/authFunction.dart';
import '../util/my_box.dart';
import '../util/my_tail.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold>
    with TickerProviderStateMixin {
  int selectedIndex = -1;
  int selectedSideBarCategory = -1;
  String selectedSubcategory = '';
  bool isExtraFeatures = false;

  List<Item> Items = [];
  bool isUploading = false;

  final db = FirebaseFirestore.instance;
  String? name;
  String? category;
  String? url;
  String? downloadUrl;
  Image? image;
  String? val = "";

  fetchRecord() async {
    var records =
        await FirebaseFirestore.instance.collection('Wordpress').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((item) => Item(
            name: item['name'],
            category: item['category'],
            url: item['url'],
            downloadUrl: item['downloadUrl']))
        .toList();

    setState(() {
      Items = _list;
    });
  }

  @override
  void initState() {
    fetchRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: defaultBackgroundColor,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(size: size),
                categoryWidget(size, categoryList),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filterSidebarWidget(sideBarCategoryList),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: defaultBackgroundColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: ListView(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //RelatedKeyword(relatedKeyword: relatedKeyword),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Wordpress Themes',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'See All',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                productCard(),
                                Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Shopify Themes',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'See All',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                productCard(),
                                Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Shopify Themes',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'See All',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                productCard(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded productCard() {
    return Expanded(
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: 3,
              //Items.length,
              itemBuilder: (context, index) {
                if (Items.isEmpty) {
                  return const CircularProgressIndicator();
                } else {
                  return Card(
                    elevation: 50,
                    color: Colors.black,
                    shadowColor: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://elements-cover-images-0.imgix.net/04ea21a3-285d-4996-bf53-4df5de093847?auto=compress%2Cformat&fit=max&w=433&s=e87a738402aee9205d5304145968dbfd"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            (Items[index].name),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text((Items[index].category)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  String url = Items[index].url;
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    print('error');
                                  }
                                },
                                child: const Text(
                                  'Preview',
                                  style: TextStyle(color: Colors.blueAccent),
                                )),
                            TextButton(
                                onPressed: () async {
                                  String url = Items[index].downloadUrl;
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    print('error');
                                  }
                                },
                                child: const Text(
                                  'Download',
                                  style: TextStyle(color: Colors.blueAccent),
                                )),
                            TextButton(
                                onPressed: () async {
                                  String email = 'creative@pixeltechindia.com';
                                  String subject =
                                      'License Request for' + Items[index].name;
                                  String body =
                                      'Note : License is provided once the endproduct is ready, please provide link of the end product to this mail :  ';

                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((MapEntry<String, String> e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  final Uri emailUri = Uri(
                                      scheme: 'mailto',
                                      path: email,
                                      query: encodeQueryParameters(<String,
                                          String>{
                                        'subject': subject,
                                        'body': body
                                      }));
                                  if (await canLaunch(emailUri.toString())) {
                                    launch(emailUri.toString());
                                  } else {
                                    print(Error());
                                  }
                                },
                                child: const Text(
                                  'Get License',
                                  style: TextStyle(color: Colors.blueAccent),
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              })),
    );
  }

  Expanded filterSidebarWidget(List<Map<String, dynamic>> sideBarCategoryList) {
    return Expanded(
      flex: 2,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 56,
              width: 300,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/entry');
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0xFF9DC2FF),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/svg/filter-variant.svg'),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Wordpress Themes',
                            style: TextStyle(
                              color: Color(0xFF2264D1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 56,
              width: 300,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/entry');
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0xFF9DC2FF),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/svg/filter-variant.svg'),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            'Shopify Themes',
                            style: TextStyle(
                              color: Color(0xFF2264D1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
              child: Container(
                height: isExtraFeatures ? null : 45,
                margin: const EdgeInsets.only(right: 30),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        isExtraFeatures = !isExtraFeatures;
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Licence Terms',
                            ),
                            RotatedBox(
                              quarterTurns: isExtraFeatures ? 25 : 0,
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isExtraFeatures)
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                            "The terms refers to the creator defines that the license of the products are only available to the creator once the end product is published"),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Padding categoryWidget(Size size, List<Map<String, dynamic>> categoryList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: SizedBox(
        height: 56,
        width: size.width - size.width * 0.05,
        child: ListView.builder(
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                selectedIndex = index;
                setState(() {});
              },
              child: Container(
                width: 144,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? Color.fromARGB(255, 43, 42, 87)
                      : Colors.black,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      categoryList[index]['icon'],
                      color: selectedIndex == index
                          ? const Color(0xFF2979FF)
                          : Color.fromARGB(255, 238, 134, 134),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      categoryList[index]['title'],
                      style: const TextStyle(
                        color: Color(0xFF2979FF),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

final List<String> imageList = [
  "a1.png",
  "a1.png",
  "a1.png",
];
