import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../models/smart_post.dart';
import '../theme/app_theme.dart';

class QuickShareRow extends StatelessWidget {
  final void Function(QuickShareApp app) onTapApp;

  const QuickShareRow({super.key, required this.onTapApp});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Quick share to:', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white)),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: DemoData.quickShareApps.map((app) {
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: InkWell(
                    onTap: () => onTapApp(app),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: app.gradient),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Icon(app.icon, size: 15, color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
