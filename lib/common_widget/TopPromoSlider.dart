// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class TopPromoSlider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: CarouselSlider(
//           options: CarouselOptions(
//             height: 150.0,
//             autoPlay: true,
//             enlargeCenterPage: true,
//             viewportFraction: 1.0, // Hiển thị toàn bộ ảnh
//             autoPlayInterval: Duration(seconds: 3),
//             autoPlayAnimationDuration: Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             scrollDirection: Axis.horizontal,
//           ),
//           items: [
//             "assets/images/promotion__one.png",
//             "assets/images/promotion_two.png",
//             "assets/images/promotion_three.png"
//           ].map((imagePath) {
//             return Image.asset(
//               imagePath,
//               fit: BoxFit.cover,
//               width: double.infinity,
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
