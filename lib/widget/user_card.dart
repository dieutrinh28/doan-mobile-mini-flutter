import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) editById;
  final Function(String) deleteById;

  const UserCard({
    Key? key,
    required this.index,
    required this.item,
    required this.editById,
    required this.deleteById,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = item['id'] as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${index + 1}'),
        ),
        title: Text(item['name']),
        subtitle: Text(item['email']),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              editById(item);
            } else if (value == 'delete') {
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
