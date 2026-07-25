import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Opens when the caption is tapped. Per the Figma annotations: opens
/// straight to the keyboard, and the Save button only lights up once the
/// text has actually changed.
class EditCaptionScreen extends StatefulWidget {
  final String initialCaption;
  const EditCaptionScreen({super.key, required this.initialCaption});

  @override
  State<EditCaptionScreen> createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCaption);
    _focusNode = FocusNode();
    _controller.addListener(() {
      final bool hasChanged = _controller.text != widget.initialCaption;
      if (hasChanged != _changed) setState(() => _changed = hasChanged);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = paletteOf(context);
    return Scaffold(
      backgroundColor: palette.scaffoldBg,
      appBar: AppBar(
        backgroundColor: palette.surface,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.close, color: palette.textPrimary), onPressed: () => Navigator.of(context).pop()),
        title: Text('Edit Caption', style: TextStyle(color: palette.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Center(
              child: TextButton(
                onPressed: _changed ? () => Navigator.of(context).pop(_controller.text) : null,
                style: TextButton.styleFrom(
                  backgroundColor: _changed ? AppColors.aiGreen : palette.divider,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: palette.textSecondary,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: null,
          expands: true,
          textAlignVertical: TextAlignVertical.top,
          style: TextStyle(fontSize: 14, color: palette.textPrimary, height: 1.4),
          cursorColor: AppColors.aiGreen,
          decoration: const InputDecoration(border: InputBorder.none, isCollapsed: true),
        ),
      ),
    );
  }
}
