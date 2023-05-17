import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_gallery/controllers/settings_controller.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/views/font_page.dart';

class FontCard extends ConsumerWidget {
  const FontCard(
      {Key? key,
      required this.fontModel,
      required this.isSelected,
      required this.onCompareAction})
      : super(key: key);
  final FontModel fontModel;
  final bool isSelected;
  final VoidCallback onCompareAction;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeContext = Theme.of(context);
    final String displayText =
        ref.watch(settingsProvider.select((value) => value.displayText));
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => FontPage(fontModel: fontModel),
          ),
        );
      },
      child: Ink(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
        decoration: BoxDecoration(
          border: Border.all(color: themeContext.dividerColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fontModel.name,
                        style: themeContext.textTheme.titleMedium),
                    Text(
                      fontModel.author,
                      style: themeContext.textTheme.bodyMedium?.copyWith(
                          color: themeContext.textTheme.bodySmall?.color),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onCompareAction,
                  icon: (isSelected)
                      ? const Icon(Icons.remove)
                      : const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              displayText,
              style: fontModel.textStyle().copyWith(fontSize: 20),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
