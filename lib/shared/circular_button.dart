// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../core/app_theme.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    this.padding = 8,
    this.iconSize = 30,
    this.color = AppTheme.eclipse,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final double padding;
  final Color color;
  final VoidCallback onTap;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      focusColor: color.withAlpha(60),
      splashColor: color.withAlpha(60),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withAlpha(10),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Icon(
              icon,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}

/// OTHER OPTIONS
//   ClipOval(
//     child: Material(
//       color: color, // Button color
//       child: InkWell(
//         splashColor: splash, // Splash color
//         onTap: onTap,
//         child: SizedBox(
//             width: 56,
//             height: 56,
//             child: Icon(
//               icon,
//               size: 20,
//             )),
//       ),
//     ),
//   ),
// );

// FlatButton(
//       onPressed: () {
//        },
//       child:  Icon(
//         Ionicons.chevron_forward_outline,
//         color: Colors.white,
//         size: 20.0,
//       ),
//       shape:  CircleBorder(),
//       color: Colors.black12,
//     )
