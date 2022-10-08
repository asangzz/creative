import 'package:creative/constants.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Image(
                    image: AssetImage('assets/Creative_logo.png'),
                    height: 50,
                  ),
                ),
                SizedBox(
                  width: 26,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 44,
                  width: size.width * 0.35,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      suffixIcon: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            print('clear field');
                          },
                          child: const Icon(
                            Icons.close,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                SizedBox(
                  width: 100,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
