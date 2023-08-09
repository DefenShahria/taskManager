import 'package:flutter/material.dart';
import 'package:module11/utils/taskListModel.dart';

class listdesign extends StatelessWidget {
  final VoidCallback onDeletTap, onEditTap;

  const listdesign({
    super.key,
    required this.data,
    required this.onDeletTap,
    required this.onEditTap,
  });

  final TaskData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? ''),
          Row(
            children: [
              Chip(
                  label: Text(
                    data.status ?? 'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.cyan),
              const Spacer(),
              IconButton(
                  onPressed: onDeletTap,
                  icon: Icon(Icons.delete_forever, color: Colors.black45)),
              IconButton(
                  onPressed: onEditTap,
                  icon: Icon(Icons.edit, color: Colors.cyanAccent)),
            ],
          )
        ],
      ),
    );
  }
}
