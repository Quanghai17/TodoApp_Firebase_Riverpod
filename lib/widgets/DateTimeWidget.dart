import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget(
      {super.key,
      required this.titleText,
      required this.valueText,
      required this.iconSection,
      required this.onTap});

  final String titleText;
  final String valueText;
  final IconData iconSection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 6,
          ),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () => onTap(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [Icon(iconSection), Text(valueText)],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
