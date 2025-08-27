import 'package:flutter/material.dart';
class HotOfferItem extends StatelessWidget {
  final Map<String, String> offer;
  const HotOfferItem({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.asset(
              offer["image"]!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "${offer["title"]}\n${offer["description"]}",
                style:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
