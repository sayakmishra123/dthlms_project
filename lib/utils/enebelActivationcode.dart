import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/utils/activationcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalDialog extends StatefulWidget {
  @override
  _GlobalDialogState createState() => _GlobalDialogState();
}

class _GlobalDialogState extends State<GlobalDialog> with TickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _blinkController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: FadeTransition(
        opacity: _animation,
        child: CustomMessageBubble(
          text: 'Enebel Activation Key!',
          color: Color(0xFF1B97F3),
          icon: Icons.info_outline,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class CustomMessageBubble extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final TextStyle textStyle;

  CustomMessageBubble({
    required this.text,
    required this.color,
    required this.icon,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: InkWell(
        onTap: (){
          Get.to(()=>ActivationCodePage());

          

        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(width: 8.0), // space between icon and text
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
