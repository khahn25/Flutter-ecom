import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopularMenu extends StatelessWidget {
  final double width = 55.0;
  final double height = 55.0;
  final double customFontSize = 13;
  final String defaultFontFamily = 'Roboto';

  const PopularMenu({Key? key}) : super(key: key);

  Widget _buildMenuItem(IconData icon, Color color, String label, VoidCallback onTap) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: width,
          height: height,
          child: RawMaterialButton(
            onPressed: onTap,
            shape: const CircleBorder(),
            fillColor: const Color(0xFFF2F3F7),
            child: Icon(icon, color: color),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF969696),
            fontFamily: defaultFontFamily,
            fontSize: customFontSize,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          PopularMenuItem(
            icon: Icons.account_balance,
            color: Color(0xFFAB436B),
            label: "Popular",
          ),
          PopularMenuItem(
            icon: FontAwesomeIcons.clock,
            color: Color(0xFFC1A17C),
            label: "Flash Sell",
          ),
          PopularMenuItem(
            icon: FontAwesomeIcons.truck,
            color: Color(0xFF5EB699),
            label: "Evaly Store",
          ),
          PopularMenuItem(
            icon: FontAwesomeIcons.gift,
            color: Color(0xFF4D9DA7),
            label: "Voucher",
          ),
        ],
      ),
    );
  }
}

class PopularMenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const PopularMenuItem({
    Key? key,
    required this.icon,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 55,
          height: 55,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF2F3F7),
          ),
          child: RawMaterialButton(
            onPressed: () {},
            shape: const CircleBorder(),
            child: Icon(icon, color: color),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF969696),
            fontFamily: 'Roboto',
            fontSize: 13,
          ),
        )
      ],
    );
  }
}
